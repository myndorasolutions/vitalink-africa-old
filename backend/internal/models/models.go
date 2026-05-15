package models

import (
	"time"

	"go.mongodb.org/mongo-driver/bson/primitive"
)

// Roles
const (
	RolePatient     = "patient"
	RoleCaregiver   = "caregiver"
	RoleHomeHelper  = "home_helper"
	RoleCHW         = "chw"
	RolePharmacy    = "pharmacy"
	RoleClinician   = "clinician"
	RoleLab         = "lab"
	RoleAdmin       = "admin"
	RoleSuperAdmin  = "super_admin"
)

type Location struct {
	City    string  `bson:"city" json:"city"`
	State   string  `bson:"state" json:"state"`
	LGA     string  `bson:"lga" json:"lga"`
	Address string  `bson:"address,omitempty" json:"address,omitempty"`
	Lat     float64 `bson:"lat,omitempty" json:"lat,omitempty"`
	Lng     float64 `bson:"lng,omitempty" json:"lng,omitempty"`
}

type EmergencyContact struct {
	Name         string `bson:"name" json:"name"`
	Phone        string `bson:"phone" json:"phone"`
	Relationship string `bson:"relationship" json:"relationship"`
}

type User struct {
	ID                 primitive.ObjectID `bson:"_id,omitempty" json:"id"`
	FirebaseUID        string             `bson:"firebase_uid" json:"firebase_uid"`
	Email              string             `bson:"email" json:"email"`
	Phone              string             `bson:"phone" json:"phone"`
	Role               string             `bson:"role" json:"role"`
	FullName           string             `bson:"full_name" json:"full_name"`
	LanguagePreference string             `bson:"language_preference" json:"language_preference"`
	CreatedAt          time.Time          `bson:"created_at" json:"created_at"`
	UpdatedAt          time.Time          `bson:"updated_at" json:"updated_at"`
	IsActive           bool               `bson:"is_active" json:"is_active"`
	MFAEnabled         bool               `bson:"mfa_enabled" json:"mfa_enabled"`
	LastLogin          *time.Time         `bson:"last_login,omitempty" json:"last_login,omitempty"`
}

type Patient struct {
	ID                   primitive.ObjectID `bson:"_id,omitempty" json:"id"`
	UserID               primitive.ObjectID `bson:"user_id" json:"user_id"`
	FullName             string             `bson:"full_name" json:"full_name"`
	Age                  int                `bson:"age" json:"age"`
	Gender               string             `bson:"gender" json:"gender"`
	DOB                  *time.Time         `bson:"dob,omitempty" json:"dob,omitempty"`
	Location             Location           `bson:"location" json:"location"`
	Conditions           []string           `bson:"conditions" json:"conditions"`
	EmergencyContact     EmergencyContact   `bson:"emergency_contact" json:"emergency_contact"`
	SubscriptionPlan     string             `bson:"subscription_plan" json:"subscription_plan"`
	SubscriptionStatus   string             `bson:"subscription_status" json:"subscription_status"`
	SubscriptionExpires  *time.Time         `bson:"subscription_expires_at,omitempty" json:"subscription_expires_at,omitempty"`
	AssignedCHWID        *primitive.ObjectID `bson:"assigned_chw_id,omitempty" json:"assigned_chw_id,omitempty"`
	AssignedPharmacyID   *primitive.ObjectID `bson:"assigned_pharmacy_id,omitempty" json:"assigned_pharmacy_id,omitempty"`
	AssignedClinicianID  *primitive.ObjectID `bson:"assigned_clinician_id,omitempty" json:"assigned_clinician_id,omitempty"`
	CreatedAt            time.Time          `bson:"created_at" json:"created_at"`
	UpdatedAt            time.Time          `bson:"updated_at" json:"updated_at"`
	IsActive             bool               `bson:"is_active" json:"is_active"`
}

