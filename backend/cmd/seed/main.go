package main

import (
	"context"
	"fmt"
	"log"
	"math/rand"
	"os"
	"time"

	"github.com/joho/godotenv"
	"github.com/vitalink-africa/backend/internal/config"
	"github.com/vitalink-africa/backend/internal/models"
	"github.com/vitalink-africa/backend/internal/platform"
	"github.com/vitalink-africa/backend/internal/vitals"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
)

const demoPassword = "DemoPass123!"

type demoUser struct {
	Email    string
	Role     string
	FullName string
	Phone    string
}

var demoUsers = []demoUser{
	{"grace.patient@vitalink.demo", models.RolePatient, "Grace Adeyemi", "08031111111"},
	{"musa.patient@vitalink.demo", models.RolePatient, "Musa Ibrahim", "08032222222"},
	{"esther.patient@vitalink.demo", models.RolePatient, "Esther Okonkwo", "08033333333"},
	{"tunde.caregiver@vitalink.demo", models.RoleCaregiver, "Tunde Adeyemi", "08034444444"},
	{"helper@vitalink.demo", models.RoleHomeHelper, "Home Helper", "08035555555"},
	{"amina.chw@vitalink.demo", models.RoleCHW, "Amina Bello", "08036666666"},
	{"pharmacy@vitalink.demo", models.RolePharmacy, "HealthPlus Tanke", "08037777777"},
	{"doctor@vitalink.demo", models.RoleClinician, "Dr. Chinedu Okafor", "08038888888"},
	{"lab@vitalink.demo", models.RoleLab, "MediLab Ilorin", "08039999999"},
	{"admin@vitalink.demo", models.RoleAdmin, "Platform Admin", "08030000001"},
	{"superadmin@vitalink.demo", models.RoleSuperAdmin, "System Admin", "08030000002"},
}

func main() {
	_ = godotenv.Load()
	_ = godotenv.Load("../.env")
	_ = godotenv.Load("../../.env")

	cfg, _ := config.Load()
	ctx := context.Background()

	db, err := platform.ConnectMongo(ctx, cfg.MongoURI, cfg.MongoDB)
	if err != nil {
		log.Fatal(err)
	}

	fb, err := platform.NewFirebaseAuth(ctx, cfg.FirebaseProjectID, cfg.FirebaseSAPath)
	if err != nil {
		log.Fatal(err)
	}

	// Clear demo data
	for _, coll := range platform.CollectionNames() {
		_, _ = db.Collection(coll).DeleteMany(ctx, bson.M{})
	}

	userIDs := map[string]primitive.ObjectID{}
	firebaseUIDs := map[string]string{}

	for _, du := range demoUsers {
		uid := ""
		if fb.Available() {
			rec, err := fb.GetUserByEmail(ctx, du.Email)
			if err != nil {
				rec, err = fb.CreateUser(ctx, du.Email, demoPassword, du.FullName)
				if err != nil {
					log.Printf("firebase create %s: %v (using mock uid)", du.Email, err)
					uid = "mock-" + du.Email
				} else {
					uid = rec.UID
				}
			} else {
				uid = rec.UID
			}
			if uid != "" && !hasPrefix(uid, "mock-") {
				_ = fb.SetCustomClaims(ctx, uid, map[string]interface{}{
					"role": du.Role,
				})
			}
		} else {
			uid = "mock-" + du.Email
		}
		firebaseUIDs[du.Email] = uid

		now := time.Now().UTC()
		u := models.User{
			FirebaseUID:        uid,
			Email:              du.Email,
			Phone:              du.Phone,
			Role:               du.Role,
			FullName:           du.FullName,
			LanguagePreference: "en",
			CreatedAt:          now,
			UpdatedAt:          now,
			IsActive:           true,
		}
		res, err := db.Collection("users").InsertOne(ctx, u)
		if err != nil {
			log.Fatal(err)
		}
		userIDs[du.Email] = res.InsertedID.(primitive.ObjectID)
	}

	chwID := seedProviders(ctx, db, userIDs)
	pharmacyID := seedPharmacy(ctx, db, userIDs)
	clinicianID := seedClinician(ctx, db, userIDs)
	_ = seedLab(ctx, db, userIDs)

	graceID := seedPatient(ctx, db, userIDs["grace.patient@vitalink.demo"], "Grace Adeyemi", 64, "female",
		[]string{"hypertension", "diabetes"}, "Ilorin", "Kwara", &chwID, &pharmacyID, &clinicianID, "family_care", "active")
	musaID := seedPatient(ctx, db, userIDs["musa.patient@vitalink.demo"], "Musa Ibrahim", 58, "male",
		[]string{"hypertension"}, "Abuja", "FCT", nil, nil, nil, "basic_monitor", "active")
	estherID := seedPatient(ctx, db, userIDs["esther.patient@vitalink.demo"], "Esther Okonkwo", 71, "female",
		[]string{"diabetes"}, "Lagos", "Lagos", nil, &pharmacyID, &clinicianID, "premium_chronic", "active")

	seedCaregiverLink(ctx, db, userIDs["tunde.caregiver@vitalink.demo"], graceID, "son")
	seedHelper(ctx, db, graceID, "Home Helper", "08035555555", "neighbor")
	seedMedications(ctx, db, graceID)
	seedVitals(ctx, db, graceID, userIDs["grace.patient@vitalink.demo"], "yellow", 30)
	seedVitals(ctx, db, musaID, userIDs["musa.patient@vitalink.demo"], "green", 30)
	seedVitals(ctx, db, estherID, userIDs["esther.patient@vitalink.demo"], "red", 30)
	seedAlerts(ctx, db, graceID, "yellow")
	seedAlerts(ctx, db, estherID, "red")
	seedJob(ctx, db, graceID, userIDs["tunde.caregiver@vitalink.demo"], chwID)
	seedRefill(ctx, db, graceID, pharmacyID, userIDs["doctor@vitalink.demo"])
	seedPayout(ctx, db, chwID)
	seedFeatureFlags(ctx, db, userIDs["superadmin@vitalink.demo"])
	seedSubscriptions(ctx, db, graceID, userIDs["tunde.caregiver@vitalink.demo"])

	fmt.Println("Seed complete. Demo password:", demoPassword)
	for _, du := range demoUsers {
		fmt.Printf("  %s (%s)\n", du.Email, du.Role)
	}
}

