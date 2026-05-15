import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/api_client.dart';
import '../data/isar/isar_service.dart';
import '../data/isar/local_vital.dart';
import '../services/sync_service.dart';

export '../core/api_client.dart' show apiClientProvider;

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences must be overridden in main()');
});

final isarProvider = Provider<Isar>((ref) {
  throw UnimplementedError('Isar must be overridden in main()');
});

final isarServiceProvider = Provider<IsarService>((ref) {
  return IsarService(ref.watch(isarProvider));
});

final connectivityProvider = Provider<Connectivity>((ref) => Connectivity());

final syncServiceProvider = Provider<SyncService>((ref) {
  return SyncService(
    isar: ref.watch(isarServiceProvider),
    dio: ref.watch(apiClientProvider),
    connectivity: ref.watch(connectivityProvider),
  );
});

final patientVitalsProvider =
    FutureProvider.family<List<LocalVital>, String>((ref, patientId) {
  return ref.watch(isarServiceProvider).vitalsForPatient(patientId);
});

final onboardingCompleteProvider = Provider<bool>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getBool('onboarding_complete') ?? false;
});

final userRoleProvider = Provider<String?>((ref) {
  return ref.watch(sharedPreferencesProvider).getString('role');
});
