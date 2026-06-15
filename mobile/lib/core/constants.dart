class AppConstants {
  static const apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:8080/api/v1',
  );

  static const integrationFlow = bool.fromEnvironment(
    'INTEGRATION_FLOW',
    defaultValue: true,
  );

  static const prefsOnboardingComplete = 'onboarding_complete';
  static const prefsLanguage = 'language';
  static const prefsRole = 'role';
  static const prefsUserName = 'user_name';
  static const prefsPatientId = 'patient_id';
  static const prefsPlan = 'subscription_plan';
  static const prefsMockAuthToken = 'mock_auth_token';
  static const prefsIntegrationPatientId = 'integration_patient_id';
  static const prefsPilotRole = 'integration_pilot_role';

  static const defaultPlaytestPatientId = 'playtest-patient-grace';
  static const defaultPlaytestChwToken =
      'eyJ1aWQiOiJwbGF5dGVzdC1maXJlYmFzZS1jaHctYW1pbmEiLCJlbWFpbCI6ImFtaW5hLmNod0B2aXRhbGluay5kZW1vIiwicm9sZSI6ImNodyJ9';
}
