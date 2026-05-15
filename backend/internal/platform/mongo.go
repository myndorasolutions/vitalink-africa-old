package platform

import (
	"context"
	"time"

	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

func ConnectMongo(ctx context.Context, uri, dbName string) (*mongo.Database, error) {
	client, err := mongo.Connect(ctx, options.Client().ApplyURI(uri).SetMaxPoolSize(50))
	if err != nil {
		return nil, err
	}
	ctxPing, cancel := context.WithTimeout(ctx, 10*time.Second)
	defer cancel()
	if err := client.Ping(ctxPing, nil); err != nil {
		return nil, err
	}
	return client.Database(dbName), nil
}

func CollectionNames() []string {
	return []string{
		"users", "patients", "vitals", "alerts", "caregivers_patients",
		"authorized_helpers", "medications", "prescriptions", "providers",
		"provider_services", "provider_price_caps", "service_jobs",
		"service_completion_proofs", "provider_wallets", "payouts",
		"subscriptions", "payments", "pharmacy_refills", "chw_visits",
		"lab_orders", "consent_records", "notifications", "audit_logs",
		"message_policy_events", "provider_policy_violations", "disputes",
		"feature_flags", "in_app_messages", "clinical_notes",
	}
}