func hasPrefix(s, prefix string) bool {
	return len(s) >= len(prefix) && s[:len(prefix)] == prefix
}

func seedPatient(ctx context.Context, db *mongo.Database, userID primitive.ObjectID, name string, age int, gender string,
	conditions []string, city, state string, chw, pharmacy, clinician *primitive.ObjectID, plan, subStatus string) primitive.ObjectID {
	exp := time.Now().AddDate(0, 1, 0)
	p := models.Patient{
		UserID: userID, FullName: name, Age: age, Gender: gender,
		Location: models.Location{City: city, State: state, LGA: city},
		Conditions: conditions,
		EmergencyContact: models.EmergencyContact{Name: "Emergency", Phone: "08000000000", Relationship: "family"},
		SubscriptionPlan: plan, SubscriptionStatus: subStatus, SubscriptionExpires: &exp,
		AssignedCHWID: chw, AssignedPharmacyID: pharmacy, AssignedClinicianID: clinician,
		IsActive: true,
	}
	now := time.Now().UTC()
	p.CreatedAt = now
	p.UpdatedAt = now
	res, _ := db.Collection("patients").InsertOne(ctx, p)
	return res.InsertedID.(primitive.ObjectID)
}

func seedProviders(ctx context.Context, db *mongo.Database, users map[string]primitive.ObjectID) primitive.ObjectID {
	return insertProvider(ctx, db, users["amina.chw@vitalink.demo"], models.RoleCHW, "Amina Bello", "Ilorin", "Kwara")
}

func seedPharmacy(ctx context.Context, db *mongo.Database, users map[string]primitive.ObjectID) primitive.ObjectID {
	return insertProvider(ctx, db, users["pharmacy@vitalink.demo"], models.RolePharmacy, "HealthPlus Tanke", "Ilorin", "Kwara")
}

func seedClinician(ctx context.Context, db *mongo.Database, users map[string]primitive.ObjectID) primitive.ObjectID {
	return insertProvider(ctx, db, users["doctor@vitalink.demo"], models.RoleClinician, "Dr. Chinedu Okafor", "Ilorin", "Kwara")
}

func seedLab(ctx context.Context, db *mongo.Database, users map[string]primitive.ObjectID) primitive.ObjectID {
	return insertProvider(ctx, db, users["lab@vitalink.demo"], models.RoleLab, "MediLab Ilorin", "Ilorin", "Kwara")
}

