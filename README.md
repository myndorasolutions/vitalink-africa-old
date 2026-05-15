# VitaLink Africa

Nigeria-first chronic care coordination platform for hypertension and diabetes management.

## Architecture

```
┌─────────────┐     ┌─────────────┐
│ Flutter App │     │  React Web  │
│  (mobile/)  │     │   (web/)    │
└──────┬──────┘     └──────┬──────┘
       │    Firebase JWT    │
       └─────────┬──────────┘
                 ▼
       ┌─────────────────────┐
       │  Golang REST API    │
       │    (backend/)       │
       └─────────┬───────────┘
                 │
       ┌─────────┴─────────┐
       ▼                   ▼
  MongoDB 7            Redis 7
  (primary DB)      (cache/pubsub)
```

## Quick Start

### Prerequisites
- Docker & Docker Compose
- Go 1.22+
- Node.js 20+
- Flutter 3.x (for mobile)
- Firebase project with Email/Password auth enabled

### 1. Environment
```bash
cp .env.example .env
# Place firebase-service-account.json in backend/
```

### 2. Start infrastructure
```bash
docker-compose up -d mongodb redis mongo-init
```

### 3. Backend
```bash
cd backend
go mod download
go run cmd/server/main.go
```

### 4. Seed demo data
```bash
go run cmd/seed/main.go
```

### 5. Web
```bash
cd web
npm install
npm run dev
```

### 6. Mobile
```bash
cd mobile
flutter pub get
dart run build_runner build
flutter run
```

## Demo Credentials

Password for all accounts: `DemoPass123!`

| Role | Email |
|------|-------|
| Patient (Yellow) | grace.patient@vitalink.demo |
| Patient (Green) | musa.patient@vitalink.demo |
| Patient (Red) | esther.patient@vitalink.demo |
| Caregiver | tunde.caregiver@vitalink.demo |
| CHW | amina.chw@vitalink.demo |
| Pharmacy | pharmacy@vitalink.demo |
| Clinician | doctor@vitalink.demo |
| Lab | lab@vitalink.demo |
| Admin | admin@vitalink.demo |
| Super Admin | superadmin@vitalink.demo |

## API

Base URL: `http://localhost:8080/api/v1`

Health: `GET /health`

## Mock Integrations

Set in `.env` for local development without external API keys:
- `MOCK_PAYSTACK=true`
- `MOCK_AT=true`
- `MOCK_GCS=true`

Swap to live by setting mocks to `false` and providing real credentials.

---
Powered by Myndora Solutions
