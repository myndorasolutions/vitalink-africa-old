package config

import (
	"os"
	"strconv"
	"strings"
	"time"

	"github.com/joho/godotenv"
)

type Config struct {
	AppEnv              string
	AppPort             string
	AppBaseURL          string
	CORSOrigins         []string
	MongoURI            string
	MongoDB             string
	RedisURL            string
	FirebaseProjectID   string
	FirebaseSAPath      string
	GCPProjectID        string
	GCPRegion           string
	GCSPatientBucket    string
	GCSProviderBucket   string
	GCSExportsBucket    string
	MockGCS             bool
	ATUsername          string
	ATAPIKey            string
	ATSenderID          string
	ATUSSDCode          string
	MockAT              bool
	PaystackSecret      string
	PaystackPublic      string
	PaystackWebhook     string
	MockPaystack        bool
	CHWCommission       float64
	ClinicianCommission float64
	PharmacyCommission  float64
	LabCommission       float64
	EscrowAutoReleaseH  int
	FeatureAI           bool
	FeaturePaystackLive bool
	FeatureUSSD         bool
	FeatureMarketplace  bool
	FeaturePrescription bool
}

func Load() (*Config, error) {
	_ = godotenv.Load()
	_ = godotenv.Load("../.env")

	cfg := &Config{
		AppEnv:              getEnv("APP_ENV", "development"),
		AppPort:             getEnv("APP_PORT", "8080"),
		AppBaseURL:          getEnv("APP_BASE_URL", "http://localhost:8080"),
		CORSOrigins:         strings.Split(getEnv("CORS_ORIGINS", "http://localhost:5173"), ","),
		MongoURI:            getEnv("MONGODB_URI", "mongodb://localhost:27017/?replicaSet=rs0"),
		MongoDB:             getEnv("MONGODB_DB", "vitalink_dev"),
		RedisURL:            getEnv("REDIS_URL", "redis://localhost:6379"),
		FirebaseProjectID:   getEnv("FIREBASE_PROJECT_ID", ""),
		FirebaseSAPath:      getEnv("FIREBASE_SERVICE_ACCOUNT_JSON", "./firebase-service-account.json"),
		GCPProjectID:        getEnv("GCP_PROJECT_ID", ""),
		GCPRegion:           getEnv("GCP_REGION", "africa-south1"),
		GCSPatientBucket:    getEnv("GCS_PATIENT_FILES_BUCKET", "vitalink-patient-files-dev"),
		GCSProviderBucket:   getEnv("GCS_PROVIDER_DOCS_BUCKET", "vitalink-provider-docs-dev"),
		GCSExportsBucket:    getEnv("GCS_VITALS_EXPORTS_BUCKET", "vitalink-vitals-exports-dev"),
		MockGCS:             getEnvBool("MOCK_GCS", true),
		ATUsername:          getEnv("AT_USERNAME", "sandbox"),
		ATAPIKey:            getEnv("AT_API_KEY", ""),
		ATSenderID:          getEnv("AT_SENDER_ID", "VitaLink"),
		ATUSSDCode:          getEnv("AT_USSD_CODE", "*384*VITALINK#"),
		MockAT:              getEnvBool("MOCK_AT", true),
		PaystackSecret:      getEnv("PAYSTACK_SECRET_KEY", ""),
		PaystackPublic:      getEnv("PAYSTACK_PUBLIC_KEY", ""),
		PaystackWebhook:     getEnv("PAYSTACK_WEBHOOK_SECRET", ""),
		MockPaystack:        getEnvBool("MOCK_PAYSTACK", true),
		CHWCommission:       getEnvFloat("VITALINK_CHW_COMMISSION", 0.15),
		ClinicianCommission: getEnvFloat("VITALINK_CLINICIAN_COMMISSION", 0.20),
		PharmacyCommission:  getEnvFloat("VITALINK_PHARMACY_COMMISSION", 0.05),
		LabCommission:         getEnvFloat("VITALINK_LAB_COMMISSION", 0.08),
		EscrowAutoReleaseH:  getEnvInt("ESCROW_AUTO_RELEASE_HOURS", 48),
		FeatureAI:           getEnvBool("FEATURE_AI_SUMMARIES", false),
		FeaturePaystackLive: getEnvBool("FEATURE_PAYSTACK_LIVE", false),
		FeatureUSSD:         getEnvBool("FEATURE_USSD", true),
		FeatureMarketplace:  getEnvBool("FEATURE_MARKETPLACE", true),
		FeaturePrescription: getEnvBool("FEATURE_PRESCRIPTION_WORKFLOW", true),
	}
	return cfg, nil
}

func (c *Config) EscrowAutoReleaseDuration() time.Duration {
	return time.Duration(c.EscrowAutoReleaseH) * time.Hour
}

func getEnv(k, d string) string {
	if v := os.Getenv(k); v != "" {
		return v
	}
	return d
}

func getEnvBool(k string, d bool) bool {
	v := os.Getenv(k)
	if v == "" {
		return d
	}
	b, err := strconv.ParseBool(v)
	if err != nil {
		return d
	}
	return b
}

func getEnvInt(k string, d int) int {
	v := os.Getenv(k)
	if v == "" {
		return d
	}
	i, err := strconv.Atoi(v)
	if err != nil {
		return d
	}
	return i
}

func getEnvFloat(k string, d float64) float64 {
	v := os.Getenv(k)
	if v == "" {
		return d
	}
	f, err := strconv.ParseFloat(v, 64)
	if err != nil {
		return d
	}
	return f
}