func insertProvider(ctx context.Context, db *mongo.Database, userID primitive.ObjectID, ptype, name, city, state string) primitive.ObjectID {
	now := time.Now().UTC()
	p := models.Provider{
		UserID: userID, ProviderType: ptype, DisplayName: name,
		Location: models.Location{City: city, State: state, LGA: city},
		Languages: []string{"en", "yo"}, VerificationStatus: "verified",
		Rating: 4.8, CompletionRate: 0.95, ResponseTimeAvgMinutes: 30,
		IsActive: true, CreatedAt: now, UpdatedAt: now,
	}
	res, _ := db.Collection("providers").InsertOne(ctx, p)
	pid := res.InsertedID.(primitive.ObjectID)
	_, _ = db.Collection("provider_wallets").InsertOne(ctx, models.ProviderWallet{
		ProviderID: pid, PendingBalance: 15000, AvailableBalance: 45000,
		LifetimeEarned: 250000, LastUpdated: now,
	})
	svc := models.ProviderService{
		ProviderID: pid, ServiceType: "home_visit", Title: "BP Check Home Visit",
		Description: "Community health worker home visit", PriceNaira: 3500,
		DurationMinutes: 45, IsActive: true, AdminApproved: true, CreatedAt: now,
	}
	_, _ = db.Collection("provider_services").InsertOne(ctx, svc)
	return pid
}

func seedCaregiverLink(ctx context.Context, db *mongo.Database, caregiverID, patientID primitive.ObjectID, rel string) {
	now := time.Now().UTC()
	_, _ = db.Collection("caregivers_patients").InsertOne(ctx, models.CaregiverPatient{
		CaregiverUserID: caregiverID, PatientID: patientID, ConsentStatus: "approved",
		ConsentGrantedAt: &now, Relationship: rel, CreatedAt: now,
	})
}

func seedHelper(ctx context.Context, db *mongo.Database, patientID primitive.ObjectID, name, phone, rel string) {
	_, _ = db.Collection("authorized_helpers").InsertOne(ctx, models.AuthorizedHelper{
		PatientID: patientID, HelperName: name, Phone: phone, Relationship: rel,
		ConsentStatus: "approved", CreatedAt: time.Now().UTC(),
	})
}

func seedMedications(ctx context.Context, db *mongo.Database, patientID primitive.ObjectID) {
	now := time.Now().UTC()
	meds := []models.Medication{
		{PatientID: patientID, DrugName: "Amlodipine", Dosage: "5mg", Frequency: "daily", TimesPerDay: 1, StartDate: now, IsActive: true, MedicationType: "prescription", CreatedAt: now},
		{PatientID: patientID, DrugName: "Metformin", Dosage: "500mg", Frequency: "twice daily", TimesPerDay: 2, StartDate: now, IsActive: true, MedicationType: "prescription", CreatedAt: now},
	}
	for _, m := range meds {
		_, _ = db.Collection("medications").InsertOne(ctx, m)
	}
}

func seedVitals(ctx context.Context, db *mongo.Database, patientID, capturedBy primitive.ObjectID, targetRisk string, days int) {
	rng := rand.New(rand.NewSource(42))
	th := vitals.DefaultThresholds()
	for i := days; i >= 0; i-- {
		sys := 118 + rng.Intn(25)
		dia := 75 + rng.Intn(15)
		if targetRisk == "yellow" && i < 3 {
			sys = 155
			dia = 95
		}
		if targetRisk == "red" && i < 2 {
			sys = 185
			dia = 122
		}
		fast := 95.0 + rng.Float64()*20
		in := vitals.RiskInput{SystolicBP: &sys, DiastolicBP: &dia, GlucoseFasting: &fast}
		risk := vitals.CalculateRisk(in, th)
		created := time.Now().UTC().AddDate(0, 0, -i)
		v := models.Vital{
			PatientID: patientID, SystolicBP: &sys, DiastolicBP: &dia, GlucoseFasting: &fast,
			MedicationTaken: true, RiskStatus: risk, SourceType: "patient_self",
			CapturedByUserID: capturedBy, CaptureLocationType: "home", PatientConsented: true,
			CreatedAt: created,
		}
		_, _ = db.Collection("vitals").InsertOne(ctx, v)
	}
}