type Vital struct {
	ID                  primitive.ObjectID `bson:"_id,omitempty" json:"id"`
	PatientID           primitive.ObjectID `bson:"patient_id" json:"patient_id"`
	SystolicBP          *int               `bson:"systolic_bp,omitempty" json:"systolic_bp,omitempty"`
	DiastolicBP         *int               `bson:"diastolic_bp,omitempty" json:"diastolic_bp,omitempty"`
	Pulse               *int               `bson:"pulse,omitempty" json:"pulse,omitempty"`
	GlucoseFasting      *float64           `bson:"glucose_fasting,omitempty" json:"glucose_fasting,omitempty"`
	GlucoseRandom       *float64           `bson:"glucose_random,omitempty" json:"glucose_random,omitempty"`
	WeightKg            *float64           `bson:"weight_kg,omitempty" json:"weight_kg,omitempty"`
	Symptoms            []string           `bson:"symptoms" json:"symptoms"`
	MedicationTaken     bool               `bson:"medication_taken" json:"medication_taken"`
	Notes               string             `bson:"notes,omitempty" json:"notes,omitempty"`
	RiskStatus          string             `bson:"risk_status" json:"risk_status"`
	SourceType          string             `bson:"source_type" json:"source_type"`
	CapturedByUserID    primitive.ObjectID `bson:"captured_by_user_id" json:"captured_by_user_id"`
	CaptureLocationType string             `bson:"capture_location_type" json:"capture_location_type"`
	PatientConsented    bool               `bson:"patient_consented" json:"patient_consented"`
	CreatedAt           time.Time          `bson:"created_at" json:"created_at"`
}

type Alert struct {
	ID               primitive.ObjectID  `bson:"_id,omitempty" json:"id"`
	PatientID        primitive.ObjectID  `bson:"patient_id" json:"patient_id"`
	VitalID          *primitive.ObjectID `bson:"vital_id,omitempty" json:"vital_id,omitempty"`
	AlertType        string              `bson:"alert_type" json:"alert_type"`
	Severity         string              `bson:"severity" json:"severity"`
	Status           string              `bson:"status" json:"status"`
	AssignedToRole   string              `bson:"assigned_to_role,omitempty" json:"assigned_to_role,omitempty"`
	AssignedToUserID *primitive.ObjectID `bson:"assigned_to_user_id,omitempty" json:"assigned_to_user_id,omitempty"`
	Message          string              `bson:"message" json:"message"`
	CreatedAt        time.Time           `bson:"created_at" json:"created_at"`
	ResolvedAt       *time.Time          `bson:"resolved_at,omitempty" json:"resolved_at,omitempty"`
	ResolvedBy       *primitive.ObjectID `bson:"resolved_by,omitempty" json:"resolved_by,omitempty"`
}

type CaregiverPatient struct {
	ID               primitive.ObjectID `bson:"_id,omitempty" json:"id"`
	CaregiverUserID  primitive.ObjectID `bson:"caregiver_user_id" json:"caregiver_user_id"`
	PatientID        primitive.ObjectID `bson:"patient_id" json:"patient_id"`
	ConsentStatus    string             `bson:"consent_status" json:"consent_status"`
	ConsentGrantedAt *time.Time         `bson:"consent_granted_at,omitempty" json:"consent_granted_at,omitempty"`
	ConsentRevokedAt *time.Time         `bson:"consent_revoked_at,omitempty" json:"consent_revoked_at,omitempty"`
	Relationship     string             `bson:"relationship" json:"relationship"`
	CreatedAt        time.Time          `bson:"created_at" json:"created_at"`
}

type AuthorizedHelper struct {
	ID            primitive.ObjectID `bson:"_id,omitempty" json:"id"`
	PatientID     primitive.ObjectID `bson:"patient_id" json:"patient_id"`
	HelperName    string             `bson:"helper_name" json:"helper_name"`
	Phone         string             `bson:"phone" json:"phone"`
	Relationship  string             `bson:"relationship" json:"relationship"`
	ConsentStatus string             `bson:"consent_status" json:"consent_status"`
	CreatedAt     time.Time          `bson:"created_at" json:"created_at"`
}

