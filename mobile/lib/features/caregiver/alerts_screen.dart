import 'package:flutter/material.dart';

import '../../widgets/risk_badge.dart';

class CaregiverAlertsScreen extends StatelessWidget {
  const CaregiverAlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final alerts = [
      (
        'high_bp',
        'red',
        'Fatima Bello',
        'BP 182/124 — seek care now',
        '10 min ago',
      ),
      (
        'high_glucose',
        'yellow',
        'Adaeze Okafor',
        'Fasting glucose 210 mg/dL',
        '2h ago',
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Alerts')),
      body: alerts.isEmpty
          ? const Center(child: Text('No active alerts'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: alerts.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, i) {
                final a = alerts[i];
                return Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.red,
                    ),
                    title: Text(a.$3),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(a.$4),
                        Text(
                          a.$5,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    trailing: RiskBadge(status: a.$2),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text('Alert actions'),
                          content: const Text(
                            'Call patient, mark as seen, or escalate to clinician.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Dismiss'),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Mark seen'),
                            ),
                          ],
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
