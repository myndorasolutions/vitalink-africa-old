import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/app_providers.dart';
import '../data/models/vitals_queue_item.dart';
import '../data/services/vitals_db_service.dart';

final vitalsDbServiceProvider = Provider<VitalsDbService>((ref) {
  return VitalsDbService(ref.watch(isarProvider));
});

final unsyncedQueueProvider = FutureProvider<List<VitalsQueueItem>>((ref) {
  return ref.watch(vitalsDbServiceProvider).getUnsynced();
});

final unsyncedQueueCountProvider = FutureProvider<int>((ref) {
  return ref.watch(vitalsDbServiceProvider).countUnsynced();
});
