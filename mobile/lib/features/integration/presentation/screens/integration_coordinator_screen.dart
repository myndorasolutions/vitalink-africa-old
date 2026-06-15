import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../routing/integration_router.dart';
import '../widgets/integration_shell.dart';

class _ReviewRow {
  _ReviewRow({
    required this.id,
    required this.patient,
    required this.reading,
    required this.status,
  });

  final String id;
  final String patient;
  final String reading;
  String status;
}

class IntegrationCoordinatorScreen extends ConsumerStatefulWidget {
  const IntegrationCoordinatorScreen({super.key});

  @override
  ConsumerState<IntegrationCoordinatorScreen> createState() =>
      _IntegrationCoordinatorScreenState();
}

class _IntegrationCoordinatorScreenState
    extends ConsumerState<IntegrationCoordinatorScreen> {
  String? _feedback;
  late List<_ReviewRow> _reviews;

  @override
  void initState() {
    super.initState();
    _reviews = [
      _ReviewRow(
        id: 'rv-1',
        patient: 'Grace Okafor',
        reading: 'BP 148/94',
        status: 'pending',
      ),
      _ReviewRow(
        id: 'rv-2',
        patient: 'Ibrahim Musa',
        reading: 'BP 132/86',
        status: 'pending',
      ),
    ];
  }

  void _markReviewed(String id, String status) {
    setState(() {
      final row = _reviews.firstWhere((r) => r.id == id);
      row.status = status;
      _feedback = status == 'reviewed'
          ? 'Marked reviewed — pilot simulator state updated.'
          : 'Marked closed — pilot simulator state updated.';
    });
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) setState(() => _feedback = null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return IntegrationShell(
      title: 'Care coordinator',
      actions: [
        IconButton(
          icon: const Icon(Icons.sync),
          tooltip: 'Sync queue',
          onPressed: () => context.go(IntegrationRoutes.sync),
        ),
      ],
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Trust monitoring, sync queues, and clinician review simulator',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          if (_feedback != null) ...[
            const SizedBox(height: 12),
            MaterialBanner(
              content: Text(_feedback!),
              backgroundColor: Colors.green.shade50,
              actions: [
                TextButton(
                  onPressed: () => setState(() => _feedback = null),
                  child: const Text('Dismiss'),
                ),
              ],
            ),
          ],
          const SizedBox(height: 16),
          const _KpiRow(stats: [
            ('Active sponsors', '12'),
            ('Remote checks (7d)', '34'),
            ('Pending sync', '3'),
            ('Open alerts', '5'),
          ]),
          const SizedBox(height: 20),
          Text('Sponsor profiles', style: Theme.of(context).textTheme.titleMedium),
          const _DataCard(rows: [
            ('Ada Okonkwo', 'Grace Okafor', 'UK', 'family_care', 'active'),
            ('James Adeyemi', 'Ibrahim Musa', 'Nigeria', 'assisted_care', 'pending'),
          ]),
          const SizedBox(height: 16),
          Text('Remote check KPIs', style: Theme.of(context).textTheme.titleMedium),
          const _DataCard(rows: [
            ('Med adherence', '92%', '', '', ''),
            ('Symptom checks', '28/30', '', '', ''),
            ('Short-call warnings', '2', '', '', ''),
          ]),
          const SizedBox(height: 16),
          Text('Visit proof grid', style: Theme.of(context).textTheme.titleMedium),
          const _DataCard(rows: [
            ('Grace Okafor', 'Jun 5', 'Signature + OTP', 'Verified', ''),
            ('Ibrahim Musa', 'Jun 3', 'Signature', 'Pending', ''),
          ]),
          const SizedBox(height: 16),
          Text('Sync queue', style: Theme.of(context).textTheme.titleMedium),
          Card(
            child: ListTile(
              leading: const Icon(Icons.cloud_upload),
              title: const Text('3 pending · 1 failed'),
              subtitle: const Text('Tap sync icon above to open queue'),
              trailing: FilledButton(
                onPressed: () => context.go(IntegrationRoutes.sync),
                child: const Text('Open'),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text('Clinician reviewer (pilot simulator)',
              style: Theme.of(context).textTheme.titleMedium),
          ..._reviews.map(
            (r) => Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(r.patient, style: const TextStyle(fontWeight: FontWeight.w600)),
                    Text(r.reading),
                    Text('Status: ${r.status}',
                        style: Theme.of(context).textTheme.bodySmall),
                    if (r.status == 'pending') ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () => _markReviewed(r.id, 'reviewed'),
                            child: const Text('Mark reviewed'),
                          ),
                          TextButton(
                            onPressed: () => _markReviewed(r.id, 'closed'),
                            child: const Text('Mark closed'),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _KpiRow extends StatelessWidget {
  const _KpiRow({required this.stats});

  final List<(String, String)> stats;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: stats
          .map(
            (s) => Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Text(s.$2,
                          style: Theme.of(context).textTheme.headlineSmall),
                      Text(s.$1,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _DataCard extends StatelessWidget {
  const _DataCard({required this.rows});

  final List<(String, String, String, String, String)> rows;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: rows
            .map(
              (r) => ListTile(
                title: Text(r.$1),
                subtitle: Text([r.$2, r.$3, r.$4, r.$5]
                    .where((x) => x.isNotEmpty)
                    .join(' · ')),
              ),
            )
            .toList(),
      ),
    );
  }
}
