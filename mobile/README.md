# Myndora Care — Mobile

Flutter app for patients, caregivers, and community health workers. Offline-first vitals with Isar local storage and background sync to the Go API.

## Setup

```bash
cd mobile
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

Add `google-services.json` (Android) and `GoogleService-Info.plist` (iOS), then configure Firebase in your project.

Set API base URL via `--dart-define=API_BASE_URL=http://10.0.2.2:8080/api/v1` (Android emulator) or your host.

## Run

```bash
flutter run --dart-define=API_BASE_URL=http://localhost:8080/api/v1
```

Replace logo assets under `assets/images/` with production artwork when available.
