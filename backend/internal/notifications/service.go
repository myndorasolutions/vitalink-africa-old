package notifications

import (
	"context"
	"fmt"
	"time"

	"github.com/vitalink-africa/backend/internal/models"
	"github.com/vitalink-africa/backend/internal/platform"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

type Service struct {
	coll *mongo.Collection
	sms  platform.SMSClient
}

func NewService(db *mongo.Database, sms platform.SMSClient) *Service {
	return &Service{coll: db.Collection("notifications"), sms: sms}
}

func (s *Service) Create(ctx context.Context, n *models.Notification) error {
	n.CreatedAt = time.Now().UTC()
	n.Status = "queued"
	res, err := s.coll.InsertOne(ctx, n)
	if err != nil {
		return err
	}
	n.ID = res.InsertedID.(primitive.ObjectID)
	return nil
}

func (s *Service) DispatchVitalAlert(ctx context.Context, patientID primitive.ObjectID, risk string) {
	msg := fmt.Sprintf("VitaLink Alert: Your reading status is %s. Your care team has been notified.", risk)
	_ = s.sms.SendSMS(ctx, platform.SMSRequest{To: "", Message: msg})
	if risk == "red" {
		_ = s.sms.SendVoice(ctx, platform.VoiceRequest{To: "", Message: "Urgent VitaLink alert. Please contact your doctor."})
	}
}

func (s *Service) SendOTP(ctx context.Context, phone, otp string) {
	msg := fmt.Sprintf("VitaLink: Your confirmation code is %s. Do not share.", otp)
	_ = s.sms.SendSMS(ctx, platform.SMSRequest{To: phone, Message: msg})
}

func (s *Service) ListByUser(ctx context.Context, userID primitive.ObjectID, skip, limit int64) ([]models.Notification, error) {
	opts := options.Find().SetSkip(skip).SetLimit(limit).SetSort(bson.M{"created_at": -1})
	cur, err := s.coll.Find(ctx, map[string]interface{}{"recipient_user_id": userID}, opts)
	if err != nil {
		return nil, err
	}
	var list []models.Notification
	err = cur.All(ctx, &list)
	return list, err
}

func (s *Service) MarkRead(ctx context.Context, id, userID primitive.ObjectID) error {
	now := time.Now().UTC()
	_, err := s.coll.UpdateOne(ctx,
		map[string]interface{}{"_id": id, "recipient_user_id": userID},
		map[string]interface{}{"$set": map[string]interface{}{"read_at": now, "status": "delivered"}},
	)
	return err
}
