package middleware

import (
	"github.com/gin-gonic/gin"
	"github.com/vitalink-africa/backend/pkg/response"
)

func RequireRoles(roles ...string) gin.HandlerFunc {
	allowed := make(map[string]bool)
	for _, r := range roles {
		allowed[r] = true
	}
	return func(c *gin.Context) {
		role, _ := c.Get(ContextRole)
		roleStr, _ := role.(string)
		if !allowed[roleStr] {
			response.Forbidden(c, "insufficient permissions")
			c.Abort()
			return
		}
		c.Next()
	}
}

func GetRole(c *gin.Context) string {
	r, _ := c.Get(ContextRole)
	s, _ := r.(string)
	return s
}

func GetUserID(c *gin.Context) string {
	id, _ := c.Get(ContextUserID)
	s, _ := id.(string)
	return s
}
