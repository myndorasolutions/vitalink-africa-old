package router

import (
	"time"

	"github.com/gin-gonic/gin"
	"github.com/vitalink-africa/backend/internal/middleware"
	"github.com/vitalink-africa/backend/internal/models"
	"github.com/vitalink-africa/backend/pkg/response"
	"go.mongodb.org/mongo-driver/bson"
)

func (h *Handler) Health(c *gin.Context) {
	response.OK(c, gin.H{
		"status":  "ok",
		"service": "vitalink-api",
		"time":    time.Now().UTC(),
	})
}

type verifyTokenRequest struct {
	IDToken string `json:"id_token" binding:"required"`
}

func (h *Handler) VerifyToken(c *gin.Context) {
	var req verifyTokenRequest
	if !bindJSON(c, &req) {
		return
	}
	ctx := c.Request.Context()
	if h.a.Firebase == nil || !h.a.Firebase.Available() {
		response.Internal(c, "firebase not configured")
		return
	}
	token, err := h.a.Firebase.VerifyIDToken(ctx, req.IDToken)
	if err != nil {
		response.Unauthorized(c, "invalid token")
		return
	}
	email, _ := token.Claims["email"].(string)
	user, err := h.a.Users.UpsertFromFirebase(ctx, token.UID, email)
	if err != nil {
		response.Internal(c, "failed to upsert user")
		return
	}
	response.OK(c, gin.H{
		"user": user,
		"role": user.Role,
	})
}

type completeProfileRequest struct {
	Role               string `json:"role" binding:"required"`
	FullName           string `json:"full_name" binding:"required"`
	Phone              string `json:"phone"`
	LanguagePreference string `json:"language_preference"`
	Age                int    `json:"age"`
	Gender             string `json:"gender"`
	City               string `json:"city"`
	State              string `json:"state"`
	LGA                string `json:"lga"`
}

func (h *Handler) CompleteProfile(c *gin.Context) {
	var req completeProfileRequest
	if !bindJSON(c, &req) {
		return
	}
	uid, ok := userObjectID(c)
	if !ok {
		return
	}
	ctx := c.Request.Context()
	fbUID, _ := c.Get(middleware.ContextFirebase)
	fbStr, _ := fbUID.(string)

	update := bson.M{
		"role":      req.Role,
		"full_name": req.FullName,
		"phone":     req.Phone,
	}
	if req.LanguagePreference != "" {
		update["language_preference"] = req.LanguagePreference
	}
	if err := h.a.Users.UpdateProfile(ctx, uid, update); err != nil {
		response.Internal(c, "failed to update profile")
		return
	}
	if fbStr != "" && h.a.Firebase != nil && h.a.Firebase.Available() {
		_ = h.a.Firebase.SetCustomClaims(ctx, fbStr, map[string]interface{}{
			"role":    req.Role,
			"user_id": uid.Hex(),
		})
	}
	user, err := h.a.Users.FindByID(ctx, uid)
	if err != nil {
		response.Internal(c, "failed to load user")
		return
	}
	if req.Role == models.RolePatient {
		existing, err := h.a.Patients.FindByUserID(ctx, uid)
		if err != nil {
			p := &models.Patient{
				UserID:   uid,
				FullName: req.FullName,
				Age:      req.Age,
				Gender:   req.Gender,
				Location: models.Location{City: req.City, State: req.State, LGA: req.LGA},
				SubscriptionPlan:   "free",
				SubscriptionStatus: "active",
			}
			if err := h.a.Patients.Create(ctx, p); err != nil {
				response.Internal(c, "failed to create patient profile")
				return
			}
			_ = existing
		}
	}
	auditAction(ctx, h, uid, nil, "user.profile_completed", "user", uid.Hex(), nil, update, c)
	response.OK(c, gin.H{"user": user, "role": user.Role})
}
