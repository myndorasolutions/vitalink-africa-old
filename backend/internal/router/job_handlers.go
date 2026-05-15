package router

import (
	"time"

	"github.com/gin-gonic/gin"
	"github.com/vitalink-africa/backend/internal/middleware"
	"github.com/vitalink-africa/backend/internal/models"
	"github.com/vitalink-africa/backend/internal/services_marketplace"
	"github.com/vitalink-africa/backend/pkg/pagination"
	"github.com/vitalink-africa/backend/pkg/response"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

type bookJobRequest struct {
	PatientID   string `json:"patient_id" binding:"required"`
	ProviderID  string `json:"provider_id" binding:"required"`
	ServiceID   string `json:"service_id" binding:"required"`
	ScheduledAt string `json:"scheduled_at" binding:"required"`
}

func (h *Handler) BookJob(c *gin.Context) {
	var req bookJobRequest
	if !bindJSON(c, &req) {
		return
	}
	patientID, err := primitive.ObjectIDFromHex(req.PatientID)
	if err != nil {
		response.BadRequest(c, "invalid_id", "invalid patient_id")
		return
	}
	providerID, err := primitive.ObjectIDFromHex(req.ProviderID)
	if err != nil {
		response.BadRequest(c, "invalid_id", "invalid provider_id")
		return
	}
	serviceID, err := primitive.ObjectIDFromHex(req.ServiceID)
	if err != nil {
		response.BadRequest(c, "invalid_id", "invalid service_id")
		return
	}
	scheduledAt, err := time.Parse(time.RFC3339, req.ScheduledAt)
	if err != nil {
		response.BadRequest(c, "invalid_time", "scheduled_at must be RFC3339")
		return
	}
	p, ok := h.loadPatient(c, patientID)
	if !ok || !h.requirePatientAccess(c, p) {
		return
	}
	ctx := c.Request.Context()
	var svc models.ProviderService
	if err := h.a.DB.Collection("provider_services").FindOne(ctx, bson.M{"_id": serviceID, "provider_id": providerID}).Decode(&svc); err != nil {
		response.NotFound(c, "service not found")
		return
	}
	var provider models.Provider
	_ = h.a.DB.Collection("providers").FindOne(ctx, bson.M{"_id": providerID}).Decode(&provider)
	commission, payout := commissionForProvider(h.a, provider.ProviderType, svc.PriceNaira)
	now := time.Now().UTC()
	job := models.ServiceJob{
		PatientID:          patientID,
		ProviderID:         providerID,
		ServiceType:        svc.ServiceType,
		ServiceID:          serviceID,
		ScheduledAt:        scheduledAt,
		Status:             "pending_payment",
		PriceNaira:         svc.PriceNaira,
		VitalinkCommission: commission,
		ProviderPayout:     payout,
		EscrowStatus:       services_marketplace.EscrowInitialized,
		CreatedAt:          now,
		UpdatedAt:          now,
	}
	res, err := h.a.DB.Collection("service_jobs").InsertOne(ctx, job)
	if err != nil {
		response.Internal(c, "booking failed")
		return
	}
	job.ID = res.InsertedID.(primitive.ObjectID)
	uid, _ := userObjectID(c)
	pid := patientID
	auditAction(ctx, h, uid, &pid, "job.booked", "service_job", job.ID.Hex(), nil, job, c)
	response.Created(c, job)
}

func (h *Handler) loadJob(c *gin.Context, id primitive.ObjectID) (*models.ServiceJob, bool) {
	var job models.ServiceJob
	err := h.a.DB.Collection("service_jobs").FindOne(c.Request.Context(), bson.M{"_id": id}).Decode(&job)
	if err == mongo.ErrNoDocuments {
		response.NotFound(c, "job not found")
		return nil, false
	}
	if err != nil {
		response.Internal(c, "lookup failed")
		return nil, false
	}
	return &job, true
}

func (h *Handler) providerOwnsJob(c *gin.Context, job *models.ServiceJob) bool {
	uid, ok := userObjectID(c)
	if !ok {
		return false
	}
	var provider models.Provider
	if err := h.a.DB.Collection("providers").FindOne(c.Request.Context(), bson.M{"user_id": uid}).Decode(&provider); err != nil {
		response.Forbidden(c, "not a provider")
		return false
	}
	if provider.ID != job.ProviderID {
		response.Forbidden(c, "not your job")
		return false
	}
	return true
}

func (h *Handler) AcceptJob(c *gin.Context) {
	id, ok := parseObjectID(c, "id")
	if !ok {
		return
	}
	job, ok := h.loadJob(c, id)
	if !ok || !h.providerOwnsJob(c, job) {
		return
	}
	if !services_marketplace.CanTransition(job.EscrowStatus, services_marketplace.EscrowAccepted) {
		response.BadRequest(c, "invalid_transition", "cannot accept job in current escrow state")
		return
	}
	ctx := c.Request.Context()
	update := bson.M{
		"status":        "accepted",
		"escrow_status": services_marketplace.EscrowAccepted,
		"updated_at":    time.Now().UTC(),
	}
	h.a.DB.Collection("service_jobs").UpdateOne(ctx, bson.M{"_id": id}, bson.M{"$set": update})
	job.EscrowStatus = services_marketplace.EscrowAccepted
	response.OK(c, job)
}

func (h *Handler) DeclineJob(c *gin.Context) {
	id, ok := parseObjectID(c, "id")
	if !ok {
		return
	}
	job, ok := h.loadJob(c, id)
	if !ok || !h.providerOwnsJob(c, job) {
		return
	}
	ctx := c.Request.Context()
	update := bson.M{"status": "declined", "escrow_status": services_marketplace.EscrowRefunded, "updated_at": time.Now().UTC()}
	h.a.DB.Collection("service_jobs").UpdateOne(ctx, bson.M{"_id": id}, bson.M{"$set": update})
	response.OK(c, gin.H{"job_id": id.Hex(), "status": "declined"})
}

func (h *Handler) CompleteJob(c *gin.Context) {
	id, ok := parseObjectID(c, "id")
	if !ok {
		return
	}
	job, ok := h.loadJob(c, id)
	if !ok || !h.providerOwnsJob(c, job) {
		return
	}
	next := services_marketplace.EscrowCompletedPendingConfirmation
	if !services_marketplace.CanTransition(job.EscrowStatus, next) {
		response.BadRequest(c, "invalid_transition", "cannot complete job in current escrow state")
		return
	}
	ctx := c.Request.Context()
	update := bson.M{
		"status":        "completed_pending",
		"escrow_status": next,
		"updated_at":    time.Now().UTC(),
	}
	h.a.DB.Collection("service_jobs").UpdateOne(ctx, bson.M{"_id": id}, bson.M{"$set": update})
	response.OK(c, gin.H{"job_id": id.Hex(), "escrow_status": next})
}

type confirmJobRequest struct {
	OTP string `json:"otp" binding:"required"`
}

func (h *Handler) ConfirmJobOTP(c *gin.Context) {
	id, ok := parseObjectID(c, "id")
	if !ok {
		return
	}
	var req confirmJobRequest
	if !bindJSON(c, &req) {
		return
	}
	job, ok := h.loadJob(c, id)
	if !ok {
		return
	}
	p, ok := h.loadPatient(c, job.PatientID)
	if !ok || !h.requirePatientAccess(c, p) {
		return
	}
	if job.CompletionOTP == "" || job.CompletionOTP != req.OTP {
		response.BadRequest(c, "invalid_otp", "invalid confirmation code")
		return
	}
	if !services_marketplace.CanTransition(job.EscrowStatus, services_marketplace.EscrowReleased) {
		response.BadRequest(c, "invalid_transition", "cannot release escrow")
		return
	}
	ctx := c.Request.Context()
	update := bson.M{
		"status":        "completed",
		"escrow_status": services_marketplace.EscrowReleased,
		"updated_at":    time.Now().UTC(),
	}
	h.a.DB.Collection("service_jobs").UpdateOne(ctx, bson.M{"_id": id}, bson.M{"$set": update})
	_, _ = h.a.DB.Collection("provider_wallets").UpdateOne(ctx,
		bson.M{"provider_id": job.ProviderID},
		bson.M{"$inc": bson.M{"available_balance": job.ProviderPayout, "pending_balance": -job.ProviderPayout}},
	)
	response.OK(c, gin.H{"job_id": id.Hex(), "escrow_status": services_marketplace.EscrowReleased})
}

type disputeJobRequest struct {
	Reason       string   `json:"reason" binding:"required"`
	EvidenceURLs []string `json:"evidence_urls"`
}

func (h *Handler) DisputeJob(c *gin.Context) {
	id, ok := parseObjectID(c, "id")
	if !ok {
		return
	}
	var req disputeJobRequest
	if !bindJSON(c, &req) {
		return
	}
	if _, ok := h.loadJob(c, id); !ok {
		return
	}
	uid, ok := userObjectID(c)
	if !ok {
		return
	}
	ctx := c.Request.Context()
	dispute := models.Dispute{
		JobID:          id,
		RaisedByUserID: uid,
		Reason:         req.Reason,
		EvidenceURLs:   req.EvidenceURLs,
		Status:         "open",
		CreatedAt:      time.Now().UTC(),
	}
	res, _ := h.a.DB.Collection("disputes").InsertOne(ctx, dispute)
	dispute.ID = res.InsertedID.(primitive.ObjectID)
	h.a.DB.Collection("service_jobs").UpdateOne(ctx, bson.M{"_id": id}, bson.M{"$set": bson.M{
		"escrow_status": services_marketplace.EscrowDisputed,
		"status":        "disputed",
		"updated_at":    time.Now().UTC(),
	}})
	response.Created(c, dispute)
}

func (h *Handler) GenerateJobOTP(c *gin.Context) {
	id, ok := parseObjectID(c, "id")
	if !ok {
		return
	}
	job, ok := h.loadJob(c, id)
	if !ok || !h.providerOwnsJob(c, job) {
		return
	}
	otp := generateOTP()
	ctx := c.Request.Context()
	h.a.DB.Collection("service_jobs").UpdateOne(ctx, bson.M{"_id": id}, bson.M{"$set": bson.M{
		"completion_otp": otp,
		"updated_at":     time.Now().UTC(),
	}})
	patient, err := h.a.Patients.FindByID(ctx, job.PatientID)
	if err == nil && patient.EmergencyContact.Phone != "" {
		h.a.Notifications.SendOTP(ctx, patient.EmergencyContact.Phone, otp)
	}
	response.OK(c, gin.H{"job_id": id.Hex(), "otp_sent": true})
}

func (h *Handler) GetJob(c *gin.Context) {
	id, ok := parseObjectID(c, "id")
	if !ok {
		return
	}
	job, ok := h.loadJob(c, id)
	if !ok {
		return
	}
	p, ok := h.loadPatient(c, job.PatientID)
	if !ok {
		return
	}
	role := middleware.GetRole(c)
	uid, _ := userObjectID(c)
	if !h.a.Access.CanAccessPatient(c.Request.Context(), role, uid, p) {
		var provider models.Provider
		if err := h.a.DB.Collection("providers").FindOne(c.Request.Context(), bson.M{"user_id": uid}).Decode(&provider); err != nil || provider.ID != job.ProviderID {
			response.Forbidden(c, "no access")
			return
		}
	}
	response.OK(c, job)
}

func (h *Handler) ListJobs(c *gin.Context) {
	uid, ok := userObjectID(c)
	if !ok {
		return
	}
	role := middleware.GetRole(c)
	pg := pagination.FromContext(c)
	filter := bson.M{}
	ctx := c.Request.Context()
	switch role {
	case models.RolePatient, models.RoleCaregiver:
		ids, _ := h.a.Access.GetAccessiblePatientIDs(ctx, role, uid)
		if len(ids) == 0 {
			response.OK(c, gin.H{"jobs": []models.ServiceJob{}})
			return
		}
		filter["patient_id"] = bson.M{"$in": ids}
	default:
		var provider models.Provider
		if err := h.a.DB.Collection("providers").FindOne(ctx, bson.M{"user_id": uid}).Decode(&provider); err == nil {
			filter["provider_id"] = provider.ID
		}
	}
	opts := options.Find().SetSkip(pg.Skip).SetLimit(pg.Limit).SetSort(bson.M{"created_at": -1})
	cur, err := h.a.DB.Collection("service_jobs").Find(ctx, filter, opts)
	if err != nil {
		response.Internal(c, "list failed")
		return
	}
	var jobs []models.ServiceJob
	_ = cur.All(ctx, &jobs)
	response.OK(c, gin.H{"jobs": jobs, "page": pg.Page, "limit": pg.Limit})
}
