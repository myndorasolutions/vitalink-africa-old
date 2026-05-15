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

type labOrderRequest struct {
	PatientID   string   `json:"patient_id" binding:"required"`
	LabID       string   `json:"lab_id" binding:"required"`
	TestTypes   []string `json:"test_types" binding:"required"`
	ScheduledAt string   `json:"scheduled_at"`
}

func (h *Handler) LabCreateOrder(c *gin.Context) {
	var req labOrderRequest
	if !bindJSON(c, &req) {
		return
	}
	patientID, err := primitive.ObjectIDFromHex(req.PatientID)
	if err != nil {
		response.BadRequest(c, "invalid_id", "invalid patient_id")
		return
	}
	labID, err := primitive.ObjectIDFromHex(req.LabID)
	if err != nil {
		response.BadRequest(c, "invalid_id", "invalid lab_id")
		return
	}
	uid, ok := userObjectID(c)
	if !ok {
		return
	}
	order := models.LabOrder{
		PatientID:   patientID,
		ClinicianID: uid,
		LabID:       labID,
		TestTypes:   req.TestTypes,
		Status:      "ordered",
		CreatedAt:   time.Now().UTC(),
	}
	if req.ScheduledAt != "" {
		if t, err := time.Parse(time.RFC3339, req.ScheduledAt); err == nil {
			order.ScheduledAt = &t
		}
	}
	ctx := c.Request.Context()
	res, err := h.a.DB.Collection("lab_orders").InsertOne(ctx, order)
	if err != nil {
		response.Internal(c, "order create failed")
		return
	}
	order.ID = res.InsertedID.(primitive.ObjectID)
	response.Created(c, order)
}

func (h *Handler) LabListOrders(c *gin.Context) {
	uid, ok := userObjectID(c)
	if !ok {
		return
	}
	filter := bson.M{}
	role := middleware.GetRole(c)
	if role == models.RoleLab || c.Query("scope") == "lab" {
		var provider models.Provider
		if err := h.a.DB.Collection("providers").FindOne(c.Request.Context(), bson.M{"user_id": uid}).Decode(&provider); err == nil {
			filter["lab_id"] = provider.ID
		}
	} else {
		filter["clinician_id"] = uid
	}
	if status := c.Query("status"); status != "" {
		filter["status"] = status
	}
	cur, err := h.a.DB.Collection("lab_orders").Find(c.Request.Context(), filter)
	if err != nil {
		response.Internal(c, "list failed")
		return
	}
	var orders []models.LabOrder
	_ = cur.All(c.Request.Context(), &orders)
	response.OK(c, gin.H{"orders": orders})
}

type labResultsRequest struct {
	ResultURL   string `json:"result_url" binding:"required"`
	ResultNotes string `json:"result_notes"`
	IsAbnormal  bool   `json:"is_abnormal"`
}

func (h *Handler) LabUploadResults(c *gin.Context) {
	id, ok := parseObjectID(c, "id")
	if !ok {
		return
	}
	var req labResultsRequest
	if !bindJSON(c, &req) {
		return
	}
	ctx := c.Request.Context()
	update := bson.M{
		"status":       "completed",
		"result_url":   req.ResultURL,
		"result_notes": req.ResultNotes,
		"is_abnormal":  req.IsAbnormal,
	}
	_, err := h.a.DB.Collection("lab_orders").UpdateOne(ctx, bson.M{"_id": id}, bson.M{"$set": update})
	if err != nil {
		response.Internal(c, "update failed")
		return
	}
	var order models.LabOrder
	_ = h.a.DB.Collection("lab_orders").FindOne(ctx, bson.M{"_id": id}).Decode(&order)
	if req.IsAbnormal {
		alert := models.Alert{
			PatientID: order.PatientID,
			AlertType: "lab_abnormal",
			Severity:  "yellow",
			Message:   "Abnormal lab results uploaded",
		}
		_ = h.a.Alerts.Create(ctx, &alert)
	}
	response.OK(c, order)
}
