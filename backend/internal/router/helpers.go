package router

import (
	"context"
	"crypto/rand"
	"fmt"
	"math/big"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/vitalink-africa/backend/internal/app"
	"github.com/vitalink-africa/backend/internal/middleware"
	"github.com/vitalink-africa/backend/internal/models"
	"github.com/vitalink-africa/backend/pkg/response"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
)

type Handler struct {
	a *app.App
}

func NewHandler(a *app.App) *Handler {
	return &Handler{a: a}
}

func parseObjectID(c *gin.Context, param string) (primitive.ObjectID, bool) {
	raw := c.Param(param)
	if raw == "" {
		response.BadRequest(c, "invalid_id", "missing id")
		return primitive.NilObjectID, false
	}
	id, err := primitive.ObjectIDFromHex(raw)
	if err != nil {
		response.BadRequest(c, "invalid_id", "invalid object id")
		return primitive.NilObjectID, false
	}
	return id, true
}

func userObjectID(c *gin.Context) (primitive.ObjectID, bool) {
	raw := middleware.GetUserID(c)
	if raw == "" {
		response.Unauthorized(c, "user not authenticated")
		return primitive.NilObjectID, false
	}
	id, err := primitive.ObjectIDFromHex(raw)
	if err != nil {
		response.Unauthorized(c, "invalid user id")
		return primitive.NilObjectID, false
	}
	return id, true
}

func clientIP(c *gin.Context) string {
	if fwd := c.GetHeader("X-Forwarded-For"); fwd != "" {
		return fwd
	}
	return c.ClientIP()
}

func (h *Handler) loadPatient(c *gin.Context, patientID primitive.ObjectID) (*models.Patient, bool) {
	p, err := h.a.Patients.FindByID(c.Request.Context(), patientID)
	if err == mongo.ErrNoDocuments {
		response.NotFound(c, "patient not found")
		return nil, false
	}
	if err != nil {
		response.Internal(c, "failed to load patient")
		return nil, false
	}
	return p, true
}

func (h *Handler) requirePatientAccess(c *gin.Context, p *models.Patient) bool {
	uid, ok := userObjectID(c)
	if !ok {
		return false
	}
	role := middleware.GetRole(c)
	if !h.a.Access.CanAccessPatient(c.Request.Context(), role, uid, p) {
		response.Forbidden(c, "no access to this patient")
		return false
	}
	return true
}

func generateOTP() string {
	n, err := rand.Int(rand.Reader, big.NewInt(900000))
	if err != nil {
		return "123456"
	}
	return fmt.Sprintf("%06d", n.Int64()+100000)
}

func commissionForProvider(cfg *app.App, providerType string, price int64) (commission, payout int64) {
	var rate float64
	switch providerType {
	case "chw":
		rate = cfg.Config.CHWCommission
	case "clinician":
		rate = cfg.Config.ClinicianCommission
	case "pharmacy":
		rate = cfg.Config.PharmacyCommission
	case "lab":
		rate = cfg.Config.LabCommission
	default:
		rate = 0.15
	}
	commission = int64(float64(price) * rate)
	payout = price - commission
	return
}

func auditAction(ctx context.Context, h *Handler, actorID primitive.ObjectID, patientID *primitive.ObjectID, action, resourceType, resourceID string, oldVal, newVal any, c *gin.Context) {
	_ = h.a.Audit.Log(ctx, actorID, patientID, action, resourceType, resourceID, oldVal, newVal, clientIP(c), c.Request.UserAgent())
}

func bindJSON(c *gin.Context, dst any) bool {
	if err := c.ShouldBindJSON(dst); err != nil {
		response.BadRequest(c, "invalid_body", err.Error())
		return false
	}
	return true
}

func noContent(c *gin.Context) {
	c.Status(http.StatusNoContent)
}
