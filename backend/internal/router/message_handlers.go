package router

import (
	"time"

	"github.com/gin-gonic/gin"
	"github.com/vitalink-africa/backend/internal/messages"
	"github.com/vitalink-africa/backend/internal/models"
	"github.com/vitalink-africa/backend/pkg/response"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

type sendMessageRequest struct {
	JobID      string `json:"job_id" binding:"required"`
	ReceiverID string `json:"receiver_id" binding:"required"`
	Body       string `json:"body" binding:"required"`
}

func (h *Handler) SendMessage(c *gin.Context) {
	var req sendMessageRequest
	if !bindJSON(c, &req) {
		return
	}
	jobID, err := primitive.ObjectIDFromHex(req.JobID)
	if err != nil {
		response.BadRequest(c, "invalid_id", "invalid job_id")
		return
	}
	receiverID, err := primitive.ObjectIDFromHex(req.ReceiverID)
	if err != nil {
		response.BadRequest(c, "invalid_id", "invalid receiver_id")
		return
	}
	senderID, ok := userObjectID(c)
	if !ok {
		return
	}
	scan := messages.ScanMessage(req.Body)
	if scan.Blocked {
		ctx := c.Request.Context()
		var providerID primitive.ObjectID
		job, _ := h.loadJob(c, jobID)
		if job != nil {
			providerID = job.ProviderID
		}
		event := models.MessagePolicyEvent{
			SenderID:           senderID,
			ReceiverID:         receiverID,
			JobID:              &jobID,
			PatternDetected:    scan.PatternDetected,
			MessageSnippetHash: scan.SnippetHash,
			ActionTaken:        "blocked",
			CreatedAt:          time.Now().UTC(),
		}
		_, _ = h.a.DB.Collection("message_policy_events").InsertOne(ctx, event)
		if providerID != primitive.NilObjectID {
			violation := models.ProviderPolicyViolation{
				ProviderID:    providerID,
				ViolationType: "off_platform_contact",
				Evidence:      scan.PatternDetected,
				Status:        "open",
				CreatedAt:     time.Now().UTC(),
			}
			_, _ = h.a.DB.Collection("provider_policy_violations").InsertOne(ctx, violation)
		}
		response.Forbidden(c, messages.PolicyWarning)
		return
	}
	msg := models.InAppMessage{
		JobID:      jobID,
		SenderID:   senderID,
		ReceiverID: receiverID,
		Body:       req.Body,
		CreatedAt:  time.Now().UTC(),
	}
	ctx := c.Request.Context()
	res, err := h.a.DB.Collection("in_app_messages").InsertOne(ctx, msg)
	if err != nil {
		response.Internal(c, "send failed")
		return
	}
	msg.ID = res.InsertedID.(primitive.ObjectID)
	response.Created(c, msg)
}
