package router

import (
	"github.com/gin-gonic/gin"
	"github.com/vitalink-africa/backend/pkg/pagination"
	"github.com/vitalink-africa/backend/pkg/response"
)

func (h *Handler) ListNotifications(c *gin.Context) {
	uid, ok := userObjectID(c)
	if !ok {
		return
	}
	pg := pagination.FromContext(c)
	list, err := h.a.Notifications.ListByUser(c.Request.Context(), uid, pg.Skip, pg.Limit)
	if err != nil {
		response.Internal(c, "list failed")
		return
	}
	response.OK(c, gin.H{"notifications": list, "page": pg.Page, "limit": pg.Limit})
}

func (h *Handler) MarkNotificationRead(c *gin.Context) {
	id, ok := parseObjectID(c, "id")
	if !ok {
		return
	}
	uid, ok := userObjectID(c)
	if !ok {
		return
	}
	if err := h.a.Notifications.MarkRead(c.Request.Context(), id, uid); err != nil {
		response.Internal(c, "mark read failed")
		return
	}
	response.OK(c, gin.H{"id": id.Hex(), "read": true})
}
