package router

import (
	"time"

	"github.com/gin-gonic/gin"
	"github.com/vitalink-africa/backend/internal/middleware"
	"github.com/vitalink-africa/backend/internal/models"
	"github.com/vitalink-africa/backend/pkg/response"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

type requestRefillBody struct {
	PatientID      string `json:"patient_id" binding:"required"`
	PrescriptionID string `json:"prescription_id" binding:"required"`
	MedicationName string `json:"medication_name" binding:"required"`
}

func (h *Handler) RequestPharmacyRefill(c *gin.Context) {
	var req requestRefillBody
	if !bindJSON(c, &req) {
		return
	}
	patientID, err := primitive.ObjectIDFromHex(req.PatientID)
	if err != nil {
		response.BadRequest(c, "invalid_id", "invalid patient_id")
		return
	}
	prescriptionID, err := primitive.ObjectIDFromHex(req.PrescriptionID)
	if err != nil {
		response.BadRequest(c, "invalid_id", "invalid prescription_id")
		return
	}
	p, ok := h.loadPatient(c, patientID)
	if !ok || !h.requirePatientAccess(c, p) {
		return
	}
	var pharmacyID primitive.ObjectID
	if p.AssignedPharmacyID != nil {
		pharmacyID = *p.AssignedPharmacyID
	}
	refill := models.PharmacyRefill{
		PatientID:        patientID,
		PrescriptionID:   prescriptionID,
		PharmacyID:       pharmacyID,
		MedicationName:   req.MedicationName,
		Status:           "requested",
		PickupOTP:        generateOTP(),
		IdentityVerified: false,
		RequestedAt:      time.Now().UTC(),
	}
	ctx := c.Request.Context()
	res, err := h.a.DB.Collection("pharmacy_refills").InsertOne(ctx, refill)
	if err != nil {
		response.Internal(c, "refill request failed")
		return
	}
	refill.ID = res.InsertedID.(primitive.ObjectID)
	response.Created(c, refill)
}

func (h *Handler) ListPharmacyRefills(c *gin.Context) {
	ctx := c.Request.Context()
	uid, ok := userObjectID(c)
	if !ok {
		return
	}
	filter := bson.M{}
	role := middleware.GetRole(c)
	switch role {
	case models.RolePharmacy:
		var provider models.Provider
		if err := h.a.DB.Collection("providers").FindOne(ctx, bson.M{"user_id": uid}).Decode(&provider); err == nil {
			filter["pharmacy_id"] = provider.ID
		}
	case models.RolePatient, models.RoleCaregiver:
		ids, _ := h.a.Access.GetAccessiblePatientIDs(ctx, role, uid)
		if len(ids) > 0 {
			filter["patient_id"] = bson.M{"$in": ids}
		}
	}
	if status := c.Query("status"); status != "" {
		filter["status"] = status
	}
	cur, err := h.a.DB.Collection("pharmacy_refills").Find(ctx, filter)
	if err != nil {
		response.Internal(c, "list failed")
		return
	}
	var refills []models.PharmacyRefill
	_ = cur.All(ctx, &refills)
	response.OK(c, gin.H{"refills": refills})
}

type fulfillRefillRequest struct {
	PickupOTP string `json:"pickup_otp" binding:"required"`
}

func (h *Handler) FulfillPharmacyRefill(c *gin.Context) {
	id, ok := parseObjectID(c, "id")
	if !ok {
		return
	}
	var req fulfillRefillRequest
	if !bindJSON(c, &req) {
		return
	}
	ctx := c.Request.Context()
	var refill models.PharmacyRefill
	if err := h.a.DB.Collection("pharmacy_refills").FindOne(ctx, bson.M{"_id": id}).Decode(&refill); err != nil {
		response.NotFound(c, "refill not found")
		return
	}
	if refill.PickupOTP != req.PickupOTP {
		response.BadRequest(c, "invalid_otp", "invalid pickup OTP")
		return
	}
	now := time.Now().UTC()
	_, err := h.a.DB.Collection("pharmacy_refills").UpdateOne(ctx, bson.M{"_id": id}, bson.M{"$set": bson.M{
		"status":            "fulfilled",
		"identity_verified": true,
		"fulfilled_at":      now,
	}})
	if err != nil {
		response.Internal(c, "fulfill failed")
		return
	}
	refill.Status = "fulfilled"
	refill.FulfilledAt = &now
	response.OK(c, refill)
}
