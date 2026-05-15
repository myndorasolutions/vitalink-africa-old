export type UserRole =
  | 'patient'
  | 'caregiver'
  | 'home_helper'
  | 'chw'
  | 'pharmacy'
  | 'clinician'
  | 'lab'
  | 'admin'
  | 'super_admin';

export type RiskStatus = 'green' | 'yellow' | 'red';

export interface UserProfile {
  id: string;
  email: string;
  full_name: string;
  role: UserRole;
  phone?: string;
}

export interface VitalReading {
  id: string;
  recorded_at: string;
  systolic_bp: number;
  diastolic_bp: number;
  glucose_fasting?: number;
  pulse: number;
  risk_status: RiskStatus;
}

export interface PatientSummary {
  id: string;
  full_name: string;
  phone: string;
  risk_status: RiskStatus;
  last_vital_at?: string;
  conditions: string[];
}

export interface RefillRequest {
  id: string;
  patient_name: string;
  medication: string;
  status: 'pending' | 'ready' | 'dispensed';
  requested_at: string;
}

export interface ConsultQueueItem {
  id: string;
  patient_name: string;
  reason: string;
  risk_status: RiskStatus;
  wait_minutes: number;
}

export interface LabOrder {
  id: string;
  patient_name: string;
  tests: string[];
  status: 'pending' | 'in_progress' | 'completed';
  ordered_at: string;
}

export interface AdminAlert {
  id: string;
  patient_name: string;
  message: string;
  risk_status: RiskStatus;
  created_at: string;
}

export interface KpiMetric {
  label: string;
  value: string | number;
  change?: string;
  trend?: 'up' | 'down' | 'neutral';
}
