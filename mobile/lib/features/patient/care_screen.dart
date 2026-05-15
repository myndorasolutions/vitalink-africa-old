import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../routing/app_router.dart';

class PatientCareScreen extends StatelessWidget {
  const PatientCareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      (Icons.medication, 'Medications', 'View and track your prescriptions'),
      (Icons.people, 'Care team', 'Your CHW, clinician, and pharmacy'),
      (Icons.calendar_today, 'Appointments', 'Upcoming visits and reminders'),
      (Icons.local_hospital, 'Book a service', 'Home visits, labs, and more'),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('My care')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.health_and_safety,
                      color: Theme.of(context).colorScheme.primary, size: 40),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Care plan',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                          'Hypertension & diabetes monitoring',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          ...items.map((item) {
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: Icon(item.$1),
                title: Text(item.$2),
                subtitle: Text(item.$3),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  if (item.$2 == 'Book a service') {
                    context.push(AppRoutes.patientBooking);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${item.$2} — coming soon')),
                    );
                  }
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
