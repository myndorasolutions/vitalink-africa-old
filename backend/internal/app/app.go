package app

import (
	"context"

	"github.com/go-redis/redis/v8"
	"github.com/vitalink-africa/backend/internal/access"
	"github.com/vitalink-africa/backend/internal/alerts"
	"github.com/vitalink-africa/backend/internal/audit"
	"github.com/vitalink-africa/backend/internal/config"
	"github.com/vitalink-africa/backend/internal/notifications"
	"github.com/vitalink-africa/backend/internal/patients"
	"github.com/vitalink-africa/backend/internal/platform"
	"github.com/vitalink-africa/backend/internal/users"
	"github.com/vitalink-africa/backend/internal/vitals"
	"go.mongodb.org/mongo-driver/mongo"
)

type App struct {
	Config   *config.Config
	DB       *mongo.Database
	Redis    *redis.Client
	Firebase *platform.FirebaseAuth
	Paystack platform.PaymentGateway
	SMS      platform.SMSClient
	Storage  platform.ObjectStorage
	Pub      *platform.AlertPublisher

	Users         *users.Repository
	Patients      *patients.Repository
	Vitals        *vitals.Repository
	VitalService  *vitals.Service
	Alerts        *alerts.Repository
	Audit         *audit.Service
	Notifications *notifications.Service
	Access        *access.Checker
}

func New(ctx context.Context, cfg *config.Config, db *mongo.Database, rdb *redis.Client) (*App, error) {
	fb, err := platform.NewFirebaseAuth(ctx, cfg.FirebaseProjectID, cfg.FirebaseSAPath)
	if err != nil {
		return nil, err
	}

	var paystack platform.PaymentGateway = platform.NewMockPaystack(cfg.PaystackWebhook)
	if !cfg.MockPaystack {
		paystack = platform.NewMockPaystack(cfg.PaystackWebhook) // swap with real client when keys present
	}

	var sms platform.SMSClient = platform.NewMockAT()
	if !cfg.MockAT {
		sms = platform.NewMockAT()
	}

	var storage platform.ObjectStorage = platform.NewMockGCS()
	if !cfg.MockGCS {
		storage = platform.NewMockGCS()
	}

	pub := platform.NewAlertPublisher(rdb)
	userRepo := users.NewRepository(db)
	patientRepo := patients.NewRepository(db)
	vitalRepo := vitals.NewRepository(db)
	alertRepo := alerts.NewRepository(db)
	auditSvc := audit.NewService(db)
	notifySvc := notifications.NewService(db, sms)
	vitalSvc := vitals.NewService(vitalRepo, alertRepo, auditSvc, notifySvc, pub, vitals.DefaultThresholds())

	return &App{
		Config: cfg, DB: db, Redis: rdb, Firebase: fb,
		Paystack: paystack, SMS: sms, Storage: storage, Pub: pub,
		Users: userRepo, Patients: patientRepo, Vitals: vitalRepo,
		VitalService: vitalSvc, Alerts: alertRepo, Audit: auditSvc,
		Notifications: notifySvc, Access: access.NewChecker(db),
	}, nil
}