type Medication struct {
	ID             primitive.ObjectID `bson:"_id,omitempty" json:"id"`
	PatientID      primitive.ObjectID `bson:"patient_id" json:"patient_id"`
	DrugName       string             `bson:"drug_name" json:"drug_name"`
	Dosage         string             `bson:"dosage" json:"dosage"`
	Frequency      string             `bson:"frequency" json:"frequency"`
	TimesPerDay    int                `bson:"times_per_day" json:"times_per_day"`
	StartDate      time.Time          `bson:"start_date" json:"start_date"`
	EndDate        *time.Time         `bson:"end_date,omitempty" json:"end_date,omitempty"`
	IsActive       bool               `bson:"is_active" json:"is_active"`
	MedicationType string             `bson:"medication_type" json:"medication_type"`
	CreatedAt      time.Time          `bson:"created_at" json:"created_at"`
}

type Prescription struct {
	ID                    primitive.ObjectID `bson:"_id,omitempty" json:"id"`
	PatientID             primitive.ObjectID `bson:"patient_id" json:"patient_id"`
	ClinicianID           primitive.ObjectID `bson:"clinician_id" json:"clinician_id"`
	MedicationName        string             `bson:"medication_name" json:"medication_name"`
	MedicationType        string             `bson:"medication_type" json:"medication_type"`
	Dosage                string             `bson:"dosage" json:"dosage"`
	Frequency             string             `bson:"frequency" json:"frequency"`
	RefillCountRemaining  int                `bson:"refill_count_remaining" json:"refill_count_remaining"`
	ExpiresAt             time.Time          `bson:"expires_at" json:"expires_at"`
	Status                string             `bson:"status" json:"status"`
	CreatedAt             time.Time          `bson:"created_at" json:"created_at"`
}

type VerificationDoc struct {
	Type       string    `bson:"type" json:"type"`
	URL        string    `bson:"url" json:"url"`
	UploadedAt time.Time `bson:"uploaded_at" json:"uploaded_at"`
}

type Provider struct {
	ID                      primitive.ObjectID `bson:"_id,omitempty" json:"id"`
	UserID                  primitive.ObjectID `bson:"user_id" json:"user_id"`
	ProviderType            string             `bson:"provider_type" json:"provider_type"`
	DisplayName             string             `bson:"display_name" json:"display_name"`
	Bio                     string             `bson:"bio,omitempty" json:"bio,omitempty"`
	Location                Location           `bson:"location" json:"location"`
	Languages               []string           `bson:"languages" json:"languages"`
	VerificationStatus      string             `bson:"verification_status" json:"verification_status"`
	VerificationDocuments   []VerificationDoc  `bson:"verification_documents" json:"verification_documents"`
	Rating                  float64            `bson:"rating" json:"rating"`
	CompletionRate          float64            `bson:"completion_rate" json:"completion_rate"`
	ResponseTimeAvgMinutes  float64            `bson:"response_time_avg_minutes" json:"response_time_avg_minutes"`
	IsActive                bool               `bson:"is_active" json:"is_active"`
	CreatedAt               time.Time          `bson:"created_at" json:"created_at"`
	UpdatedAt               time.Time          `bson:"updated_at" json:"updated_at"`
	CoverageRadiusKm        float64            `bson:"coverage_radius_km,omitempty" json:"coverage_radius_km,omitempty"`
}

type ProviderService struct {
	ID            primitive.ObjectID `bson:"_id,omitempty" json:"id"`
	ProviderID    primitive.ObjectID `bson:"provider_id" json:"provider_id"`
	ServiceType   string             `bson:"service_type" json:"service_type"`
	Title         string             `bson:"title" json:"title"`
	Description   string             `bson:"description" json:"description"`
	PriceNaira    int64              `bson:"price_naira" json:"price_naira"`
	DurationMinutes int              `bson:"duration_minutes" json:"duration_minutes"`
	IsActive      bool               `bson:"is_active" json:"is_active"`
	AdminApproved bool               `bson:"admin_approved" json:"admin_approved"`
	CreatedAt     time.Time          `bson:"created_at" json:"created_at"`
}

