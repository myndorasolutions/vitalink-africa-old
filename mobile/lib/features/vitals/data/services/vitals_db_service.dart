import 'package:isar/isar.dart';

import '../models/vitals_queue_item.dart';

class VitalsDbService {
  VitalsDbService(this._isar);

  final Isar _isar;

  Future<void> enqueue(VitalsQueueItem item) async {
    await _isar.writeTxn(() async {
      await _isar.vitalsQueueItems.put(item);
    });
  }

  Future<List<VitalsQueueItem>> getAllForPatient(String patientId) {
    return _isar.vitalsQueueItems
        .filter()
        .patientIdEqualTo(patientId)
        .sortByCapturedAtDesc()
        .findAll();
  }

  Future<List<VitalsQueueItem>> getUnsynced() {
    return _isar.vitalsQueueItems
        .filter()
        .isSyncedEqualTo(false)
        .sortByCapturedAtDesc()
        .findAll();
  }

  Future<void> markSynced(int id) async {
    await _isar.writeTxn(() async {
      final item = await _isar.vitalsQueueItems.get(id);
      if (item == null) return;
      item.isSynced = true;
      await _isar.vitalsQueueItems.put(item);
    });
  }

  Future<void> delete(int id) async {
    await _isar.writeTxn(() async {
      await _isar.vitalsQueueItems.delete(id);
    });
  }

  Future<int> countUnsynced() {
    return _isar.vitalsQueueItems.filter().isSyncedEqualTo(false).count();
  }
}
