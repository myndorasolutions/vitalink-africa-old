package middleware

import (
	"strings"

	"github.com/gin-gonic/gin"
	"github.com/vitalink-africa/backend/internal/app"
	"github.com/vitalink-africa/backend/pkg/response"
)

const (
	ContextUserID    = "user_id"
	ContextFirebase  = "firebase_uid"
	ContextRole      = "role"
	ContextEmail     = "email"
)

func FirebaseAuth(a *app.App) gin.HandlerFunc {
	return func(c *gin.Context) {
		authHeader := c.GetHeader("Authorization")
		if authHeader == "" {
			response.Unauthorized(c, "missing authorization header")
			c.Abort()
			return
		}
		parts := strings.SplitN(authHeader, " ", 2)
		if len(parts) != 2 || !strings.EqualFold(parts[0], "bearer") {
			response.Unauthorized(c, "invalid authorization format")
			c.Abort()
			return
		}
		token, err := a.Firebase.VerifyIDToken(c.Request.Context(), parts[1])
		if err != nil {
			response.Unauthorized(c, "invalid token")
			c.Abort()
			return
		}
		uid := token.UID
		role, _ := token.Claims["role"].(string)
		userID, _ := token.Claims["user_id"].(string)

		user, err := a.Users.FindByFirebaseUID(c.Request.Context(), uid)
		if err == nil && user != nil {
			c.Set(ContextUserID, user.ID.Hex())
			c.Set(ContextRole, user.Role)
			c.Set(ContextEmail, user.Email)
		} else {
			c.Set(ContextRole, role)
			c.Set(ContextUserID, userID)
		}
		c.Set(ContextFirebase, uid)
		c.Next()
	}
}

func OptionalAuth(a *app.App) gin.HandlerFunc {
	return func(c *gin.Context) {
		authHeader := c.GetHeader("Authorization")
		if authHeader == "" {
			c.Next()
			return
		}
		FirebaseAuth(a)(c)
	}
}