type DistanceRule struct {
	MaxKm    float64 `bson:"max_km" json:"max_km"`
	ExtraFee int64   `bson:"extra_fee" json:"extra_fee"`
}

type ProviderPriceCap struct {
	ID              primitive.ObjectID `bson:"_id,omitempty" json:"id"`
	City            string             `bson:"city" json:"city"`
	State           string             `bson:"state" json:"state"`
	ServiceType     string             `bson:"service_type" json:"service_type"`
	MaxPriceNaira   int64              `bson:"max_price_naira" json:"max_price_naira"`
	DistanceRules   []DistanceRule     `bson:"distance_rules" json:"distance_rules"`
	EffectiveDate   time.Time          `bson:"effective_date" json:"effective_date"`
	CreatedByAdminID primitive.ObjectID `bson:"created_by_admin_id" json:"created_by_admin_id"`
}

type ServiceJob struct {
	ID                 primitive.ObjectID  `bson:"_id,omitempty" json:"id"`
	PatientID          primitive.ObjectID  `bson:"patient_id" json:"patient_id"`
	CaregiverID        *primitive.ObjectID `bson:"caregiver_id,omitempty" json:"caregiver_id,omitempty"`
	ProviderID         primitive.ObjectID  `bson:"provider_id" json:"provider_id"`
	ServiceType        string              `bson:"service_type" json:"service_type"`
	ServiceID          primitive.ObjectID  `bson:"service_id" json:"service_id"`
	ScheduledAt        time.Time           `bson:"scheduled_at" json:"scheduled_at"`
	Status             string              `bson:"status" json:"status"`
	PriceNaira         int64               `bson:"price_naira" json:"price_naira"`
	VitalinkCommission int64               `bson:"vitalink_commission" json:"vitalink_commission"`
	ProviderPayout     int64               `bson:"provider_payout" json:"provider_payout"`
	EscrowStatus       string              `bson:"escrow_status" json:"escrow_status"`
	PaymentReference   string              `bson:"payment_reference,omitempty" json:"payment_reference,omitempty"`
	CompletionOTP      string              `bson:"completion_otp,omitempty" json:"completion_otp,omitempty"`
	CreatedAt          time.Time           `bson:"created_at" json:"created_at"`
	UpdatedAt          time.Time           `bson:"updated_at" json:"updated_at"`
}

type ServiceCompletionProof struct {
	ID             primitive.ObjectID `bson:"_id,omitempty" json:"id"`
	JobID          primitive.ObjectID `bson:"job_id" json:"job_id"`
	ProviderID     primitive.ObjectID `bson:"provider_id" json:"provider_id"`
	OTPConfirmed   bool               `bson:"otp_confirmed" json:"otp_confirmed"`
	CompletionNote string             `bson:"completion_note" json:"completion_note"`
	AttachmentURL  string             `bson:"attachment_url,omitempty" json:"attachment_url,omitempty"`
	GeoLat         float64            `bson:"geo_lat,omitempty" json:"geo_lat,omitempty"`
	GeoLng         float64            `bson:"geo_lng,omitempty" json:"geo_lng,omitempty"`
	VitalsCaptured bool               `bson:"vitals_captured" json:"vitals_captured"`
	CompletedAt    time.Time          `bson:"completed_at" json:"completed_at"`
}

type ProviderWallet struct {
	ID               primitive.ObjectID `bson:"_id,omitempty" json:"id"`
	ProviderID       primitive.ObjectID `bson:"provider_id" json:"provider_id"`
	PendingBalance   int64              `bson:"pending_balance" json:"pending_balance"`
	AvailableBalance int64              `bson:"available_balance" json:"available_balance"`
	LifetimeEarned   int64              `bson:"lifetime_earned" json:"lifetime_earned"`
	LastUpdated      time.Time          `bson:"last_updated" json:"last_updated"`
}

