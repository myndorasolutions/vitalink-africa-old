package migrations

import (
	"context"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

func Run(ctx context.Context, db *mongo.Database) error {
	indexes := map[string][]mongo.IndexModel{
		"users": {{
			Keys:    bson.D{{Key: "firebase_uid", Value: 1}},
			Options: options.Index().SetUnique(true),
		}},
		"patients": {{
			Keys: bson.D{{Key: "user_id", Value: 1}},
			Options: options.Index().SetUnique(true),
		}},
		"vitals": {
			{Keys: bson.D{{Key: "patient_id", Value: 1}, {Key: "created_at", Value: -1}}},
		},
		"alerts": {
			{Keys: bson.D{{Key: "status", Value: 1}, {Key: "severity", Value: 1}}},
			{Keys: bson.D{{Key: "patient_id", Value: 1}, {Key: "created_at", Value: -1}}},
		},
		"caregivers_patients": {
			{Keys: bson.D{{Key: "caregiver_user_id", Value: 1}, {Key: "patient_id", Value: 1}}},
		},
		"service_jobs": {
			{Keys: bson.D{{Key: "provider_id", Value: 1}, {Key: "status", Value: 1}}},
			{Keys: bson.D{{Key: "patient_id", Value: 1}}},
		},
		"providers": {
			{Keys: bson.D{{Key: "user_id", Value: 1}}},
			{Keys: bson.D{{Key: "provider_type", Value: 1}, {Key: "location.city", Value: 1}}},
		},
		"payments": {
			{Keys: bson.D{{Key: "paystack_reference", Value: 1}}},
		},
		"notifications": {
			{Keys: bson.D{{Key: "recipient_user_id", Value: 1}, {Key: "created_at", Value: -1}}},
		},
		"audit_logs": {
			{Keys: bson.D{{Key: "created_at", Value: -1}}},
		},
	}
	for coll, models := range indexes {
		if len(models) == 0 {
			continue
		}
		_, err := db.Collection(coll).Indexes().CreateMany(ctx, models)
		if err != nil {
			return err
		}
	}
	return nil
}
