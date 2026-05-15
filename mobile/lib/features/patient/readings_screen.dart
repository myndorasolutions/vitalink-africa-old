import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/constants.dart';
import '../../providers/app_providers.dart';
import '../../widgets/risk_badge.dart';

class PatientReadingsScreen extends ConsumerWidget {
  const PatientReadingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientId =
        ref
            .watch(sharedPreferencesProvider)
            .getString(AppConstants.prefsPatientId) ??
        'local';
    final vitalsAsync = ref.watch(patientVitalsProvider(patientId));

    return Scaffold(
      appBar: AppBar(title: const Text('My readings')),
      body: vitalsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (vitals) {
          if (vitals.isEmpty) {
            return Center(
              child: Text(
                'No readings yet',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              await ref.read(syncServiceProvider).syncPending();
              ref.invalidate(patientVitalsProvider(patientId));
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: vitals.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, i) {
                final v = vitals[i];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.primaryContainer,
                      child: const Icon(Icons.favorite),
                    ),
                    title: Text(
                      v.systolicBp != null
                          ? 'BP ${v.systolicBp}/${v.diastolicBp ?? "—"}'
                          : 'Glucose / other',
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().add_jm().format(v.createdAt),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        RiskBadge(status: v.riskStatus),
                        const SizedBox(height: 4),
                        Text(
                          v.syncStatus.name,
                          style: const TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                    isThreeLine: v.symptoms.isNotEmpty,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) => Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Details',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              if (v.glucoseFasting != null)
                                Text('Fasting glucose: ${v.glucoseFasting}'),
                              if (v.symptoms.isNotEmpty)
                                Text('Symptoms: ${v.symptoms.join(", ")}'),
                              if (v.notes.isNotEmpty) Text('Notes: ${v.notes}'),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