type Payout struct {
	ID            primitive.ObjectID `bson:"_id,omitempty" json:"id"`
	ProviderID    primitive.ObjectID `bson:"provider_id" json:"provider_id"`
	Amount        int64              `bson:"amount" json:"amount"`
	Status        string             `bson:"status" json:"status"`
	BankReference string             `bson:"bank_reference,omitempty" json:"bank_reference,omitempty"`
	BankCode      string             `bson:"bank_code" json:"bank_code"`
	AccountNumber string             `bson:"account_number" json:"account_number"`
	AccountName   string             `bson:"account_name" json:"account_name"`
	PayoutDate    *time.Time         `bson:"payout_date,omitempty" json:"payout_date,omitempty"`
	CreatedAt     time.Time          `bson:"created_at" json:"created_at"`
}

type Subscription struct {
	ID                     primitive.ObjectID `bson:"_id,omitempty" json:"id"`
	PatientID              primitive.ObjectID `bson:"patient_id" json:"patient_id"`
	PayerUserID            primitive.ObjectID `bson:"payer_user_id" json:"payer_user_id"`
	Plan                   string             `bson:"plan" json:"plan"`
	PriceNaira             int64              `bson:"price_naira" json:"price_naira"`
	BillingCycle           string             `bson:"billing_cycle" json:"billing_cycle"`
	Status                 string             `bson:"status" json:"status"`
	StartedAt              time.Time          `bson:"started_at" json:"started_at"`
	ExpiresAt              time.Time          `bson:"expires_at" json:"expires_at"`
	PaystackSubscriptionCode string             `bson:"paystack_subscription_code,omitempty" json:"paystack_subscription_code,omitempty"`
	CreatedAt              time.Time          `bson:"created_at" json:"created_at"`
}

type Payment struct {
	ID               primitive.ObjectID `bson:"_id,omitempty" json:"id"`
	UserID           primitive.ObjectID `bson:"user_id" json:"user_id"`
	PatientID        *primitive.ObjectID `bson:"patient_id,omitempty" json:"patient_id,omitempty"`
	Type             string             `bson:"type" json:"type"`
	AmountNaira      int64              `bson:"amount_naira" json:"amount_naira"`
	Currency         string             `bson:"currency" json:"currency"`
	Status           string             `bson:"status" json:"status"`
	PaystackReference string            `bson:"paystack_reference" json:"paystack_reference"`
	PaystackResponse map[string]any     `bson:"paystack_response,omitempty" json:"paystack_response,omitempty"`
	JobID            *primitive.ObjectID `bson:"job_id,omitempty" json:"job_id,omitempty"`
	CreatedAt        time.Time          `bson:"created_at" json:"created_at"`
}

type PharmacyRefill struct {
	ID               primitive.ObjectID `bson:"_id,omitempty" json:"id"`
	PatientID        primitive.ObjectID `bson:"patient_id" json:"patient_id"`
	PrescriptionID   primitive.ObjectID `bson:"prescription_id" json:"prescription_id"`
	PharmacyID       primitive.ObjectID `bson:"pharmacy_id" json:"pharmacy_id"`
	MedicationName   string             `bson:"medication_name" json:"medication_name"`
	Status           string             `bson:"status" json:"status"`
	PickupOTP        string             `bson:"pickup_otp,omitempty" json:"pickup_otp,omitempty"`
	IdentityVerified bool               `bson:"identity_verified" json:"identity_verified"`
	RequestedAt      time.Time          `bson:"requested_at" json:"requested_at"`
	FulfilledAt      *time.Time         `bson:"fulfilled_at,omitempty" json:"fulfilled_at,omitempty"`
}

