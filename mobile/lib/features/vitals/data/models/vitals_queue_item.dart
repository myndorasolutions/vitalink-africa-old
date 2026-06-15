import 'package:isar/isar.dart';

part 'vitals_queue_item.g.dart';

@collection
class VitalsQueueItem {
  Id id = Isar.autoIncrement;

  late String patientId;
  int? systolicBp;
  int? diastolicBp;
  double? bloodGlucose;
  late DateTime capturedAt;
  bool isSynced = false;
}
