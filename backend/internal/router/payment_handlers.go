package router

import (
	"encoding/json"
	"fmt"
	"io"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"github.com/vitalink-africa/backend/internal/models"
	"github.com/vitalink-africa/backend/internal/platform"
	"github.com/vitalink-africa/backend/internal/services_marketplace"
	"github.com/vitalink-africa/backend/pkg/pagination"
	"github.com/vitalink-africa/backend/pkg/response"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo/options"
)

type initializePaymentRequest struct {
	AmountNaira int64  `json:"amount_naira" binding:"required"`
	Type        string `json:"type" binding:"required"`
	PatientID   string `json:"patient_id"`
	JobID       string `json:"job_id"`
	Plan        string `json:"plan"`
}

func (h *Handler) InitializePayment(c *gin.Context) {
	var req initializePaymentRequest
	if !bindJSON(c, &req) {
		return
	}
	uid, ok := userObjectID(c)
	if !ok {
		return
	}
	ctx := c.Request.Context()
	user, err := h.a.Users.FindByID(ctx, uid)
	if err != nil {
		response.Internal(c, "user lookup failed")
		return
	}
	ref := fmt.Sprintf("vl_%s", uuid.New().String())
	amountKobo := req.AmountNaira * 100
	meta := map[string]string{"type": req.Type, "user_id": uid.Hex()}
	if req.PatientID != "" {
		meta["patient_id"] = req.PatientID
	}
	if req.JobID != "" {
		meta["job_id"] = req.JobID
	}
	initResp, err := h.a.Paystack.Initialize(ctx, platform.PaymentInitRequest{
		Email:       user.Email,
		AmountKobo:  amountKobo,
		Reference:   ref,
		CallbackURL: h.a.Config.AppBaseURL + "/api/v1/payments/callback",
		Metadata:    meta,
	})
	if err != nil {
		response.Internal(c, "payment initialization failed")
		return
	}
	var patientID *primitive.ObjectID
	if req.PatientID != "" {
		if pid, err := primitive.ObjectIDFromHex(req.PatientID); err == nil {
			patientID = &pid
		}
	}
	var jobID *primitive.ObjectID
	if req.JobID != "" {
		if jid, err := primitive.ObjectIDFromHex(req.JobID); err == nil {
			jobID = &jid
		}
	}
	payment := models.Payment{
		UserID:            uid,
		PatientID:         patientID,
		Type:              req.Type,
		AmountNaira:       req.AmountNaira,
		Currency:          "NGN",
		Status:            "pending",
		PaystackReference: ref,
		JobID:             jobID,
		CreatedAt:         time.Now().UTC(),
	}
	res, _ := h.a.DB.Collection("payments").InsertOne(ctx, payment)
	payment.ID = res.InsertedID.(primitive.ObjectID)
	response.OK(c, gin.H{
		"authorization_url": initResp.AuthorizationURL,
		"reference":         initResp.Reference,
		"payment_id":        payment.ID.Hex(),
	})
}

func (h *Handler) PaymentWebhook(c *gin.Context) {
	body, err := io.ReadAll(c.Request.Body)
	if err != nil {
		response.BadRequest(c, "invalid_body", "cannot read body")
		return
	}
	sig := c.GetHeader("X-Paystack-Signature")
	if !h.a.Paystack.VerifyWebhookSignature(body, sig) {
		response.Forbidden(c, "invalid signature")
		return
	}
	var payload struct {
		Event string `json:"event"`
		Data  struct {
			Reference string            `json:"reference"`
			Status    string            `json:"status"`
			Metadata  map[string]string `json:"metadata"`
		} `json:"data"`
	}
	if err := json.Unmarshal(body, &payload); err != nil {
		response.BadRequest(c, "invalid_json", "invalid webhook payload")
		return
	}
	if payload.Event != "charge.success" {
		response.OK(c, gin.H{"received": true})
		return
	}
	ctx := c.Request.Context()
	var payment models.Payment
	if err := h.a.DB.Collection("payments").FindOne(ctx, bson.M{"paystack_reference": payload.Data.Reference}).Decode(&payment); err != nil {
		response.OK(c, gin.H{"received": true})
		return
	}
	h.a.DB.Collection("payments").UpdateOne(ctx, bson.M{"_id": payment.ID}, bson.M{"$set": bson.M{
		"status": "success", "paystack_response": payload.Data,
	}})
	if payment.JobID != nil {
		h.a.DB.Collection("service_jobs").UpdateOne(ctx, bson.M{"_id": *payment.JobID}, bson.M{"$set": bson.M{
			"escrow_status":     services_marketplace.EscrowPaidHeld,
			"status":            "paid",
			"payment_reference": payload.Data.Reference,
			"updated_at":        time.Now().UTC(),
		}})
	}
	if payment.Type == "subscription" && payment.PatientID != nil {
		h.a.Patients.Update(ctx, *payment.PatientID, bson.M{
			"subscription_status": "active",
			"subscription_plan":   payload.Data.Metadata["plan"],
		})
	}
	response.OK(c, gin.H{"received": true})
}

