package platform

import (
	"context"
	"fmt"
	"log"
	"time"
)

type MockGCS struct{}

func NewMockGCS() *MockGCS { return &MockGCS{} }

func (m *MockGCS) SignedUploadURL(ctx context.Context, bucket, objectKey, contentType string) (*SignedURLResponse, error) {
	log.Printf("[MOCK GCS] upload bucket=%s key=%s", bucket, objectKey)
	exp := time.Now().Add(time.Hour).Unix()
	url := fmt.Sprintf("https://storage.mock.googleapis.com/%s/%s?upload=1", bucket, objectKey)
	return &SignedURLResponse{UploadURL: url, ObjectKey: objectKey, ExpiresAt: exp}, nil
}

func (m *MockGCS) SignedDownloadURL(ctx context.Context, bucket, objectKey string) (string, error) {
	log.Printf("[MOCK GCS] download bucket=%s key=%s", bucket, objectKey)
	return fmt.Sprintf("https://storage.mock.googleapis.com/%s/%s?download=1", bucket, objectKey), nil
}
