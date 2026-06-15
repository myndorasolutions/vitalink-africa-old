import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants.dart';
import '../../../providers/app_providers.dart';
import '../models/pilot_role.dart';

class IntegrationAuthState {
  const IntegrationAuthState({
    required this.isAuthenticated,
    this.patientId,
    this.pilotRole,
  });

  final bool isAuthenticated;
  final String? patientId;
  final PilotRole? pilotRole;
}

class IntegrationAuthNotifier extends StateNotifier<IntegrationAuthState> {
  IntegrationAuthNotifier(this._prefs)
      : super(
          IntegrationAuthState(
            isAuthenticated: _isAuthenticated(_prefs),
            patientId: _prefs.getString(AppConstants.prefsIntegrationPatientId),
            pilotRole: PilotRoleX.fromStorage(
              _prefs.getString(AppConstants.prefsPilotRole),
            ),
          ),
        );

  final SharedPreferences _prefs;

  static bool _isAuthenticated(SharedPreferences prefs) {
    final token = prefs.getString(AppConstants.prefsMockAuthToken);
    final patientId = prefs.getString(AppConstants.prefsIntegrationPatientId);
    final role = prefs.getString(AppConstants.prefsPilotRole);
    return token != null &&
        token.isNotEmpty &&
        patientId != null &&
        patientId.isNotEmpty &&
        role != null;
  }

  Future<void> signInAs(PilotRole role) async {
    final token = role == PilotRole.chw
        ? AppConstants.defaultPlaytestChwToken
        : 'mock-jwt-${role.name}';
    const patientId = AppConstants.defaultPlaytestPatientId;

    await _prefs.setString(AppConstants.prefsMockAuthToken, token);
    await _prefs.setString(AppConstants.prefsIntegrationPatientId, patientId);
    await _prefs.setString(AppConstants.prefsPatientId, patientId);
    await _prefs.setString(AppConstants.prefsPilotRole, role.storageKey);
    await _prefs.setString(
      AppConstants.prefsRole,
      role == PilotRole.chw ? 'chw' : role.name,
    );
    await _prefs.setBool(AppConstants.prefsOnboardingComplete, true);

    state = IntegrationAuthState(
      isAuthenticated: true,
      patientId: patientId,
      pilotRole: role,
    );
  }

  Future<void> signIn({
    required String token,
    required String patientId,
  }) async {
    await signInAs(PilotRole.chw);
    await _prefs.setString(AppConstants.prefsMockAuthToken, token.trim());
    await _prefs.setString(
      AppConstants.prefsIntegrationPatientId,
      patientId.trim(),
    );
    state = IntegrationAuthState(
      isAuthenticated: true,
      patientId: patientId.trim(),
      pilotRole: PilotRole.chw,
    );
  }

  Future<void> signOut() async {
    await _prefs.remove(AppConstants.prefsMockAuthToken);
    await _prefs.remove(AppConstants.prefsIntegrationPatientId);
    await _prefs.remove(AppConstants.prefsPilotRole);
    state = const IntegrationAuthState(isAuthenticated: false);
  }
}

final integrationAuthProvider =
    StateNotifierProvider<IntegrationAuthNotifier, IntegrationAuthState>((ref) {
  return IntegrationAuthNotifier(ref.watch(sharedPreferencesProvider));
});

final integrationPatientIdProvider = Provider<String?>((ref) {
  return ref.watch(integrationAuthProvider).patientId;
});

final integrationPilotRoleProvider = Provider<PilotRole?>((ref) {
  return ref.watch(integrationAuthProvider).pilotRole;
});
