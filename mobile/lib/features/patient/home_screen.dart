import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/constants.dart';
import '../../providers/app_providers.dart';
import '../../widgets/risk_badge.dart';

class PatientHomeScreen extends ConsumerWidget {
  const PatientHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.watch(sharedPreferencesProvider);
    final name = prefs.getString(AppConstants.prefsUserName) ?? 'Friend';
    final patientId = prefs.getString(AppConstants.prefsPatientId) ?? 'local';
    final vitalsAsync = ref.watch(patientVitalsProvider(patientId));

    return Scaffold(
      appBar: AppBar(title: const Text('VitaLink')),
      body: vitalsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (vitals) {
          final latest = vitals.isNotEmpty ? vitals.first : null;
          return RefreshIndicator(
            onRefresh: () async {
              await ref.read(syncServiceProvider).syncPending();
              ref.invalidate(patientVitalsProvider(patientId));
            },
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  'Hello, $name',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Here is your health summary',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                const SizedBox(height: 20),
                if (latest != null)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Latest reading',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              RiskBadge(status: latest.riskStatus),
                            ],
                          ),
                          const SizedBox(height: 12),
                          if (latest.systolicBp != null)
                            Text(
                              'BP: ${latest.systolicBp}/${latest.diastolicBp ?? "—"} mmHg',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          if (latest.glucoseFasting != null)
                            Text('Fasting glucose: ${latest.glucoseFasting} mg/dL'),
                          Text(
                            DateFormat.yMMMd().add_jm().format(latest.createdAt),
                            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                          ),
                          if (latest.syncStatus.name != 'synced')
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                'Sync: ${latest.syncStatus.name}',
                                style: TextStyle(
                                  color: Colors.orange.shade800,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  )
                else
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Icon(Icons.monitor_heart_outlined,
                              size: 48, color: Colors.grey.shade400),
                          const SizedBox(height: 12),
                          const Text('No readings yet'),
                          const SizedBox(height: 8),
                          Text(
                            'Tap "Add reading" to log your first vital signs.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                Text(
                  'BP trend (last 7)',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 200,
                  child: _BpChart(vitals: vitals.take(7).toList().reversed.toList()),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _BpChart extends StatelessWidget {
  const _BpChart({required this.vitals});

  final List<dynamic> vitals;

  @override
  Widget build(BuildContext context) {
    final spots = <FlSpot>[];
    for (var i = 0; i < vitals.length; i++) {
      final v = vitals[i];
      if (v.systolicBp != null) {
        spots.add(FlSpot(i.toDouble(), v.systolicBp!.toDouble()));
      }
    }
    if (spots.isEmpty) {
      return Center(
        child: Text('Chart appears after BP readings',
            style: TextStyle(color: Colors.grey.shade500)),
      );
    }
    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: Theme.of(context).colorScheme.primary,
            barWidth: 3,
            dotData: const FlDotData(show: true),
          ),
        ],
      ),
    );
  }
}
