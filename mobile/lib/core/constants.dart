class AppConstants {
  static const apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:8080/api/v1',
  );

  static const prefsOnboardingComplete = 'onboarding_complete';
  static const prefsLanguage = 'language';
  static const prefsRole = 'role';
  static const prefsUserName = 'user_name';
  static const prefsPatientId = 'patient_id';
  static const prefsPlan = 'subscription_plan';
}
