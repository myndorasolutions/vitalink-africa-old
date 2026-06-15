import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/integration_auth_provider.dart';

class IntegrationShell extends ConsumerWidget {
  const IntegrationShell({
    super.key,
    required this.title,
    required this.child,
    this.actions,
  });

  final String title;
  final Widget child;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/myndora_care_logo5.jpeg',
              height: 28,
              errorBuilder: (_, _, _) => const Icon(Icons.health_and_safety),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(title)),
          ],
        ),
        actions: [
          ...?actions,
          TextButton.icon(
            onPressed: () async {
              await ref.read(integrationAuthProvider.notifier).signOut();
              if (context.mounted) context.go('/integration/login');
            },
            icon: const Icon(Icons.logout, color: Colors.white),
            label: const Text('Logout'),
          ),
        ],
      ),
      body: child,
    );
  }
}
