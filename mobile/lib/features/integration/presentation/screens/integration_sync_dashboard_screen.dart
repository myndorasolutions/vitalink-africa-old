import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/isar/local_vital.dart';
import '../../../../providers/app_providers.dart';
import '../../providers/integration_auth_provider.dart';
import '../widgets/integration_shell.dart';

class IntegrationSyncDashboardScreen extends ConsumerStatefulWidget {
  const IntegrationSyncDashboardScreen({super.key});

  @override
  ConsumerState<IntegrationSyncDashboardScreen> createState() =>
      _IntegrationSyncDashboardScreenState();
}

class _IntegrationSyncDashboardScreenState
    extends ConsumerState<IntegrationSyncDashboardScreen> {
  bool _syncing = false;
  List<LocalVital> _vitals = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final patientId = ref.read(integrationPatientIdProvider);
    if (patientId == null) return;
    final vitals =
        await ref.read(isarServiceProvider).vitalsForPatient(patientId);
    if (mounted) setState(() => _vitals = vitals);
  }

  Future<void> _syncNow() async {
    setState(() => _syncing = true);
    try {
      await ref.read(syncServiceProvider).syncPending();
      await _load();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sync complete')),
      );
    } finally {
      if (mounted) setState(() => _syncing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final pending =
        _vitals.where((v) => v.syncStatus == SyncStatus.pending).length;
    final failed =
        _vitals.where((v) => v.syncStatus == SyncStatus.failed).length;
    final synced =
        _vitals.where((v) => v.syncStatus == SyncStatus.synced).length;

    return IntegrationShell(
      title: 'Sync queue',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _Stat(label: 'Pending', count: pending),
                      _Stat(label: 'Synced', count: synced),
                      _Stat(label: 'Failed', count: failed),
                    ],
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: _syncing ? null : _syncNow,
                    icon: const Icon(Icons.cloud_upload),
                    label: Text(_syncing ? 'Syncing…' : 'Sync now'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          ..._vitals.map(
            (v) => ListTile(
              title: Text('BP ${v.systolicBp ?? '-'}/${v.diastolicBp ?? '-'}'),
              subtitle:
                  Text('${v.syncStatus.name} · ${v.createdAt.toLocal()}'),
            ),
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.count});

  final String label;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$count', style: Theme.of(context).textTheme.headlineSmall),
        Text(label),
      ],
    );
  }
}
