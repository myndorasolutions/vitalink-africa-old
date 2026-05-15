import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'local_vital.dart';

class IsarService {
  IsarService(this._isar);

  final Isar _isar;
  Isar get isar => _isar;

  static Future<IsarService> open() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [LocalVitalSchema],
      directory: dir.path,
      name: 'vitalink',
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
