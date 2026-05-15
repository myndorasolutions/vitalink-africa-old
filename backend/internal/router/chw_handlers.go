package router

import (
	"time"

	"github.com/gin-gonic/gin"
	"github.com/vitalink-africa/backend/internal/models"
	"github.com/vitalink-africa/backend/pkg/response"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

func (h *Handler) CHWPatients(c *gin.Context) {
	uid, ok := userObjectID(c)
	if !ok {
		return
	}
	ctx := c.Request.Context()
	cur, err := h.a.DB.Collection("patients").Find(ctx, bson.M{
		"assigned_chw_id": uid,
		"is_active":       true,
	})
	if err != nil {
		response.Internal(c, "query failed")
		return
	}
	var patients []models.Patient
	_ = cur.All(ctx, &patients)
	response.OK(c, gin.H{"patients": patients})
}

type chwVisitRequest struct {
	PatientID  string `json:"patient_id" binding:"required"`
	VisitType  string `json:"visit_type" binding:"required"`
	VisitDate  string `json:"visit_date" binding:"required"`
	Notes      string `json:"notes"`
	JobID      string `json:"job_id"`
	Escalated  bool   `json:"escalated"`
	EscalationReason string `json:"escalation_reason"`
}

func (h *Handler) CHWCreateVisit(c *gin.Context) {
	var req chwVisitRequest
	if !bindJSON(c, &req) {
		return
	}
	patientID, err := primitive.ObjectIDFromHex(req.PatientID)
	if err != nil {
		response.BadRequest(c, "invalid_id", "invalid patient_id")
		return
	}
	visitDate, err := time.Parse(time.RFC3339, req.VisitDate)
	if err != nil {
		response.BadRequest(c, "invalid_time", "visit_date must be RFC3339")
		return
	}
	uid, ok := userObjectID(c)
	if !ok {
		return
	}
	visit := models.CHWVisit{
		PatientID: patientID,
		CHWID:     uid,
		VisitType: req.VisitType,
		VisitDate: visitDate,
		Notes:     req.Notes,
		Escalated: req.Escalated,
		EscalationReason: req.EscalationReason,
		CreatedAt: time.Now().UTC(),
	}
	if req.JobID != "" {
		if jid, err := primitive.ObjectIDFromHex(req.JobID); err == nil {
			visit.JobID = &jid
		}
	}
	ctx := c.Request.Context()
	res, err := h.a.DB.Collection("chw_visits").InsertOne(ctx, visit)
	if err != nil {
		response.Internal(c, "visit create failed")
		return
	}
	visit.ID = res.InsertedID.(primitive.ObjectID)
	response.Created(c, visit)
}

func (h *Handler) CHWListVisits(c *gin.Context) {
	uid, ok := userObjectID(c)
	if !ok {
		return
	}
	filter := bson.M{"chw_id": uid}
	if pid := c.Query("patient_id"); pid != "" {
		if id, err := primitive.ObjectIDFromHex(pid); err == nil {
			filter["patient_id"] = id
		}
	}
	cur, err := h.a.DB.Collection("chw_visits").Find(c.Request.Context(), filter)
	if err != nil {
		response.Internal(c, "list failed")
		return
	}
	var visits []models.CHWVisit
	_ = cur.All(c.Request.Context(), &visits)
	response.OK(c, gin.H{"visits": visits})
}