func (h *Handler) PaymentHistory(c *gin.Context) {
	uid, ok := userObjectID(c)
	if !ok {
		return
	}
	pg := pagination.FromContext(c)
	opts := options.Find().SetSkip(pg.Skip).SetLimit(pg.Limit).SetSort(bson.M{"created_at": -1})
	cur, err := h.a.DB.Collection("payments").Find(c.Request.Context(), bson.M{"user_id": uid}, opts)
	if err != nil {
		response.Internal(c, "list failed")
		return
	}
	var payments []models.Payment
	_ = cur.All(c.Request.Context(), &payments)
	response.OK(c, gin.H{"payments": payments, "page": pg.Page, "limit": pg.Limit})
}

type createSubscriptionRequest struct {
	PatientID    string `json:"patient_id" binding:"required"`
	Plan         string `json:"plan" binding:"required"`
	PriceNaira   int64  `json:"price_naira" binding:"required"`
	BillingCycle string `json:"billing_cycle"`
}

func (h *Handler) CreateSubscription(c *gin.Context) {
	var req createSubscriptionRequest
	if !bindJSON(c, &req) {
		return
	}
	patientID, err := primitive.ObjectIDFromHex(req.PatientID)
	if err != nil {
		response.BadRequest(c, "invalid_id", "invalid patient_id")
		return
	}
	p, ok := h.loadPatient(c, patientID)
	if !ok || !h.requirePatientAccess(c, p) {
		return
	}
	uid, _ := userObjectID(c)
	now := time.Now().UTC()
	expires := now.AddDate(0, 1, 0)
	if req.BillingCycle == "yearly" {
		expires = now.AddDate(1, 0, 0)
	}
	sub := models.Subscription{
		PatientID:    patientID,
		PayerUserID:  uid,
		Plan:         req.Plan,
		PriceNaira:   req.PriceNaira,
		BillingCycle: req.BillingCycle,
		Status:       "pending",
		StartedAt:    now,
		ExpiresAt:    expires,
		CreatedAt:    now,
	}
	ctx := c.Request.Context()
	res, err := h.a.DB.Collection("subscriptions").InsertOne(ctx, sub)
	if err != nil {
		response.Internal(c, "subscription create failed")
		return
	}
	sub.ID = res.InsertedID.(primitive.ObjectID)
	response.Created(c, sub)
}

func (h *Handler) ListSubscriptions(c *gin.Context) {
	uid, ok := userObjectID(c)
	if !ok {
		return
	}
	filter := bson.M{"payer_user_id": uid}
	if pid := c.Query("patient_id"); pid != "" {
		if id, err := primitive.ObjectIDFromHex(pid); err == nil {
			filter["patient_id"] = id
		}
	}
	cur, err := h.a.DB.Collection("subscriptions").Find(c.Request.Context(), filter)
	if err != nil {
		response.Internal(c, "list failed")
		return
	}
	var subs []models.Subscription
	_ = cur.All(c.Request.Context(), &subs)
	response.OK(c, gin.H{"subscriptions": subs})
}
