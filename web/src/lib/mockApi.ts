import type {
  AdminAlert,
  ConsultQueueItem,
  KpiMetric,
  LabOrder,
  PatientSummary,
  RefillRequest,
  RiskStatus,
  UserProfile,
  VitalReading,
} from './types';

const delay = (ms = 400) => new Promise((r) => setTimeout(r, ms));

const patients: PatientSummary[] = [
  {
    id: 'p1',
    full_name: 'Grace Okafor',
    phone: '+2348012345678',
    risk_status: 'yellow',
    last_vital_at: '2026-05-14T08:00:00Z',
    conditions: ['Hypertension', 'Type 2 Diabetes'],
  },
  {
    id: 'p2',
    full_name: 'Musa Bello',
    phone: '+2348098765432',
    risk_status: 'green',
    last_vital_at: '2026-05-15T06:30:00Z',
    conditions: ['Hypertension'],
  },
  {
    id: 'p3',
    full_name: 'Esther Adeyemi',
    phone: '+2347011122233',
    risk_status: 'red',
    last_vital_at: '2026-05-15T07:15:00Z',
    conditions: ['Type 2 Diabetes'],
  },
];

function vitalsTrend(patientId: string, days: number): VitalReading[] {
  const base = patientId === 'p3' ? 150 : patientId === 'p1' ? 135 : 118;
  return Array.from({ length: Math.min(days, 14) }, (_, i) => ({
    id: `v-${patientId}-${i}`,
    recorded_at: new Date(Date.now() - i * 86400000).toISOString(),
    systolic_bp: base + Math.round(Math.sin(i) * 8),
    diastolic_bp: 75 + (i % 5),
    glucose_fasting: 95 + i * 2,
    pulse: 68 + (i % 8),
    risk_status: (['green', 'yellow', 'red'] as RiskStatus[])[i % 3],
  })).reverse();
}

export const mockApi = {
  async login(email: string, _password: string): Promise<{ token: string; user: UserProfile }> {
    await delay();
    const roleMap: Record<string, UserProfile['role']> = {
      'pharmacy@vitalink.demo': 'pharmacy',
      'doctor@vitalink.demo': 'clinician',
      'lab@vitalink.demo': 'lab',
      'admin@vitalink.demo': 'admin',
      'superadmin@vitalink.demo': 'super_admin',
      'tunde.caregiver@vitalink.demo': 'caregiver',
      'grace.patient@vitalink.demo': 'patient',
    };
    const role = roleMap[email] ?? 'admin';
    return {
      token: `mock-jwt-${role}`,
      user: {
        id: `u-${role}`,
        email,
        full_name: email.split('@')[0].replace(/\./g, ' '),
        role,
      },
    };
  },

  async getPatients(): Promise<PatientSummary[]> {
    await delay();
    return patients;
  },

  async getVitalsTrend(patientId: string, days = 7): Promise<VitalReading[]> {
    await delay();
    return vitalsTrend(patientId, days);
  },

  async getPharmacyDashboard() {
    await delay();
    return {
      pending_refills: 12,
      walk_ins_today: 8,
      dispensed_today: 24,
      revenue_naira: 185000,
    };
  },

  async getRefillQueue(): Promise<RefillRequest[]> {
    await delay();
    return [
      {
        id: 'r1',
        patient_name: 'Grace Okafor',
        medication: 'Amlodipine 5mg',
        status: 'pending',
        requested_at: '2026-05-15T09:00:00Z',
      },
      {
        id: 'r2',
        patient_name: 'Musa Bello',
        medication: 'Metformin 500mg',
        status: 'ready',
        requested_at: '2026-05-15T08:30:00Z',
      },
    ];
  },

  async getClinicianQueue(): Promise<ConsultQueueItem[]> {
    await delay();
    return [
      {
        id: 'c1',
        patient_name: 'Esther Adeyemi',
        reason: 'Elevated BP follow-up',
        risk_status: 'red',
        wait_minutes: 12,
      },
      {
        id: 'c2',
        patient_name: 'Grace Okafor',
        reason: 'Diabetes review',
        risk_status: 'yellow',
        wait_minutes: 25,
      },
    ];
  },

  async getLabOrders(): Promise<LabOrder[]> {
    await delay();
    return [
      {
        id: 'lo1',
        patient_name: 'Grace Okafor',
        tests: ['HbA1c', 'Lipid panel'],
        status: 'pending',
        ordered_at: '2026-05-15T07:00:00Z',
      },
      {
        id: 'lo2',
        patient_name: 'Musa Bello',
        tests: ['Fasting glucose'],
        status: 'in_progress',
        ordered_at: '2026-05-14T14:00:00Z',
      },
    ];
  },

  async getAdminKpis(): Promise<KpiMetric[]> {
    await delay();
    return [
      { label: 'Active patients', value: 1248, change: '+4.2%', trend: 'up' },
      { label: 'Red alerts (24h)', value: 7, change: '-12%', trend: 'down' },
      { label: 'Escrow held (₦)', value: '2.4M', change: '+8%', trend: 'up' },
      { label: 'Consultations today', value: 34, change: '+2', trend: 'up' },
    ];
  },

  async getAdminAlerts(): Promise<AdminAlert[]> {
    await delay();
    return [
      {
        id: 'a1',
        patient_name: 'Esther Adeyemi',
        message: 'Systolic BP 168 — threshold exceeded',
        risk_status: 'red',
        created_at: new Date().toISOString(),
      },
      {
        id: 'a2',
        patient_name: 'Grace Okafor',
        message: 'Missed medication check-in',
        risk_status: 'yellow',
        created_at: new Date(Date.now() - 300000).toISOString(),
      },
    ];
  },

  async getFeatureFlags() {
    await delay();
    return [
      { key: 'FEATURE_AI_SUMMARIES', enabled: false, description: 'AI consultation summaries' },
      { key: 'FEATURE_PAYSTACK_LIVE', enabled: false, description: 'Live Paystack payments' },
      { key: 'FEATURE_USSD', enabled: true, description: 'USSD vitals capture' },
      { key: 'FEATURE_MARKETPLACE', enabled: true, description: 'Service marketplace' },
    ];
  },

  async getEarnings(role: string) {
    await delay();
    return {
      period: 'May 2026',
      gross_naira: role === 'pharmacy' ? 420000 : 680000,
      commission_naira: role === 'pharmacy' ? 21000 : 136000,
      pending_payout_naira: 45000,
      transactions: [
        { id: 't1', date: '2026-05-14', description: 'Refill dispensed', amount: 8500 },
        { id: 't2', date: '2026-05-13', description: 'Consultation fee', amount: 15000 },
      ],
    };
  },
};
