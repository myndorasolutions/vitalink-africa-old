export enum UserRole {
  Patient = "patient",
  Caregiver = "caregiver",
  HomeHelper = "home_helper",
  CHW = "chw",
  Pharmacy = "pharmacy",
  Clinician = "clinician",
  Lab = "lab",
  Admin = "admin",
  SuperAdmin = "super_admin",
}

export enum RiskStatus {
  Green = "green",
  Yellow = "yellow",
  Red = "red",
}

export enum EscrowStatus {
  Initialized = "initialized",
  PaidHeld = "paid_held",
  Accepted = "accepted",
  CompletedPendingConfirmation = "completed_pending_confirmation",
  Released = "released",
  Disputed = "disputed",
  Refunded = "refunded",
}

export enum VitalSourceType {
  PatientSelf = "patient_self",
  CaregiverEntry = "caregiver_entry",
  HomeHelperEntry = "home_helper_entry",
  CHWVisit = "chw_visit",
  PharmacyWalkIn = "pharmacy_walk_in",
  CommunityScreening = "community_screening",
}

export enum CaptureLocationType {
  Home = "home",
  Pharmacy = "pharmacy",
  CommunityEvent = "community_event",
  Clinic = "clinic",
  Unknown = "unknown",
}

export enum AlertType {
  HighBp = "high_bp",
  HighGlucose = "high_glucose",
  MissedReading = "missed_reading",
  MissedMedication = "missed_medication",
  SymptomEscalation = "symptom_escalation",
}

export enum SubscriptionPlan {
  FreeCheck = "free_check",
  BasicMonitor = "basic_monitor",
  FamilyCare = "family_care",
  AssistedCare = "assisted_care",
  PremiumChronic = "premium_chronic",
}

/** Distinct care delivery layers for Myndora Care. */
export enum CareServiceLayer {
  PlatformSubscription = "platform_subscription",
  ChwRemoteCheck = "chw_remote_check",
  PhysicalChwVisit = "physical_chw_visit",
}

export const API_BASE_PATH = "/api/v1";
