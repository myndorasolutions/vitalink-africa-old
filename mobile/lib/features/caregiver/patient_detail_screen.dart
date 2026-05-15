import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../routing/app_router.dart';
import '../../widgets/risk_badge.dart';

class PatientDetailScreen extends StatelessWidget {
  const PatientDetailScreen({
    super.key,
    required this.patientId,
    required this.patientName,
  });

  final String patientId;
  final String patientName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(patientName)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Current status',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      RiskBadge(status: 'yellow'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text('Latest: BP 158/98 mmHg'),
                  Text(
                    'Patient ID: $patientId',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.add_chart),
            title: const Text('Log reading for patient'),
            subtitle: const Text('Enter vitals on their behalf'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Opens vitals form with patient context'),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Reading history'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.medication),
            title: const Text('Medications'),
            subtitle: const Text('Amlodipine 5mg — daily'),
            onTap: () {},
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => context.push(AppRoutes.caregiverAlerts),
            icon: const Icon(Icons.warning_amber),
            label: const Text('View alerts'),
          ),
        ],
      ),
    );
  }
}
