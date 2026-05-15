package platform

import (
	"context"
	"log"
)

type MockAT struct{}

func NewMockAT() *MockAT { return &MockAT{} }

func (m *MockAT) SendSMS(ctx context.Context, req SMSRequest) error {
	log.Printf("[MOCK AT SMS] to=%s msg=%s", req.To, req.Message)
	return nil
}

func (m *MockAT) SendVoice(ctx context.Context, req VoiceRequest) error {
	log.Printf("[MOCK AT VOICE] to=%s msg=%s", req.To, req.Message)
	return nil
}
