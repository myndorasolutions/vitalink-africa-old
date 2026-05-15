import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../routing/app_router.dart';

class ChwTasksScreen extends StatelessWidget {
  const ChwTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = [
      ('t1', 'Adaeze Okafor', 'Home visit', '10:00 AM', 'Surulere'),
      ('t2', 'Emeka Nwosu', 'BP follow-up', '2:00 PM', 'Yaba'),
      ('t3', 'Fatima Bello', 'Urgent check', 'ASAP', 'Mushin'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Today\'s tasks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_balance_wallet_outlined),
            onPressed: () => context.push(AppRoutes.chwEarnings),
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _ChipStat(label: 'Visits', value: '3'),
                  _ChipStat(label: 'Done', value: '0'),
                  _ChipStat(label: 'Earned today', value: '₦0'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          ...tasks.map((t) {
            final urgent = t.$3.contains('Urgent');
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: urgent
                      ? Colors.red.shade100
                      : Theme.of(context).colorScheme.primaryContainer,
                  child: Icon(
                    urgent ? Icons.priority_high : Icons.directions_walk,
                    color: urgent
                        ? Colors.red
                        : Theme.of(context).colorScheme.primary,
                  ),
                ),
                title: Text(t.$2),
                subtitle: Text('${t.$3} · ${t.$4}\n${t.$5}'),
                isThreeLine: true,
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push(
                  '/chw/visit/${t.$1}?name=${Uri.encodeComponent(t.$2)}',
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _ChipStat extends StatelessWidget {
  const _ChipStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
        ),
      ],
    );
  }
}
