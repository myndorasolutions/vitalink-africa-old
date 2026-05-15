package router

import (
	"time"

	"github.com/gin-gonic/gin"
	"github.com/vitalink-africa/backend/internal/models"
	"github.com/vitalink-africa/backend/pkg/response"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

type grantConsentRequest struct {
	PatientID       string `json:"patient_id" binding:"required"`
	GrantedToUserID string `json:"granted_to_user_id" binding:"required"`
	ConsentType     string `json:"consent_type" binding:"required"`
	Version         string `json:"version"`
}

func (h *Handler) GrantConsent(c *gin.Context) {
	var req grantConsentRequest
	if !bindJSON(c, &req) {
		return
	}
	patientID, err := primitive.ObjectIDFromHex(req.PatientID)
	if err != nil {
		response.BadRequest(c, "invalid_id", "invalid patient_id")
		return
	}
	grantedTo, err := primitive.ObjectIDFromHex(req.GrantedToUserID)
	if err != nil {
		response.BadRequest(c, "invalid_id", "invalid granted_to_user_id")
		return
	}
	p, ok := h.loadPatient(c, patientID)
	if !ok || !h.requirePatientAccess(c, p) {
		return
	}
	version := req.Version
	if version == "" {
		version = "1.0"
	}
	record := models.ConsentRecord{
		PatientID:       patientID,
		GrantedToUserID: grantedTo,
		ConsentType:     req.ConsentType,
		Version:         version,
		Status:          "active",
		GrantedAt:       time.Now().UTC(),
		IPAddress:       clientIP(c),
	}
	ctx := c.Request.Context()
	res, err := h.a.DB.Collection("consent_records").InsertOne(ctx, record)
	if err != nil {
		response.Internal(c, "grant failed")
		return
	}
	record.ID = res.InsertedID.(primitive.ObjectID)
	response.Created(c, record)
}

type revokeConsentRequest struct {
	ConsentID string `json:"consent_id" binding:"required"`
}

func (h *Handler) RevokeConsent(c *gin.Context) {
	var req revokeConsentRequest
	if !bindJSON(c, &req) {
		return
	}
	consentID, err := primitive.ObjectIDFromHex(req.ConsentID)
	if err != nil {
		response.BadRequest(c, "invalid_id", "invalid consent_id")
		return
	}
	ctx := c.Request.Context()
	var record models.ConsentRecord
	if err := h.a.DB.Collection("consent_records").FindOne(ctx, bson.M{"_id": consentID}).Decode(&record); err != nil {
		response.NotFound(c, "consent not found")
		return
	}
	p, ok := h.loadPatient(c, record.PatientID)
	if !ok || !h.requirePatientAccess(c, p) {
		return
	}
	now := time.Now().UTC()
	_, err = h.a.DB.Collection("consent_records").UpdateOne(ctx, bson.M{"_id": consentID}, bson.M{"$set": bson.M{
		"status": "revoked", "revoked_at": now,
	}})
	if err != nil {
		response.Internal(c, "revoke failed")
		return
	}
	record.Status = "revoked"
	record.RevokedAt = &now
	response.OK(c, record)
}

func (h *Handler) ListConsent(c *gin.Context) {
	filter := bson.M{"status": "active"}
	if pid := c.Query("patient_id"); pid != "" {
		if id, err := primitive.ObjectIDFromHex(pid); err == nil {
			p, ok := h.loadPatient(c, id)
			if !ok || !h.requirePatientAccess(c, p) {
				return
			}
			filter["patient_id"] = id
		}
	}
	cur, err := h.a.DB.Collection("consent_records").Find(c.Request.Context(), filter)
	if err != nil {
		response.Internal(c, "list failed")
		return
	}
	var records []models.ConsentRecord
	_ = cur.All(c.Request.Context(), &records)
	response.OK(c, gin.H{"consents": records})
}
