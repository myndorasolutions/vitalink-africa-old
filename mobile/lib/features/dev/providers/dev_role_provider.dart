import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants.dart';
import '../../../providers/app_providers.dart';
import '../../integration/providers/integration_auth_provider.dart';
import '../models/dev_role.dart';

final devRoleProvider = StateNotifierProvider<DevRoleNotifier, DevRole>((ref) {
  return DevRoleNotifier(ref);
});

class DevRoleNotifier extends StateNotifier<DevRole> {
  DevRoleNotifier(this._ref) : super(DevRole.chw);

  final Ref _ref;

  void select(DevRole role) {
    state = role;
  }

  Future<void> signInAs(DevRole role) async {
    state = role;
    await _ref
        .read(integrationAuthProvider.notifier)
        .signInAs(role.toPilotRole);
  }

  Future<void> signInWithToken({
    required String token,
    required String patientId,
  }) async {
    state = DevRole.chw;
    await _ref.read(integrationAuthProvider.notifier).signIn(
          token: token,
          patientId: patientId,
        );
  }

  DevRole loadFromPrefs() {
    final prefs = _ref.read(sharedPreferencesProvider);
    final role = DevRoleX.fromStorage(prefs.getString(AppConstants.prefsPilotRole));
    state = role;
    return role;
  }
}
