import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../routing/app_router.dart';

class CaregiverDashboardScreen extends StatelessWidget {
  const CaregiverDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final patients = [
      ('p1', 'Adaeze Okafor', 'yellow', 'BP 158/98 — 2h ago'),
      ('p2', 'Emeka Nwosu', 'green', 'All clear — today'),
      ('p3', 'Fatima Bello', 'red', 'Chest pain reported — urgent'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Caregiver dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => context.push(AppRoutes.caregiverAlerts),
          ),
          IconButton(
            icon: const Icon(Icons.payment_outlined),
            onPressed: () => context.push(AppRoutes.caregiverPayments),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  _StatBox(label: 'Patients', value: '3'),
                  _StatBox(label: 'Alerts', value: '2'),
                  _StatBox(label: 'Due today', value: '1'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text('Your patients', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ...patients.map((p) {
            final color = p.$3 == 'red'
                ? Colors.red
                : p.$3 == 'yellow'
                ? Colors.orange
                : Colors.green;
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: color.withValues(alpha: 0.2),
                  child: Icon(Icons.person, color: color),
                ),
                title: Text(p.$2),
                subtitle: Text(p.$4),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push(
                  '/caregiver/patient/${p.$1}?name=${Uri.encodeComponent(p.$2)}',
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  const _StatBox({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            label,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
