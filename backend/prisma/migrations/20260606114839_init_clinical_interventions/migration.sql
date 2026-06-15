-- CreateEnum
CREATE TYPE "InterventionStatus" AS ENUM ('draft', 'pending_clinician_review', 'active', 'completed', 'cancelled');

-- CreateEnum
CREATE TYPE "RiskTier" AS ENUM ('low', 'moderate', 'high', 'critical');

-- CreateTable
CREATE TABLE "interventions" (
    "id" TEXT NOT NULL,
    "patient_id" TEXT NOT NULL,
    "alert_id" TEXT,
    "vital_id" TEXT,
    "initiated_by_user_id" TEXT NOT NULL,
    "status" "InterventionStatus" NOT NULL DEFAULT 'pending_clinician_review',
    "risk_tier" "RiskTier" NOT NULL,
    "path" TEXT NOT NULL DEFAULT 'A',
    "title" TEXT NOT NULL,
    "summary" TEXT NOT NULL,
    "checklist" JSONB NOT NULL,
    "checklist_metrics" JSONB NOT NULL,
    "ai_model_version" TEXT,
    "completed_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "interventions_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "interventions_patient_id_created_at_idx" ON "interventions"("patient_id", "created_at" DESC);

-- CreateIndex
CREATE INDEX "interventions_status_risk_tier_idx" ON "interventions"("status", "risk_tier");

-- AddForeignKey
ALTER TABLE "interventions" ADD CONSTRAINT "interventions_patient_id_fkey" FOREIGN KEY ("patient_id") REFERENCES "patients"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "interventions" ADD CONSTRAINT "interventions_alert_id_fkey" FOREIGN KEY ("alert_id") REFERENCES "alerts"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "interventions" ADD CONSTRAINT "interventions_vital_id_fkey" FOREIGN KEY ("vital_id") REFERENCES "vitals"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "interventions" ADD CONSTRAINT "interventions_initiated_by_user_id_fkey" FOREIGN KEY ("initiated_by_user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
