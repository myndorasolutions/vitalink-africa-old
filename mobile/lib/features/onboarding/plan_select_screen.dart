import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants.dart';
import '../../providers/app_providers.dart';
import '../../routing/app_router.dart';

class PlanSelectScreen extends ConsumerWidget {
  const PlanSelectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plans = [
      ('basic', 'Basic', 'Free', 'Log vitals & view trends'),
      ('standard', 'Standard', '₦2,500/mo', 'Alerts + caregiver access'),
      ('premium', 'Premium', '₦5,000/mo', 'CHW visits + priority support'),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Choose a plan')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Pick what works for you',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          ...plans.map((p) {
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                title: Text(p.$2, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p.$4),
                    const SizedBox(height: 4),
                    Text(
                      p.$3,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                trailing: const Icon(Icons.check_circle_outline),
                onTap: () => _finish(context, ref, p.$1),
              ),
            );
          }),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => _finish(context, ref, 'basic'),
            child: const Text('Skip for now — use Basic free'),
          ),
        ],
      ),
    );
  }

  Future<void> _finish(BuildContext context, WidgetRef ref, String plan) async {
    final prefs = ref.read(sharedPreferencesProvider);
    final role = prefs.getString(AppConstants.prefsRole) ?? 'patient';
    await prefs.setString(AppConstants.prefsPlan, plan);
    await prefs.setBool(AppConstants.prefsOnboardingComplete, true);

    if (!context.mounted) return;
    switch (role) {
      case 'caregiver':
        context.go(AppRoutes.caregiverDashboard);
      case 'chw':
        context.go(AppRoutes.chwTasks);
      default:
        context.go(AppRoutes.patientHome);
    }
  }
}
