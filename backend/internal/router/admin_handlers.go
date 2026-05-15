package router

import (
	"time"

	"github.com/gin-gonic/gin"
	"github.com/vitalink-africa/backend/internal/models"
	"github.com/vitalink-africa/backend/pkg/pagination"
	"github.com/vitalink-africa/backend/pkg/response"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo/options"
)

func (h *Handler) AdminDashboard(c *gin.Context) {
	ctx := c.Request.Context()
	patients, _ := h.a.Patients.Count(ctx, bson.M{"is_active": true})
	openAlerts, _ := h.a.Alerts.Count(ctx, bson.M{"status": "open"})
	jobs, _ := h.a.DB.Collection("service_jobs").CountDocuments(ctx, bson.M{"status": bson.M{"$in": []string{"accepted", "completed_pending"}}})
	disputes, _ := h.a.DB.Collection("disputes").CountDocuments(ctx, bson.M{"status": "open"})
	response.OK(c, gin.H{
		"active_patients":   patients,
		"open_alerts":       openAlerts,
		"active_jobs":       jobs,
		"open_disputes":     disputes,
		"generated_at":      time.Now().UTC(),
	})
}

func (h *Handler) AdminListDisputes(c *gin.Context) {
	pg := pagination.FromContext(c)
	filter := bson.M{}
	if status := c.Query("status"); status != "" {
		filter["status"] = status
	}
	opts := options.Find().SetSkip(pg.Skip).SetLimit(pg.Limit).SetSort(bson.M{"created_at": -1})
	cur, err := h.a.DB.Collection("disputes").Find(c.Request.Context(), filter, opts)
	if err != nil {
		response.Internal(c, "list failed")
		return
	}
	var disputes []models.Dispute
	_ = cur.All(c.Request.Context(), &disputes)
	response.OK(c, gin.H{"disputes": disputes, "page": pg.Page, "limit": pg.Limit})
}

type resolveDisputeRequest struct {
	Status     string `json:"status" binding:"required"`
	AdminNotes string `json:"admin_notes"`
}

func (h *Handler) AdminResolveDispute(c *gin.Context) {
	id, ok := parseObjectID(c, "id")
	if !ok {
		return
	}
	var req resolveDisputeRequest
	if !bindJSON(c, &req) {
		return
	}
	uid, ok := userObjectID(c)
	if !ok {
		return
	}
	now := time.Now().UTC()
	update := bson.M{
		"status":      req.Status,
		"admin_notes": req.AdminNotes,
		"resolved_by": uid,
		"resolved_at": now,
	}
	ctx := c.Request.Context()
	_, err := h.a.DB.Collection("disputes").UpdateOne(ctx, bson.M{"_id": id}, bson.M{"$set": update})
	if err != nil {
		response.Internal(c, "resolve failed")
		return
	}
	var dispute models.Dispute
	_ = h.a.DB.Collection("disputes").FindOne(ctx, bson.M{"_id": id}).Decode(&dispute)
	response.OK(c, dispute)
}

func (h *Handler) AdminReports(c *gin.Context) {
	ctx := c.Request.Context()
	reportType := c.DefaultQuery("type", "summary")
	switch reportType {
	case "alerts":
		red, _ := h.a.Alerts.Count(ctx, bson.M{"severity": "red"})
		yellow, _ := h.a.Alerts.Count(ctx, bson.M{"severity": "yellow"})
		green, _ := h.a.Alerts.Count(ctx, bson.M{"severity": "green"})
		response.OK(c, gin.H{"type": "alerts", "data": gin.H{"red": red, "yellow": yellow, "green": green}})
	default:
		patients, _ := h.a.Patients.Count(ctx, bson.M{})
		vitals, _ := h.a.DB.Collection("vitals").CountDocuments(ctx, bson.M{})
		payments, _ := h.a.DB.Collection("payments").CountDocuments(ctx, bson.M{"status": "success"})
		response.OK(c, gin.H{
			"type":     "summary",
			"patients": patients,
			"vitals":   vitals,
			"payments": payments,
		})
	}
}

func (h *Handler) AdminAuditLogs(c *gin.Context) {
	pg := pagination.FromContext(c)
	filter := bson.M{}
	if action := c.Query("action"); action != "" {
		filter["action"] = action
	}
	if pid := c.Query("patient_id"); pid != "" {
		if id, err := primitive.ObjectIDFromHex(pid); err == nil {
			filter["patient_id"] = id
		}
	}
	opts := options.Find().SetSkip(pg.Skip).SetLimit(pg.Limit).SetSort(bson.M{"created_at": -1})
	cur, err := h.a.DB.Collection("audit_logs").Find(c.Request.Context(), filter, opts)
	if err != nil {
		response.Internal(c, "audit list failed")
		return
	}
	var logs []models.AuditLog
	_ = cur.All(c.Request.Context(), &logs)
	response.OK(c, gin.H{"logs": logs, "page": pg.Page, "limit": pg.Limit})
}

func (h *Handler) AdminListFeatureFlags(c *gin.Context) {
	cur, err := h.a.DB.Collection("feature_flags").Find(c.Request.Context(), bson.M{})
	if err != nil {
		response.Internal(c, "list failed")
		return
	}
	var flags []models.FeatureFlag
	_ = cur.All(c.Request.Context(), &flags)
	response.OK(c, gin.H{"flags": flags})
}

type updateFeatureFlagRequest struct {
	IsEnabled   bool   `json:"is_enabled"`
	Description string `json:"description"`
}

func (h *Handler) AdminUpdateFeatureFlag(c *gin.Context) {
	name := c.Param("name")
	var req updateFeatureFlagRequest
	if !bindJSON(c, &req) {
		return
	}
	uid, ok := userObjectID(c)
	if !ok {
		return
	}
	ctx := c.Request.Context()
	update := bson.M{
		"is_enabled":  req.IsEnabled,
		"updated_by":  uid,
		"updated_at":  time.Now().UTC(),
	}
	if req.Description != "" {
		update["description"] = req.Description
	}
	opts := options.Update().SetUpsert(true)
	_, err := h.a.DB.Collection("feature_flags").UpdateOne(ctx,
		bson.M{"flag_name": name},
		bson.M{"$set": update, "$setOnInsert": bson.M{"flag_name": name}},
		opts,
	)
	if err != nil {
		response.Internal(c, "update failed")
		return
	}
	var flag models.FeatureFlag
	_ = h.a.DB.Collection("feature_flags").FindOne(ctx, bson.M{"flag_name": name}).Decode(&flag)
	response.OK(c, flag)
}
