package router

import (
	"encoding/json"
	"fmt"
	"io"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/vitalink-africa/backend/internal/middleware"
	"github.com/vitalink-africa/backend/internal/models"
	"github.com/vitalink-africa/backend/internal/platform"
	"github.com/vitalink-africa/backend/pkg/pagination"
	"github.com/vitalink-africa/backend/pkg/response"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

func (h *Handler) ListAlerts(c *gin.Context) {
	ctx := c.Request.Context()
	uid, ok := userObjectID(c)
	if !ok {
		return
	}
	role := middleware.GetRole(c)
	p := pagination.FromContext(c)
	filter := bson.M{}
	if role != models.RoleAdmin && role != models.RoleSuperAdmin {
		ids, err := h.a.Access.GetAccessiblePatientIDs(ctx, role, uid)
		if err != nil || len(ids) == 0 {
			response.OK(c, gin.H{"alerts": []models.Alert{}, "page": p.Page})
			return
		}
		filter["patient_id"] = bson.M{"$in": ids}
	}
	if status := c.Query("status"); status != "" {
		filter["status"] = status
	}
	if sev := c.Query("severity"); sev != "" {
		filter["severity"] = sev
	}
	list, err := h.a.Alerts.List(ctx, filter, p.Skip, p.Limit)
	if err != nil {
		response.Internal(c, "list failed")
		return
	}
	response.OK(c, gin.H{"alerts": list, "page": p.Page, "limit": p.Limit})
}

type assignAlertRequest struct {
	AssignedToUserID string `json:"assigned_to_user_id" binding:"required"`
	AssignedToRole   string `json:"assigned_to_role"`
}

func (h *Handler) AssignAlert(c *gin.Context) {
	id, ok := parseObjectID(c, "id")
	if !ok {
		return
	}
	var req assignAlertRequest
	if !bindJSON(c, &req) {
		return
	}
	assignee, err := primitive.ObjectIDFromHex(req.AssignedToUserID)
	if err != nil {
		response.BadRequest(c, "invalid_id", "invalid assignee id")
		return
	}
	ctx := c.Request.Context()
	update := bson.M{
		"assigned_to_user_id": assignee,
		"assigned_to_role":    req.AssignedToRole,
		"status":              "assigned",
	}
	if err := h.a.Alerts.Update(ctx, id, update); err != nil {
		response.Internal(c, "assign failed")
		return
	}
	alert, _ := h.a.Alerts.FindByID(ctx, id)
	uid, _ := userObjectID(c)
	var pid *primitive.ObjectID
	if alert != nil {
		pid = &alert.PatientID
	}
	auditAction(ctx, h, uid, pid, "alert.assigned", "alert", id.Hex(), nil, update, c)
	response.OK(c, alert)
}

func (h *Handler) ResolveAlert(c *gin.Context) {
	id, ok := parseObjectID(c, "id")
	if !ok {
		return
	}
	ctx := c.Request.Context()
	uid, ok := userObjectID(c)
	if !ok {
		return
	}
	now := time.Now().UTC()
	update := bson.M{"status": "resolved", "resolved_at": now, "resolved_by": uid}
	if err := h.a.Alerts.Update(ctx, id, update); err != nil {
		response.Internal(c, "resolve failed")
		return
	}
	alert, _ := h.a.Alerts.FindByID(ctx, id)
	pid := &alert.PatientID
	auditAction(ctx, h, uid, pid, "alert.resolved", "alert", id.Hex(), nil, update, c)
	response.OK(c, alert)
}

func (h *Handler) StreamAlerts(c *gin.Context) {
	c.Header("Content-Type", "text/event-stream")
	c.Header("Cache-Control", "no-cache")
	c.Header("Connection", "keep-alive")

	ctx := c.Request.Context()
	if h.a.Redis == nil {
		fmt.Fprintf(c.Writer, "event: error\ndata: redis unavailable\n\n")
		c.Writer.Flush()
		return
	}
	pubsub := h.a.Redis.Subscribe(ctx, platform.AlertChannel)
	defer pubsub.Close()

	ch := pubsub.Channel()
	heartbeat := time.NewTicker(25 * time.Second)
	defer heartbeat.Stop()

	c.Stream(func(w io.Writer) bool {
		select {
		case <-ctx.Done():
			return false
		case <-heartbeat.C:
			fmt.Fprintf(w, ": heartbeat\n\n")
			return true
		case msg, ok := <-ch:
			if !ok {
				return false
			}
			var alert models.Alert
			if err := json.Unmarshal([]byte(msg.Payload), &alert); err == nil {
				data, _ := json.Marshal(alert)
				fmt.Fprintf(w, "event: alert\ndata: %s\n\n", data)
			} else {
				fmt.Fprintf(w, "event: alert\ndata: %s\n\n", msg.Payload)
			}
			return true
		}
	})
}
