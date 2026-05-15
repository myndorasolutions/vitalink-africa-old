package router

import (
	"fmt"
	"path"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"github.com/vitalink-africa/backend/pkg/response"
)

type uploadURLRequest struct {
	Bucket      string `json:"bucket"` // patient | provider | exports
	ObjectKey   string `json:"object_key"`
	ContentType string `json:"content_type" binding:"required"`
}

func (h *Handler) StorageUploadURL(c *gin.Context) {
	var req uploadURLRequest
	if !bindJSON(c, &req) {
		return
	}
	bucket := h.resolveBucket(req.Bucket)
	objectKey := req.ObjectKey
	if objectKey == "" {
		uid, _ := userObjectID(c)
		objectKey = path.Join(uid.Hex(), uuid.New().String())
	}
	ctx := c.Request.Context()
	signed, err := h.a.Storage.SignedUploadURL(ctx, bucket, objectKey, req.ContentType)
	if err != nil {
		response.Internal(c, "failed to generate upload url")
		return
	}
	response.OK(c, signed)
}

type downloadURLRequest struct {
	Bucket    string `json:"bucket"`
	ObjectKey string `json:"object_key" binding:"required"`
}

func (h *Handler) StorageDownloadURL(c *gin.Context) {
	var req downloadURLRequest
	if !bindJSON(c, &req) {
		return
	}
	bucket := h.resolveBucket(req.Bucket)
	ctx := c.Request.Context()
	url, err := h.a.Storage.SignedDownloadURL(ctx, bucket, req.ObjectKey)
	if err != nil {
		response.Internal(c, "failed to generate download url")
		return
	}
	response.OK(c, gin.H{
		"download_url": url,
		"object_key":   req.ObjectKey,
		"expires_hint": fmt.Sprintf("%v", 15*time.Minute),
	})
}

func (h *Handler) resolveBucket(kind string) string {
	switch kind {
	case "provider":
		return h.a.Config.GCSProviderBucket
	case "exports":
		return h.a.Config.GCSExportsBucket
	default:
		return h.a.Config.GCSPatientBucket
	}
}
