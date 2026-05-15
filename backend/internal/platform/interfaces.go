package platform

import "context"

type PaymentInitRequest struct {
	Email       string
	AmountKobo  int64
	Reference   string
	CallbackURL string
	Metadata    map[string]string
}

type PaymentInitResponse struct {
	AuthorizationURL string
	AccessCode       string
	Reference        string
}

type PaymentVerifyResponse struct {
	Status    string
	Reference string
	Amount    int64
	Metadata  map[string]string
}

type PaymentGateway interface {
	Initialize(ctx context.Context, req PaymentInitRequest) (*PaymentInitResponse, error)
	Verify(ctx context.Context, reference string) (*PaymentVerifyResponse, error)
	VerifyWebhookSignature(payload []byte, signature string) bool
}

type SMSRequest struct {
	To      string
	Message string
}

type VoiceRequest struct {
	To      string
	Message string
}

type SMSClient interface {
	SendSMS(ctx context.Context, req SMSRequest) error
	SendVoice(ctx context.Context, req VoiceRequest) error
}

type SignedURLResponse struct {
	UploadURL   string
	DownloadURL string
	ObjectKey   string
	ExpiresAt   int64
}

type ObjectStorage interface {
	SignedUploadURL(ctx context.Context, bucket, objectKey, contentType string) (*SignedURLResponse, error)
	SignedDownloadURL(ctx context.Context, bucket, objectKey string) (string, error)
}