func seedAlerts(ctx context.Context, db *mongo.Database, patientID primitive.ObjectID, severity string) {
	_, _ = db.Collection("alerts").InsertOne(ctx, models.Alert{
		PatientID: patientID, AlertType: "high_bp", Severity: severity,
		Status: "open", Message: "Reading requires attention", CreatedAt: time.Now().UTC(),
	})
}

func seedJob(ctx context.Context, db *mongo.Database, patientID, caregiverID, providerID primitive.ObjectID) {
	now := time.Now().UTC()
	var svc models.ProviderService
	_ = db.Collection("provider_services").FindOne(ctx, bson.M{"provider_id": providerID}).Decode(&svc)
	job := models.ServiceJob{
		PatientID: patientID, CaregiverID: &caregiverID, ProviderID: providerID,
		ServiceType: "home_visit", ServiceID: svc.ID,
		ScheduledAt: now.AddDate(0, 0, -5), Status: "released",
		PriceNaira: 3500, VitalinkCommission: 525, ProviderPayout: 2975,
		EscrowStatus: "released", PaymentReference: "mock_ref_completed",
		CreatedAt: now.AddDate(0, 0, -7), UpdatedAt: now,
	}
	res, _ := db.Collection("service_jobs").InsertOne(ctx, job)
	jobID := res.InsertedID.(primitive.ObjectID)
	_, _ = db.Collection("service_completion_proofs").InsertOne(ctx, models.ServiceCompletionProof{
		JobID: jobID, ProviderID: providerID, OTPConfirmed: true,
		CompletionNote: "Visit completed", VitalsCaptured: true, CompletedAt: now,
	})
}

func seedRefill(ctx context.Context, db *mongo.Database, patientID, pharmacyID, clinicianID primitive.ObjectID) {
	rx := models.Prescription{
		PatientID: patientID, ClinicianID: clinicianID, MedicationName: "Amlodipine",
		MedicationType: "prescription", Dosage: "5mg", Frequency: "daily",
		RefillCountRemaining: 2, ExpiresAt: time.Now().AddDate(0, 6, 0),
		Status: "active", CreatedAt: time.Now().UTC(),
	}
	rxRes, _ := db.Collection("prescriptions").InsertOne(ctx, rx)
	_, _ = db.Collection("pharmacy_refills").InsertOne(ctx, models.PharmacyRefill{
		PatientID: patientID, PrescriptionID: rxRes.InsertedID.(primitive.ObjectID),
		PharmacyID: pharmacyID, MedicationName: "Amlodipine", Status: "requested",
		PickupOTP: "482910", RequestedAt: time.Now().UTC(),
	})
}

func seedPayout(ctx context.Context, db *mongo.Database, providerID primitive.ObjectID) {
	_, _ = db.Collection("payouts").InsertOne(ctx, models.Payout{
		ProviderID: providerID, Amount: 25000, Status: "pending",
		BankCode: "058", AccountNumber: "0123456789", AccountName: "Amina Bello",
		CreatedAt: time.Now().UTC(),
	})
}

func seedFeatureFlags(ctx context.Context, db *mongo.Database, adminID primitive.ObjectID) {
	flags := []models.FeatureFlag{
		{FlagName: "ai_summaries", IsEnabled: false, Description: "AI trend summaries"},
		{FlagName: "paystack_live", IsEnabled: false, Description: "Live Paystack mode"},
		{FlagName: "ussd", IsEnabled: true, Description: "USSD vitals entry"},
		{FlagName: "marketplace", IsEnabled: true, Description: "Service marketplace"},
		{FlagName: "prescription_workflow", IsEnabled: true, Description: "Prescription workflow"},
	}
	now := time.Now().UTC()
	for _, f := range flags {
		f.UpdatedBy = adminID
		f.UpdatedAt = now
		_, _ = db.Collection("feature_flags").InsertOne(ctx, f)
	}
}

func seedSubscriptions(ctx context.Context, db *mongo.Database, patientID, payerID primitive.ObjectID) {
	now := time.Now().UTC()
	_, _ = db.Collection("subscriptions").InsertOne(ctx, models.Subscription{
		PatientID: patientID, PayerUserID: payerID, Plan: "family_care",
		PriceNaira: 5000, BillingCycle: "monthly", Status: "active",
		StartedAt: now, ExpiresAt: now.AddDate(0, 1, 0), CreatedAt: now,
	})
}

// suppress unused import
var _ = os.Getenv
