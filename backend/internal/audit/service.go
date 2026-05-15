package audit

import (
	"context"
	"time"

	"github.com/vitalink-africa/backend/internal/models"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
)

type Service struct {
	coll *mongo.Collection
}

func NewService(db *mongo.Database) *Service {
	return &Service{coll: db.Collection("audit_logs")}
}

func (s *Service) Log(ctx context.Context, actorID primitive.ObjectID, patientID *primitive.ObjectID, action, resourceType, resourceID string, oldVal, newVal any, ip, ua string) error {
	log := models.AuditLog{
		ActorUserID:  actorID,
		PatientID:    patientID,
		Action:       action,
		ResourceType: resourceType,
		ResourceID:   resourceID,
		OldValue:     oldVal,
		NewValue:     newVal,
		IPAddress:    ip,
		UserAgent:    ua,
		CreatedAt:    time.Now().UTC(),
	}
	_, err := s.coll.InsertOne(ctx, log)
	return err
}
