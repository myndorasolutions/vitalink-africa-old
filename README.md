# Myndora Care

Nigeria-first chronic care coordination platform for hypertension and diabetes management. A core product under **Myndora Solutions**.

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

### 5. Web & API (monorepo)
```bash
npm install
npm run dev:backend   # NestJS API on :8080 (uses backend/dist)
npm run dev:web       # Vite dashboard on :5173
```

Or from package folders:
```bash
cd web && npm install && npm run dev
```

### 6. Mobile
```bash
cd mobile
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter analyze
flutter run --dart-define=INTEGRATION_FLOW=true --dart-define=API_BASE_URL=http://10.0.2.2:8080/api/v1
```

Closed-test bundle (requires working Gradle/Java trust store):
```bash
flutter build appbundle --dart-define=INTEGRATION_FLOW=true --dart-define=API_BASE_URL=http://YOUR_LAN_IP:8080/api/v1
```

## Demo Credentials

Password for all accounts: `DemoPass123!`

| Role | Email |
|------|-------|
| Patient (Yellow) | grace.patient@myndora.demo |
| Patient (Green) | musa.patient@myndora.demo |
| Patient (Red) | esther.patient@myndora.demo |
| Caregiver | tunde.caregiver@myndora.demo |
| CHW | amina.chw@myndora.demo |
| Pharmacy | pharmacy@myndora.demo |
| Clinician | doctor@myndora.demo |
| Lab | lab@myndora.demo |
| Admin | admin@myndora.demo |
| Super Admin | superadmin@myndora.demo |

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
