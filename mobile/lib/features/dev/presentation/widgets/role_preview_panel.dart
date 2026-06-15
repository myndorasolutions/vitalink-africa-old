import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../vitals/providers/vitals_queue_provider.dart';
import '../../models/dev_role.dart';

class RolePreviewPanel extends ConsumerWidget {
  const RolePreviewPanel({super.key, required this.role});

  final DevRole role;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(top: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Preview: ${role.title} view',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            switch (role) {
              DevRole.chw => const _ChwPreview(),
              DevRole.sponsor => const _SponsorPreview(),
              DevRole.admin => const _AdminPreview(),
            },
          ],
        ),
      ),
    );
  }
}

class _ChwPreview extends StatelessWidget {
  const _ChwPreview();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.mic, size: 18),
            SizedBox(width: 8),
            Expanded(child: Text('Guided vitals form with Yoruba audio prompts')),
          ],
        ),
        SizedBox(height: 6),
        Row(
          children: [
            Icon(Icons.draw, size: 18),
            SizedBox(width: 8),
            Expanded(child: Text('Signature pad + 4-digit OTP visit verification')),
          ],
        ),
      ],
    );
  }
}

class _SponsorPreview extends StatelessWidget {
  const _SponsorPreview();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Pricing package grid (Basic → Premium)'),
        SizedBox(height: 4),
        Text('CHW trust badges — Ilorin workers'),
        SizedBox(height: 4),
        Text('BP trend chart + alerts monitoring'),
      ],
    );
  }
}

class _AdminPreview extends ConsumerWidget {
  const _AdminPreview();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unsynced = ref.watch(unsyncedQueueCountProvider);
    final countLabel = unsynced.when(
      data: (n) => '$n pending vitals queue items',
      loading: () => 'Loading queue…',
      error: (_, _) => 'Queue unavailable',
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(countLabel),
        const SizedBox(height: 4),
        const Text('Sponsor profiles + remote check KPIs'),
        const SizedBox(height: 4),
        const Text('Clinician reviewer simulator'),
      ],
    );
  }
}
