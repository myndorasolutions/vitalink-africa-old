import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/vitals/data/models/vitals_queue_item.dart';
import 'local_vital.dart';

class IsarService {
  IsarService(this._isar);

  final Isar _isar;
  Isar get isar => _isar;

  static Future<IsarService> open() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [LocalVitalSchema, VitalsQueueItemSchema],
      directory: dir.path,
      name: 'myndora_care',
    );
    return IsarService(isar);
  }

  Future<List<LocalVital>> vitalsForPatient(String patientId) {
    return _isar.localVitals
        .filter()
        .patientIdEqualTo(patientId)
        .sortByCreatedAtDesc()
        .findAll();
  }

  Future<List<LocalVital>> pendingSync() {
    return _isar.localVitals
        .filter()
        .syncStatusEqualTo(SyncStatus.pending)
        .or()
        .syncStatusEqualTo(SyncStatus.failed)
        .findAll();
  }

  Future<void> saveVital(LocalVital vital) async {
    await _isar.writeTxn(() async {
      await _isar.localVitals.put(vital);
    });
  }

  Future<void> updateVital(LocalVital vital) async {
    await _isar.writeTxn(() async {
      await _isar.localVitals.put(vital);
    });
  }
}