type CHWVisit struct {
	ID                primitive.ObjectID  `bson:"_id,omitempty" json:"id"`
	PatientID         primitive.ObjectID  `bson:"patient_id" json:"patient_id"`
	CHWID             primitive.ObjectID  `bson:"chw_id" json:"chw_id"`
	JobID             *primitive.ObjectID `bson:"job_id,omitempty" json:"job_id,omitempty"`
	VisitType         string              `bson:"visit_type" json:"visit_type"`
	VisitDate         time.Time           `bson:"visit_date" json:"visit_date"`
	VitalsCaptured    bool                `bson:"vitals_captured" json:"vitals_captured"`
	VitalID           *primitive.ObjectID `bson:"vital_id,omitempty" json:"vital_id,omitempty"`
	Notes             string              `bson:"notes" json:"notes"`
	Escalated         bool                `bson:"escalated" json:"escalated"`
	EscalationReason  string              `bson:"escalation_reason,omitempty" json:"escalation_reason,omitempty"`
	CreatedAt         time.Time           `bson:"created_at" json:"created_at"`
}

type LabOrder struct {
	ID           primitive.ObjectID `bson:"_id,omitempty" json:"id"`
	PatientID    primitive.ObjectID `bson:"patient_id" json:"patient_id"`
	ClinicianID  primitive.ObjectID `bson:"clinician_id" json:"clinician_id"`
	LabID        primitive.ObjectID `bson:"lab_id" json:"lab_id"`
	TestTypes    []string           `bson:"test_types" json:"test_types"`
	Status       string             `bson:"status" json:"status"`
	ScheduledAt  *time.Time         `bson:"scheduled_at,omitempty" json:"scheduled_at,omitempty"`
	ResultURL    string             `bson:"result_url,omitempty" json:"result_url,omitempty"`
	ResultNotes  string             `bson:"result_notes,omitempty" json:"result_notes,omitempty"`
	IsAbnormal   bool               `bson:"is_abnormal" json:"is_abnormal"`
	CreatedAt    time.Time          `bson:"created_at" json:"created_at"`
}

type ConsentRecord struct {
	ID              primitive.ObjectID `bson:"_id,omitempty" json:"id"`
	PatientID       primitive.ObjectID `bson:"patient_id" json:"patient_id"`
	GrantedToUserID primitive.ObjectID `bson:"granted_to_user_id" json:"granted_to_user_id"`
	ConsentType     string             `bson:"consent_type" json:"consent_type"`
	Version         string             `bson:"version" json:"version"`
	Status          string             `bson:"status" json:"status"`
	GrantedAt       time.Time          `bson:"granted_at" json:"granted_at"`
	RevokedAt       *time.Time         `bson:"revoked_at,omitempty" json:"revoked_at,omitempty"`
	IPAddress       string             `bson:"ip_address,omitempty" json:"ip_address,omitempty"`
}

type Notification struct {
	ID              primitive.ObjectID  `bson:"_id,omitempty" json:"id"`
	RecipientUserID primitive.ObjectID  `bson:"recipient_user_id" json:"recipient_user_id"`
	PatientID       *primitive.ObjectID `bson:"patient_id,omitempty" json:"patient_id,omitempty"`
	Channel         string              `bson:"channel" json:"channel"`
	Type            string              `bson:"type" json:"type"`
	Title           string              `bson:"title" json:"title"`
	Body            string              `bson:"body" json:"body"`
	Status          string              `bson:"status" json:"status"`
	SentAt          *time.Time          `bson:"sent_at,omitempty" json:"sent_at,omitempty"`
	CreatedAt       time.Time           `bson:"created_at" json:"created_at"`
	ReadAt          *time.Time          `bson:"read_at,omitempty" json:"read_at,omitempty"`
}

type AuditLog struct {
	ID           primitive.ObjectID `bson:"_id,omitempty" json:"id"`
	ActorUserID  primitive.ObjectID `bson:"actor_user_id" json:"actor_user_id"`
	PatientID    *primitive.ObjectID `bson:"patient_id,omitempty" json:"patient_id,omitempty"`
	Action       string             `bson:"action" json:"action"`
	ResourceType string             `bson:"resource_type" json:"resource_type"`
	ResourceID   string             `bson:"resource_id" json:"resource_id"`
	OldValue     any                `bson:"old_value,omitempty" json:"old_value,omitempty"`
	NewValue     any                `bson:"new_value,omitempty" json:"new_value,omitempty"`
	IPAddress    string             `bson:"ip_address" json:"ip_address"`
	UserAgent    string             `bson:"user_agent" json:"user_agent"`
	CreatedAt    time.Time          `bson:"created_at" json:"created_at"`
}

