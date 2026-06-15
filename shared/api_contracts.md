# Myndora Care API Contracts

Base URL: `/api/v1`

## Roles
`patient` | `caregiver` | `home_helper` | `chw` | `pharmacy` | `clinician` | `lab` | `admin` | `super_admin`

## Risk Status
`green` | `yellow` | `red`

## Escrow Status
`initialized` | `paid_held` | `accepted` | `completed_pending_confirmation` | `released` | `disputed` | `refunded`

## Auth

### POST /auth/verify-token
Request: `{ "id_token": "firebase-jwt" }`
Response: `{ "user": UserProfile, "role": "patient" }`

### POST /auth/complete-profile
Request: `{ "role": "patient", "full_name": "...", "phone": "...", ... }`

## Vitals

### POST /vitals
```json
{
  "patient_id": "optional-for-self",
  "systolic_bp": 120,
  "diastolic_bp": 80,
  "glucose_fasting": 95,
  "glucose_random": null,
  "pulse": 72,
  "weight_kg": 70,
  "symptoms": ["headache"],
  "medication_taken": true,
  "notes": "",
  "source_type": "patient_self",
  "capture_location_type": "home"
}
```

Response includes `risk_status` and optional `alert_id`.

### GET /vitals/patient/:id/trend?days=7|30|90

## Care service layers

`platform_subscription` | `chw_remote_check` | `physical_chw_visit`

### GET /subscriptions/patient/:patientId
Returns patient subscription plan, status, and expiry.

### POST /remote-checks
Same body as `POST /vitals`; delegates with `source_type: patient_self` and returns `service_layer: chw_remote_check`.

### POST /chw-visits
Vitals body plus optional `visit_type` and `notes`; creates linked `CHWVisit` row and returns `service_layer: physical_chw_visit`.

## Service Jobs

### POST /jobs/book
```json
{
  "patient_id": "...",
  "provider_id": "...",
  "service_id": "...",
  "scheduled_at": "2026-05-20T10:00:00Z"
}
```

### POST /jobs/:id/confirm
```json
{ "otp": "123456" }
```

## Payments

### POST /payments/initialize
```json
{ "amount_naira": 5000, "type": "subscription|service", "patient_id": "...", "job_id": "..." }
```

Response: `{ "authorization_url": "...", "reference": "..." }`
