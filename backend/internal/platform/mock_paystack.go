package platform

import (
	"context"
	"crypto/hmac"
	"crypto/sha512"
	"encoding/hex"
	"fmt"
	"log"
)

type MockPaystack struct {
	WebhookSecret string
}

func NewMockPaystack(secret string) *MockPaystack {
	return &MockPaystack{WebhookSecret: secret}
}

func (m *MockPaystack) Initialize(ctx context.Context, req PaymentInitRequest) (*PaymentInitResponse, error) {
	log.Printf("[MOCK PAYSTACK] Initialize ref=%s amount=%d email=%s", req.Reference, req.AmountKobo, req.Email)
	url := fmt.Sprintf("https://checkout.paystack.com/mock/%s", req.Reference)
	return &PaymentInitResponse{
		AuthorizationURL: url,
		AccessCode:       "mock_access",
		Reference:        req.Reference,
	}, nil
}

func (m *MockPaystack) Verify(ctx context.Context, reference string) (*PaymentVerifyResponse, error) {
	log.Printf("[MOCK PAYSTACK] Verify ref=%s", reference)
	return &PaymentVerifyResponse{Status: "success", Reference: reference, Amount: 0}, nil
}

func (m *MockPaystack) VerifyWebhookSignature(payload []byte, signature string) bool {
	if m.WebhookSecret == "" {
		return true
	}
	mac := hmac.New(sha512.New, []byte(m.WebhookSecret))
	mac.Write(payload)
	expected := hex.EncodeToString(mac.Sum(nil))
	return hmac.Equal([]byte(expected), []byte(signature))
}