type MessagePolicyEvent struct {
	ID                primitive.ObjectID  `bson:"_id,omitempty" json:"id"`
	SenderID          primitive.ObjectID  `bson:"sender_id" json:"sender_id"`
	ReceiverID        primitive.ObjectID  `bson:"receiver_id" json:"receiver_id"`
	JobID             *primitive.ObjectID `bson:"job_id,omitempty" json:"job_id,omitempty"`
	PatternDetected   string              `bson:"pattern_detected" json:"pattern_detected"`
	MessageSnippetHash string             `bson:"message_snippet_hash" json:"message_snippet_hash"`
	ActionTaken       string              `bson:"action_taken" json:"action_taken"`
	CreatedAt         time.Time           `bson:"created_at" json:"created_at"`
}

type ProviderPolicyViolation struct {
	ID            primitive.ObjectID `bson:"_id,omitempty" json:"id"`
	ProviderID    primitive.ObjectID `bson:"provider_id" json:"provider_id"`
	ViolationType string             `bson:"violation_type" json:"violation_type"`
	Evidence      string             `bson:"evidence" json:"evidence"`
	AdminNotes    string             `bson:"admin_notes,omitempty" json:"admin_notes,omitempty"`
	Status        string             `bson:"status" json:"status"`
	CreatedAt     time.Time          `bson:"created_at" json:"created_at"`
}

type Dispute struct {
	ID             primitive.ObjectID `bson:"_id,omitempty" json:"id"`
	JobID          primitive.ObjectID `bson:"job_id" json:"job_id"`
	RaisedByUserID primitive.ObjectID `bson:"raised_by_user_id" json:"raised_by_user_id"`
	Reason         string             `bson:"reason" json:"reason"`
	EvidenceURLs   []string           `bson:"evidence_urls" json:"evidence_urls"`
	Status         string             `bson:"status" json:"status"`
	AdminNotes     string             `bson:"admin_notes,omitempty" json:"admin_notes,omitempty"`
	ResolvedBy     *primitive.ObjectID `bson:"resolved_by,omitempty" json:"resolved_by,omitempty"`
	ResolvedAt     *time.Time         `bson:"resolved_at,omitempty" json:"resolved_at,omitempty"`
	CreatedAt      time.Time          `bson:"created_at" json:"created_at"`
}

type FeatureFlag struct {
	ID          primitive.ObjectID `bson:"_id,omitempty" json:"id"`
	FlagName    string             `bson:"flag_name" json:"flag_name"`
	IsEnabled   bool               `bson:"is_enabled" json:"is_enabled"`
	Description string             `bson:"description" json:"description"`
	UpdatedBy   primitive.ObjectID `bson:"updated_by" json:"updated_by"`
	UpdatedAt   time.Time          `bson:"updated_at" json:"updated_at"`
}

type InAppMessage struct {
	ID         primitive.ObjectID `bson:"_id,omitempty" json:"id"`
	JobID      primitive.ObjectID `bson:"job_id" json:"job_id"`
	SenderID   primitive.ObjectID `bson:"sender_id" json:"sender_id"`
	ReceiverID primitive.ObjectID `bson:"receiver_id" json:"receiver_id"`
	Body       string             `bson:"body" json:"body"`
	CreatedAt  time.Time          `bson:"created_at" json:"created_at"`
}

type ClinicalNote struct {
	ID          primitive.ObjectID `bson:"_id,omitempty" json:"id"`
	PatientID   primitive.ObjectID `bson:"patient_id" json:"patient_id"`
	ClinicianID primitive.ObjectID `bson:"clinician_id" json:"clinician_id"`
	Note        string             `bson:"note" json:"note"`
	CreatedAt   time.Time          `bson:"created_at" json:"created_at"`
}
