import 'package:isar/isar.dart';

part 'local_vital.g.dart';

@collection
class LocalVital {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String localId;

  String? serverId;
  late String patientId;

  int? systolicBp;
  int? diastolicBp;
  int? pulse;
  double? glucoseFasting;
  double? glucoseRandom;
  double? weightKg;

  List<String> symptoms = [];
  bool medicationTaken = false;
  String notes = '';

  @Enumerated(EnumType.name)
  late SyncStatus syncStatus;

  String riskStatus = 'green';
  String sourceType = 'patient_self';
  String captureLocationType = 'home';
  String serviceLayer = 'physical_chw_visit';
  String verificationMethod = '';
  bool verificationConfirmed = false;

  late DateTime createdAt;
  DateTime? syncedAt;
  String? syncError;
}

enum SyncStatus {
  pending,
  syncing,
  synced,
  failed,
}
