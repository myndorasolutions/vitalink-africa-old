-- CreateSchema
CREATE SCHEMA IF NOT EXISTS "public";

-- CreateEnum
CREATE TYPE "UserRole" AS ENUM ('patient', 'caregiver', 'home_helper', 'chw', 'pharmacy', 'clinician', 'lab', 'admin', 'super_admin');

-- CreateEnum
CREATE TYPE "VitalSourceType" AS ENUM ('patient_self', 'caregiver_entry', 'home_helper_entry', 'chw_visit', 'pharmacy_walk_in', 'community_screening');

-- CreateEnum
CREATE TYPE "CaptureLocationType" AS ENUM ('home', 'pharmacy', 'community_event', 'clinic', 'unknown');

-- CreateEnum
CREATE TYPE "ConditionType" AS ENUM ('hypertension', 'diabetes', 'both');

-- CreateEnum
CREATE TYPE "RiskStatus" AS ENUM ('green', 'yellow', 'red');

-- CreateEnum
CREATE TYPE "AlertType" AS ENUM ('high_bp', 'high_glucose', 'missed_reading', 'missed_medication', 'symptom_escalation');

-- CreateEnum
CREATE TYPE "AlertSeverity" AS ENUM ('yellow', 'red');

-- CreateEnum
CREATE TYPE "AlertStatus" AS ENUM ('open', 'assigned', 'resolved', 'escalated');

-- CreateEnum
CREATE TYPE "ConsentStatus" AS ENUM ('pending', 'approved', 'revoked');

-- CreateEnum
CREATE TYPE "ConsentType" AS ENUM ('caregiver', 'home_helper', 'data_export');

-- CreateEnum
CREATE TYPE "ConsentRecordStatus" AS ENUM ('active', 'revoked');

-- CreateEnum
CREATE TYPE "SubscriptionPlan" AS ENUM ('free_check', 'basic_monitor', 'family_care', 'assisted_care', 'premium_chronic');

-- CreateEnum
CREATE TYPE "SubscriptionStatus" AS ENUM ('active', 'expired', 'cancelled', 'trial');

-- CreateEnum
CREATE TYPE "MedicationType" AS ENUM ('otc', 'prescription', 'controlled');

-- CreateEnum
CREATE TYPE "PrescriptionStatus" AS ENUM ('active', 'expired', 'cancelled');

-- CreateEnum
CREATE TYPE "ProviderType" AS ENUM ('chw', 'pharmacy', 'clinician', 'lab');

-- CreateEnum
CREATE TYPE "VerificationStatus" AS ENUM ('pending', 'verified', 'suspended');

-- CreateEnum
CREATE TYPE "ServiceJobStatus" AS ENUM ('booked', 'accepted', 'declined', 'in_progress', 'completed_pending', 'released', 'disputed', 'cancelled', 'refunded');

-- CreateEnum
CREATE TYPE "EscrowStatus" AS ENUM ('initialized', 'paid_held', 'accepted', 'completed_pending_confirmation', 'released', 'disputed', 'refunded');

-- CreateEnum
CREATE TYPE "PaymentType" AS ENUM ('subscription', 'service', 'refund');

-- CreateEnum
CREATE TYPE "PaymentStatus" AS ENUM ('pending', 'success', 'failed', 'refunded');

-- CreateEnum
CREATE TYPE "PayoutStatus" AS ENUM ('pending', 'processing', 'completed', 'failed');

-- CreateEnum
CREATE TYPE "PharmacyRefillStatus" AS ENUM ('requested', 'approved', 'ready', 'fulfilled', 'cancelled');

-- CreateEnum
CREATE TYPE "CHWVisitType" AS ENUM ('routine', 'urgent', 'missed_reading_followup');

-- CreateEnum
CREATE TYPE "LabOrderStatus" AS ENUM ('ordered', 'scheduled', 'sample_collected', 'resulted', 'abnormal_flagged');

-- CreateEnum
CREATE TYPE "DisputeStatus" AS ENUM ('open', 'under_review', 'resolved_refund', 'resolved_release', 'closed');

