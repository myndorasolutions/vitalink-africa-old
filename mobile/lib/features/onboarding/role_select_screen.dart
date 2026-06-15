import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants.dart';
import '../../providers/app_providers.dart';
import '../../routing/app_router.dart';

class RoleSelectScreen extends ConsumerWidget {
  const RoleSelectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roles = [
      ('patient', Icons.person, 'Patient', 'Track my own health readings'),
      ('caregiver', Icons.family_restroom, 'Caregiver', 'Help a family member stay healthy'),
      ('chw', Icons.health_and_safety, 'Community health worker', 'Visit patients in the community'),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('I am a...')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'How will you use Myndora Care?',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          ...roles.map((r) {
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  child: Icon(r.$2, color: Theme.of(context).colorScheme.primary),
                ),
                title: Text(r.$3, style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text(r.$4),
                trailing: const Icon(Icons.chevron_right),
                onTap: () async {
                  final prefs = ref.read(sharedPreferencesProvider);
                  await prefs.setString(AppConstants.prefsRole, r.$1);
                  if (context.mounted) context.go(AppRoutes.signup);
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
