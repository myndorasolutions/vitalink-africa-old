import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../data/isar/isar_service.dart';
import '../data/isar/local_vital.dart';

class SyncService {
  SyncService({
    required IsarService isar,
    required Dio dio,
    required Connectivity connectivity,
  })  : _isar = isar,
        _dio = dio,
        _connectivity = connectivity;

  final IsarService _isar;
  final Dio _dio;
  final Connectivity _connectivity;
  bool _syncing = false;

  Future<void> syncPending() async {
    if (_syncing) return;
    final results = await _connectivity.checkConnectivity();
    if (results.contains(ConnectivityResult.none)) return;

    _syncing = true;
    try {
      final pending = await _isar.pendingSync();
      for (final vital in pending) {
        await _syncOne(vital);
      }
    } finally {
      _syncing = false;
    }
  }

  Future<void> _syncOne(LocalVital vital) async {
    vital.syncStatus = SyncStatus.syncing;
    await _isar.updateVital(vital);

    try {
      final response = await _dio.post('/vitals', data: {
        'patient_id': vital.patientId,
        if (vital.systolicBp != null) 'systolic_bp': vital.systolicBp,
        if (vital.diastolicBp != null) 'diastolic_bp': vital.diastolicBp,
        if (vital.pulse != null) 'pulse': vital.pulse,
        if (vital.glucoseFasting != null) 'glucose_fasting': vital.glucoseFasting,
        if (vital.glucoseRandom != null) 'glucose_random': vital.glucoseRandom,
        if (vital.weightKg != null) 'weight_kg': vital.weightKg,
        'symptoms': vital.symptoms,
        'medication_taken': vital.medicationTaken,
        'notes': vital.notes,
        'source_type': vital.sourceType,
        'capture_location_type': vital.captureLocationType,
        if (vital.serviceLayer.isNotEmpty) 'service_layer': vital.serviceLayer,
      });

      final data = response.data;
      if (data is Map) {
        vital.serverId = data['id']?.toString();
        final risk = data['risk_status'];
        if (risk is String) vital.riskStatus = risk;
      }
      vital.syncStatus = SyncStatus.synced;
      vital.syncedAt = DateTime.now();
      vital.syncError = null;
    } on DioException catch (e) {
      vital.syncStatus = SyncStatus.failed;
      vital.syncError = e.message ?? 'Sync failed';
      debugPrint('Vital sync failed: ${vital.localId} — ${vital.syncError}');
    } catch (e) {
      vital.syncStatus = SyncStatus.failed;
      vital.syncError = e.toString();
    }

    await _isar.updateVital(vital);
  }

  void scheduleBackgroundSync() {
    Future<void>.delayed(const Duration(seconds: 2), syncPending);
  }
}