-- CreateEnum
CREATE TYPE "PolicyViolationType" AS ENUM ('off_platform_solicitation', 'prescription_bypass', 'identity_fraud');

-- CreateEnum
CREATE TYPE "PolicyViolationStatus" AS ENUM ('pending_review', 'actioned', 'dismissed');

-- CreateEnum
CREATE TYPE "MessagePolicyAction" AS ENUM ('blocked', 'warned', 'logged');

-- CreateEnum
CREATE TYPE "NotificationChannel" AS ENUM ('sms', 'whatsapp', 'push', 'in_app');

-- CreateEnum
CREATE TYPE "NotificationStatus" AS ENUM ('queued', 'sent', 'failed', 'delivered');

-- CreateTable
CREATE TABLE "users" (
    "id" TEXT NOT NULL,
    "firebase_uid" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "role" "UserRole" NOT NULL,
    "full_name" TEXT NOT NULL,
    "language_preference" TEXT NOT NULL DEFAULT 'en',
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "mfa_enabled" BOOLEAN NOT NULL DEFAULT false,
    "last_login" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "patients" (
    "id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "full_name" TEXT NOT NULL,
    "age" INTEGER NOT NULL,
    "gender" TEXT NOT NULL,
    "dob" TIMESTAMP(3),
    "city" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "lga" TEXT NOT NULL,
    "address" TEXT,
    "lat" DOUBLE PRECISION,
    "lng" DOUBLE PRECISION,
    "conditions" "ConditionType"[],
    "emergency_contact_name" TEXT NOT NULL,
    "emergency_contact_phone" TEXT NOT NULL,
    "emergency_relationship" TEXT NOT NULL,
    "subscription_plan" "SubscriptionPlan",
    "subscription_status" "SubscriptionStatus" NOT NULL DEFAULT 'trial',
    "subscription_expires_at" TIMESTAMP(3),
    "assigned_chw_id" TEXT,
    "assigned_pharmacy_id" TEXT,
    "assigned_clinician_id" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "patients_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "caregivers_patients" (
    "id" TEXT NOT NULL,
    "caregiver_user_id" TEXT NOT NULL,
    "patient_id" TEXT NOT NULL,
    "consent_status" "ConsentStatus" NOT NULL DEFAULT 'pending',
    "consent_granted_at" TIMESTAMP(3),
    "consent_revoked_at" TIMESTAMP(3),
    "relationship" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "caregivers_patients_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "authorized_helpers" (
    "id" TEXT NOT NULL,
    "patient_id" TEXT NOT NULL,
    "helper_name" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "relationship" TEXT NOT NULL,
    "consent_status" "ConsentStatus" NOT NULL DEFAULT 'pending',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "authorized_helpers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "consent_records" (
    "id" TEXT NOT NULL,
    "patient_id" TEXT NOT NULL,
    "granted_to_user_id" TEXT NOT NULL,
    "consent_type" "ConsentType" NOT NULL,
    "version" TEXT NOT NULL,
    "status" "ConsentRecordStatus" NOT NULL DEFAULT 'active',
    "granted_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "revoked_at" TIMESTAMP(3),
    "ip_address" TEXT,

    CONSTRAINT "consent_records_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "vitals" (
    "id" TEXT NOT NULL,
    "patient_id" TEXT NOT NULL,
    "systolic_bp" INTEGER,
    "diastolic_bp" INTEGER,
    "pulse" INTEGER,
    "glucose_fasting" DOUBLE PRECISION,
    "glucose_random" DOUBLE PRECISION,
    "weight_kg" DOUBLE PRECISION,
    "symptoms" TEXT[],
    "medication_taken" BOOLEAN NOT NULL DEFAULT false,
    "notes" TEXT,
    "risk_status" "RiskStatus" NOT NULL,
    "source_type" "VitalSourceType" NOT NULL,
    "captured_by_user_id" TEXT NOT NULL,
    "capture_location_type" "CaptureLocationType" NOT NULL,
    "patient_consented" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "vitals_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "alerts" (
    "id" TEXT NOT NULL,
    "patient_id" TEXT NOT NULL,
    "vital_id" TEXT,
    "alert_type" "AlertType" NOT NULL,
    "severity" "AlertSeverity" NOT NULL,
    "status" "AlertStatus" NOT NULL DEFAULT 'open',
    "assigned_to_role" "UserRole",
    "assigned_to_user_id" TEXT,
    "message" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "resolved_at" TIMESTAMP(3),
    "resolved_by_id" TEXT,

    CONSTRAINT "alerts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "clinical_safety_rules" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL DEFAULT 'default',
    "systolic_green_max" INTEGER NOT NULL DEFAULT 139,
    "diastolic_green_max" INTEGER NOT NULL DEFAULT 89,
    "fasting_glucose_green_max" DOUBLE PRECISION NOT NULL DEFAULT 125.9,
    "random_glucose_green_max" DOUBLE PRECISION NOT NULL DEFAULT 199.9,
    "systolic_yellow_max" INTEGER NOT NULL DEFAULT 179,
    "diastolic_yellow_max" INTEGER NOT NULL DEFAULT 119,
    "fasting_glucose_yellow_max" DOUBLE PRECISION NOT NULL DEFAULT 250,
    "random_glucose_yellow_max" DOUBLE PRECISION NOT NULL DEFAULT 299.9,
    "auto_red_symptoms" TEXT[] DEFAULT ARRAY['chest_pain']::TEXT[],
    "missed_reading_days" INTEGER NOT NULL DEFAULT 3,
    "missed_medication_days" INTEGER NOT NULL DEFAULT 2,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "effective_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "clinical_safety_rules_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "medications" (
    "id" TEXT NOT NULL,
    "patient_id" TEXT NOT NULL,
    "drug_name" TEXT NOT NULL,
    "dosage" TEXT NOT NULL,
    "frequency" TEXT NOT NULL,
    "times_per_day" INTEGER NOT NULL,
    "start_date" TIMESTAMP(3) NOT NULL,
    "end_date" TIMESTAMP(3),
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "medication_type" "MedicationType" NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "medications_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "prescriptions" (
    "id" TEXT NOT NULL,
    "patient_id" TEXT NOT NULL,
    "clinician_id" TEXT NOT NULL,
    "medication_name" TEXT NOT NULL,
    "medication_type" "MedicationType" NOT NULL,
    "dosage" TEXT NOT NULL,
    "frequency" TEXT NOT NULL,
    "refill_count_remaining" INTEGER NOT NULL,
    "expires_at" TIMESTAMP(3) NOT NULL,
    "status" "PrescriptionStatus" NOT NULL DEFAULT 'active',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "prescriptions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "clinical_notes" (
    "id" TEXT NOT NULL,
    "patient_id" TEXT NOT NULL,
    "clinician_id" TEXT NOT NULL,
    "note" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "clinical_notes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "providers" (
    "id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "provider_type" "ProviderType" NOT NULL,
    "display_name" TEXT NOT NULL,
    "bio" TEXT,
    "city" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "lga" TEXT NOT NULL,
    "lat" DOUBLE PRECISION,
    "lng" DOUBLE PRECISION,
    "coverage_radius_km" DOUBLE PRECISION,
    "languages" TEXT[],
    "verification_status" "VerificationStatus" NOT NULL DEFAULT 'pending',
    "rating" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "completion_rate" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "response_time_avg_minutes" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "providers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "provider_verification_docs" (
    "id" TEXT NOT NULL,
    "provider_id" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "uploaded_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "provider_verification_docs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "provider_services" (
    "id" TEXT NOT NULL,
    "provider_id" TEXT NOT NULL,
    "service_type" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "price_naira" INTEGER NOT NULL,
    "duration_minutes" INTEGER NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "admin_approved" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "provider_services_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "provider_price_caps" (
    "id" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "service_type" TEXT NOT NULL,
    "max_price_naira" INTEGER NOT NULL,
    "effective_date" TIMESTAMP(3) NOT NULL,
    "created_by_id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "provider_price_caps_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "provider_distance_rules" (
    "id" TEXT NOT NULL,
    "cap_id" TEXT NOT NULL,
    "max_km" DOUBLE PRECISION NOT NULL,
    "extra_fee" INTEGER NOT NULL,

    CONSTRAINT "provider_distance_rules_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "service_jobs" (
    "id" TEXT NOT NULL,
    "patient_id" TEXT NOT NULL,
    "caregiver_id" TEXT,
    "provider_id" TEXT NOT NULL,
    "provider_service_id" TEXT NOT NULL,
    "service_type" TEXT NOT NULL,
    "scheduled_at" TIMESTAMP(3) NOT NULL,
    "status" "ServiceJobStatus" NOT NULL DEFAULT 'booked',
    "price_naira" INTEGER NOT NULL,
    "vitalink_commission" INTEGER NOT NULL,
    "provider_payout" INTEGER NOT NULL,
    "escrow_status" "EscrowStatus" NOT NULL DEFAULT 'initialized',
    "payment_reference" TEXT,
    "completion_otp" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "service_jobs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "escrow_transitions" (
    "id" TEXT NOT NULL,
    "job_id" TEXT NOT NULL,
    "from_status" "EscrowStatus",
    "to_status" "EscrowStatus" NOT NULL,
    "actor_id" TEXT NOT NULL,
    "reason" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "escrow_transitions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "service_completion_proofs" (
    "id" TEXT NOT NULL,
    "job_id" TEXT NOT NULL,
    "provider_id" TEXT NOT NULL,
    "otp_confirmed" BOOLEAN NOT NULL DEFAULT false,
    "completion_note" TEXT NOT NULL,
    "attachment_url" TEXT,
    "geo_lat" DOUBLE PRECISION,
    "geo_lng" DOUBLE PRECISION,
    "vitals_captured" BOOLEAN NOT NULL DEFAULT false,
    "completed_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "service_completion_proofs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "provider_wallets" (
    "id" TEXT NOT NULL,
    "provider_id" TEXT NOT NULL,
    "pending_balance" INTEGER NOT NULL DEFAULT 0,
    "available_balance" INTEGER NOT NULL DEFAULT 0,
    "lifetime_earned" INTEGER NOT NULL DEFAULT 0,
    "last_updated" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "provider_wallets_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "payouts" (
    "id" TEXT NOT NULL,
    "provider_id" TEXT NOT NULL,
    "amount" INTEGER NOT NULL,
    "status" "PayoutStatus" NOT NULL DEFAULT 'pending',
    "bank_reference" TEXT,
    "bank_code" TEXT NOT NULL,
    "account_number" TEXT NOT NULL,
    "account_name" TEXT NOT NULL,
    "payout_date" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "payouts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "payments" (
    "id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "patient_id" TEXT,
    "job_id" TEXT,
    "type" "PaymentType" NOT NULL,
    "amount_naira" INTEGER NOT NULL,
    "amount_kobo" BIGINT NOT NULL,
    "currency" TEXT NOT NULL DEFAULT 'NGN',
    "status" "PaymentStatus" NOT NULL DEFAULT 'pending',
    "paystack_reference" TEXT NOT NULL,
    "paystack_response" JSONB,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "payments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "subscriptions" (
    "id" TEXT NOT NULL,
    "patient_id" TEXT NOT NULL,
    "payer_user_id" TEXT NOT NULL,
    "plan" "SubscriptionPlan" NOT NULL,
    "price_naira" INTEGER NOT NULL,
    "billing_cycle" TEXT NOT NULL DEFAULT 'monthly',
    "status" "SubscriptionStatus" NOT NULL DEFAULT 'trial',
    "started_at" TIMESTAMP(3) NOT NULL,
    "expires_at" TIMESTAMP(3) NOT NULL,
    "paystack_subscription_code" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "subscriptions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "disputes" (
    "id" TEXT NOT NULL,
    "job_id" TEXT NOT NULL,
    "raised_by_user_id" TEXT NOT NULL,
    "reason" TEXT NOT NULL,
    "evidence_urls" TEXT[],
    "status" "DisputeStatus" NOT NULL DEFAULT 'open',
    "admin_notes" TEXT,
    "resolved_by_id" TEXT,
    "resolved_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "disputes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pharmacy_refills" (
    "id" TEXT NOT NULL,
    "patient_id" TEXT NOT NULL,
    "prescription_id" TEXT NOT NULL,
    "pharmacy_id" TEXT NOT NULL,
    "medication_name" TEXT NOT NULL,
    "status" "PharmacyRefillStatus" NOT NULL DEFAULT 'requested',
    "pickup_otp" TEXT,
    "identity_verified" BOOLEAN NOT NULL DEFAULT false,
    "requested_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "fulfilled_at" TIMESTAMP(3),

    CONSTRAINT "pharmacy_refills_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pharmacy_pickups" (
    "id" TEXT NOT NULL,
    "refill_id" TEXT NOT NULL,
    "pickup_otp" TEXT NOT NULL,
    "identity_verified" BOOLEAN NOT NULL DEFAULT false,
    "fulfilled_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "pharmacy_pickups_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "chw_visits" (
    "id" TEXT NOT NULL,
    "patient_id" TEXT NOT NULL,
    "chw_id" TEXT NOT NULL,
    "job_id" TEXT,
    "visit_type" "CHWVisitType" NOT NULL,
    "visit_date" TIMESTAMP(3) NOT NULL,
    "vitals_captured" BOOLEAN NOT NULL DEFAULT false,
    "vital_id" TEXT,
    "notes" TEXT NOT NULL,
    "escalated" BOOLEAN NOT NULL DEFAULT false,
    "escalation_reason" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "chw_visits_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "lab_orders" (
    "id" TEXT NOT NULL,
    "patient_id" TEXT NOT NULL,
    "clinician_id" TEXT NOT NULL,
    "lab_id" TEXT NOT NULL,
    "test_types" TEXT[],
    "status" "LabOrderStatus" NOT NULL DEFAULT 'ordered',
    "scheduled_at" TIMESTAMP(3),
    "result_url" TEXT,
    "result_notes" TEXT,
    "is_abnormal" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "lab_orders_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "notifications" (
    "id" TEXT NOT NULL,
    "recipient_user_id" TEXT NOT NULL,
    "patient_id" TEXT,
    "channel" "NotificationChannel" NOT NULL,
    "type" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "body" TEXT NOT NULL,
    "status" "NotificationStatus" NOT NULL DEFAULT 'queued',
    "sent_at" TIMESTAMP(3),
    "read_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "notifications_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "audit_logs" (
    "id" TEXT NOT NULL,
    "actor_user_id" TEXT NOT NULL,
    "patient_id" TEXT,
    "action" TEXT NOT NULL,
    "resource_type" TEXT NOT NULL,
    "resource_id" TEXT NOT NULL,
    "old_value" JSONB,
    "new_value" JSONB,
    "ip_address" TEXT NOT NULL,
    "user_agent" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "audit_logs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "message_policy_events" (
    "id" TEXT NOT NULL,
    "sender_id" TEXT NOT NULL,
    "receiver_id" TEXT NOT NULL,
    "job_id" TEXT,
    "pattern_detected" TEXT NOT NULL,
    "message_snippet_hash" TEXT NOT NULL,
    "action_taken" "MessagePolicyAction" NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "message_policy_events_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "provider_policy_violations" (
    "id" TEXT NOT NULL,
    "provider_id" TEXT NOT NULL,
    "violation_type" "PolicyViolationType" NOT NULL,
    "evidence" TEXT NOT NULL,
    "admin_notes" TEXT,
    "status" "PolicyViolationStatus" NOT NULL DEFAULT 'pending_review',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "provider_policy_violations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "feature_flags" (
    "id" TEXT NOT NULL,
    "flag_name" TEXT NOT NULL,
    "is_enabled" BOOLEAN NOT NULL DEFAULT false,
    "description" TEXT NOT NULL,
    "updated_by_id" TEXT NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "feature_flags_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "in_app_messages" (
    "id" TEXT NOT NULL,
    "job_id" TEXT NOT NULL,
    "sender_id" TEXT NOT NULL,
    "receiver_id" TEXT NOT NULL,
    "body" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "in_app_messages_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_firebase_uid_key" ON "users"("firebase_uid");

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE INDEX "users_role_idx" ON "users"("role");

-- CreateIndex
CREATE UNIQUE INDEX "patients_user_id_key" ON "patients"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "caregivers_patients_caregiver_user_id_patient_id_key" ON "caregivers_patients"("caregiver_user_id", "patient_id");

-- CreateIndex
CREATE INDEX "authorized_helpers_patient_id_phone_idx" ON "authorized_helpers"("patient_id", "phone");

-- CreateIndex
CREATE INDEX "vitals_patient_id_created_at_idx" ON "vitals"("patient_id", "created_at" DESC);

-- CreateIndex
CREATE INDEX "alerts_status_severity_idx" ON "alerts"("status", "severity");

-- CreateIndex
CREATE INDEX "alerts_patient_id_created_at_idx" ON "alerts"("patient_id", "created_at" DESC);

-- CreateIndex
CREATE UNIQUE INDEX "providers_user_id_key" ON "providers"("user_id");

-- CreateIndex
CREATE INDEX "providers_provider_type_city_idx" ON "providers"("provider_type", "city");

-- CreateIndex
CREATE INDEX "provider_price_caps_city_state_service_type_idx" ON "provider_price_caps"("city", "state", "service_type");

-- CreateIndex
CREATE INDEX "service_jobs_provider_id_status_idx" ON "service_jobs"("provider_id", "status");

-- CreateIndex
CREATE INDEX "service_jobs_patient_id_idx" ON "service_jobs"("patient_id");

-- CreateIndex
CREATE INDEX "escrow_transitions_job_id_created_at_idx" ON "escrow_transitions"("job_id", "created_at" DESC);

-- CreateIndex
CREATE UNIQUE INDEX "service_completion_proofs_job_id_key" ON "service_completion_proofs"("job_id");

-- CreateIndex
CREATE UNIQUE INDEX "provider_wallets_provider_id_key" ON "provider_wallets"("provider_id");

-- CreateIndex
CREATE UNIQUE INDEX "payments_paystack_reference_key" ON "payments"("paystack_reference");

-- CreateIndex
CREATE INDEX "notifications_recipient_user_id_created_at_idx" ON "notifications"("recipient_user_id", "created_at" DESC);

-- CreateIndex
CREATE INDEX "audit_logs_created_at_idx" ON "audit_logs"("created_at" DESC);

-- CreateIndex
CREATE INDEX "audit_logs_patient_id_created_at_idx" ON "audit_logs"("patient_id", "created_at" DESC);

-- CreateIndex
CREATE UNIQUE INDEX "feature_flags_flag_name_key" ON "feature_flags"("flag_name");

-- CreateIndex
CREATE INDEX "in_app_messages_job_id_created_at_idx" ON "in_app_messages"("job_id", "created_at" DESC);

-- AddForeignKey
ALTER TABLE "patients" ADD CONSTRAINT "patients_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "patients" ADD CONSTRAINT "patients_assigned_chw_id_fkey" FOREIGN KEY ("assigned_chw_id") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "patients" ADD CONSTRAINT "patients_assigned_pharmacy_id_fkey" FOREIGN KEY ("assigned_pharmacy_id") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "patients" ADD CONSTRAINT "patients_assigned_clinician_id_fkey" FOREIGN KEY ("assigned_clinician_id") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "caregivers_patients" ADD CONSTRAINT "caregivers_patients_caregiver_user_id_fkey" FOREIGN KEY ("caregiver_user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "caregivers_patients" ADD CONSTRAINT "caregivers_patients_patient_id_fkey" FOREIGN KEY ("patient_id") REFERENCES "patients"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "authorized_helpers" ADD CONSTRAINT "authorized_helpers_patient_id_fkey" FOREIGN KEY ("patient_id") REFERENCES "patients"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "consent_records" ADD CONSTRAINT "consent_records_patient_id_fkey" FOREIGN KEY ("patient_id") REFERENCES "patients"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "consent_records" ADD CONSTRAINT "consent_records_granted_to_user_id_fkey" FOREIGN KEY ("granted_to_user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "vitals" ADD CONSTRAINT "vitals_patient_id_fkey" FOREIGN KEY ("patient_id") REFERENCES "patients"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "vitals" ADD CONSTRAINT "vitals_captured_by_user_id_fkey" FOREIGN KEY ("captured_by_user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "alerts" ADD CONSTRAINT "alerts_patient_id_fkey" FOREIGN KEY ("patient_id") REFERENCES "patients"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "alerts" ADD CONSTRAINT "alerts_vital_id_fkey" FOREIGN KEY ("vital_id") REFERENCES "vitals"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "alerts" ADD CONSTRAINT "alerts_assigned_to_user_id_fkey" FOREIGN KEY ("assigned_to_user_id") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "alerts" ADD CONSTRAINT "alerts_resolved_by_id_fkey" FOREIGN KEY ("resolved_by_id") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "medications" ADD CONSTRAINT "medications_patient_id_fkey" FOREIGN KEY ("patient_id") REFERENCES "patients"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "prescriptions" ADD CONSTRAINT "prescriptions_patient_id_fkey" FOREIGN KEY ("patient_id") REFERENCES "patients"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "prescriptions" ADD CONSTRAINT "prescriptions_clinician_id_fkey" FOREIGN KEY ("clinician_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "clinical_notes" ADD CONSTRAINT "clinical_notes_patient_id_fkey" FOREIGN KEY ("patient_id") REFERENCES "patients"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "clinical_notes" ADD CONSTRAINT "clinical_notes_clinician_id_fkey" FOREIGN KEY ("clinician_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "providers" ADD CONSTRAINT "providers_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "provider_verification_docs" ADD CONSTRAINT "provider_verification_docs_provider_id_fkey" FOREIGN KEY ("provider_id") REFERENCES "providers"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "provider_services" ADD CONSTRAINT "provider_services_provider_id_fkey" FOREIGN KEY ("provider_id") REFERENCES "providers"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "provider_price_caps" ADD CONSTRAINT "provider_price_caps_created_by_id_fkey" FOREIGN KEY ("created_by_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "provider_distance_rules" ADD CONSTRAINT "provider_distance_rules_cap_id_fkey" FOREIGN KEY ("cap_id") REFERENCES "provider_price_caps"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "service_jobs" ADD CONSTRAINT "service_jobs_patient_id_fkey" FOREIGN KEY ("patient_id") REFERENCES "patients"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "service_jobs" ADD CONSTRAINT "service_jobs_caregiver_id_fkey" FOREIGN KEY ("caregiver_id") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "service_jobs" ADD CONSTRAINT "service_jobs_provider_id_fkey" FOREIGN KEY ("provider_id") REFERENCES "providers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "service_jobs" ADD CONSTRAINT "service_jobs_provider_service_id_fkey" FOREIGN KEY ("provider_service_id") REFERENCES "provider_services"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "escrow_transitions" ADD CONSTRAINT "escrow_transitions_job_id_fkey" FOREIGN KEY ("job_id") REFERENCES "service_jobs"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "escrow_transitions" ADD CONSTRAINT "escrow_transitions_actor_id_fkey" FOREIGN KEY ("actor_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "service_completion_proofs" ADD CONSTRAINT "service_completion_proofs_job_id_fkey" FOREIGN KEY ("job_id") REFERENCES "service_jobs"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "service_completion_proofs" ADD CONSTRAINT "service_completion_proofs_provider_id_fkey" FOREIGN KEY ("provider_id") REFERENCES "providers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "provider_wallets" ADD CONSTRAINT "provider_wallets_provider_id_fkey" FOREIGN KEY ("provider_id") REFERENCES "providers"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "payouts" ADD CONSTRAINT "payouts_provider_id_fkey" FOREIGN KEY ("provider_id") REFERENCES "providers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "payments" ADD CONSTRAINT "payments_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "payments" ADD CONSTRAINT "payments_patient_id_fkey" FOREIGN KEY ("patient_id") REFERENCES "patients"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "payments" ADD CONSTRAINT "payments_job_id_fkey" FOREIGN KEY ("job_id") REFERENCES "service_jobs"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "subscriptions" ADD CONSTRAINT "subscriptions_patient_id_fkey" FOREIGN KEY ("patient_id") REFERENCES "patients"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "subscriptions" ADD CONSTRAINT "subscriptions_payer_user_id_fkey" FOREIGN KEY ("payer_user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "disputes" ADD CONSTRAINT "disputes_job_id_fkey" FOREIGN KEY ("job_id") REFERENCES "service_jobs"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "disputes" ADD CONSTRAINT "disputes_raised_by_user_id_fkey" FOREIGN KEY ("raised_by_user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "disputes" ADD CONSTRAINT "disputes_resolved_by_id_fkey" FOREIGN KEY ("resolved_by_id") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pharmacy_refills" ADD CONSTRAINT "pharmacy_refills_patient_id_fkey" FOREIGN KEY ("patient_id") REFERENCES "patients"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pharmacy_refills" ADD CONSTRAINT "pharmacy_refills_prescription_id_fkey" FOREIGN KEY ("prescription_id") REFERENCES "prescriptions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pharmacy_refills" ADD CONSTRAINT "pharmacy_refills_pharmacy_id_fkey" FOREIGN KEY ("pharmacy_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pharmacy_pickups" ADD CONSTRAINT "pharmacy_pickups_refill_id_fkey" FOREIGN KEY ("refill_id") REFERENCES "pharmacy_refills"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "chw_visits" ADD CONSTRAINT "chw_visits_patient_id_fkey" FOREIGN KEY ("patient_id") REFERENCES "patients"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "chw_visits" ADD CONSTRAINT "chw_visits_job_id_fkey" FOREIGN KEY ("job_id") REFERENCES "service_jobs"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "chw_visits" ADD CONSTRAINT "chw_visits_vital_id_fkey" FOREIGN KEY ("vital_id") REFERENCES "vitals"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "lab_orders" ADD CONSTRAINT "lab_orders_patient_id_fkey" FOREIGN KEY ("patient_id") REFERENCES "patients"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "lab_orders" ADD CONSTRAINT "lab_orders_clinician_id_fkey" FOREIGN KEY ("clinician_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "lab_orders" ADD CONSTRAINT "lab_orders_lab_id_fkey" FOREIGN KEY ("lab_id") REFERENCES "providers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "notifications" ADD CONSTRAINT "notifications_recipient_user_id_fkey" FOREIGN KEY ("recipient_user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "audit_logs" ADD CONSTRAINT "audit_logs_actor_user_id_fkey" FOREIGN KEY ("actor_user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "audit_logs" ADD CONSTRAINT "audit_logs_patient_id_fkey" FOREIGN KEY ("patient_id") REFERENCES "patients"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "message_policy_events" ADD CONSTRAINT "message_policy_events_sender_id_fkey" FOREIGN KEY ("sender_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "message_policy_events" ADD CONSTRAINT "message_policy_events_receiver_id_fkey" FOREIGN KEY ("receiver_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "message_policy_events" ADD CONSTRAINT "message_policy_events_job_id_fkey" FOREIGN KEY ("job_id") REFERENCES "service_jobs"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "provider_policy_violations" ADD CONSTRAINT "provider_policy_violations_provider_id_fkey" FOREIGN KEY ("provider_id") REFERENCES "providers"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "feature_flags" ADD CONSTRAINT "feature_flags_updated_by_id_fkey" FOREIGN KEY ("updated_by_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "in_app_messages" ADD CONSTRAINT "in_app_messages_job_id_fkey" FOREIGN KEY ("job_id") REFERENCES "service_jobs"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "in_app_messages" ADD CONSTRAINT "in_app_messages_sender_id_fkey" FOREIGN KEY ("sender_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "in_app_messages" ADD CONSTRAINT "in_app_messages_receiver_id_fkey" FOREIGN KEY ("receiver_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
