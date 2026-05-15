package router

import (
	"time"

	"github.com/gin-gonic/gin"
	"github.com/vitalink-africa/backend/internal/models"
	"github.com/vitalink-africa/backend/pkg/response"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

type authorizeHelperRequest struct {
	PatientID    string `json:"patient_id" binding:"required"`
	HelperName   string `json:"helper_name" binding:"required"`
	Phone        string `json:"phone" binding:"required"`
	Relationship string `json:"relationship" binding:"required"`
}

func (h *Handler) AuthorizeHelper(c *gin.Context) {
	var req authorizeHelperRequest
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
	helper := models.AuthorizedHelper{
		PatientID:     patientID,
		HelperName:    req.HelperName,
		Phone:         req.Phone,
		Relationship:  req.Relationship,
		ConsentStatus: "approved",
		CreatedAt:     time.Now().UTC(),
	}
	ctx := c.Request.Context()
	res, err := h.a.DB.Collection("authorized_helpers").InsertOne(ctx, helper)
	if err != nil {
		response.Internal(c, "failed to authorize helper")
		return
	}
	helper.ID = res.InsertedID.(primitive.ObjectID)
	uid, _ := userObjectID(c)
	pid := patientID
	auditAction(ctx, h, uid, &pid, "helper.authorized", "authorized_helper", helper.ID.Hex(), nil, helper, c)
	response.Created(c, helper)
}

func (h *Handler) ListHelpers(c *gin.Context) {
	patientIDStr := c.Query("patient_id")
	if patientIDStr == "" {
		response.BadRequest(c, "missing_param", "patient_id query required")
		return
	}
	patientID, err := primitive.ObjectIDFromHex(patientIDStr)
	if err != nil {
		response.BadRequest(c, "invalid_id", "invalid patient_id")
		return
	}
	p, ok := h.loadPatient(c, patientID)
	if !ok || !h.requirePatientAccess(c, p) {
		return
	}
	ctx := c.Request.Context()
	cur, err := h.a.DB.Collection("authorized_helpers").Find(ctx, bson.M{
		"patient_id": patientID, "consent_status": "approved",
	})
	if err != nil {
		response.Internal(c, "query failed")
		return
	}
	var helpers []models.AuthorizedHelper
	if err := cur.All(ctx, &helpers); err != nil {
		response.Internal(c, "decode failed")
		return
	}
	response.OK(c, gin.H{"helpers": helpers})
}

func (h *Handler) RevokeHelper(c *gin.Context) {
	id, ok := parseObjectID(c, "id")
	if !ok {
		return
	}
	ctx := c.Request.Context()
	var helper models.AuthorizedHelper
	if err := h.a.DB.Collection("authorized_helpers").FindOne(ctx, bson.M{"_id": id}).Decode(&helper); err != nil {
		response.NotFound(c, "helper not found")
		return
	}
	p, ok := h.loadPatient(c, helper.PatientID)
	if !ok || !h.requirePatientAccess(c, p) {
		return
	}
	_, err := h.a.DB.Collection("authorized_helpers").UpdateOne(ctx, bson.M{"_id": id},
		bson.M{"$set": bson.M{"consent_status": "revoked"}})
	if err != nil {
		response.Internal(c, "revoke failed")
		return
	}
	uid, _ := userObjectID(c)
	pid := helper.PatientID
	auditAction(ctx, h, uid, &pid, "helper.revoked", "authorized_helper", id.Hex(), helper, nil, c)
	noContent(c)
}
