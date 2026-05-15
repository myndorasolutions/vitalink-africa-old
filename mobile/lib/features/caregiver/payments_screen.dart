import 'package:flutter/material.dart';

class CaregiverPaymentsScreen extends StatelessWidget {
  const CaregiverPaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final payments = [
      ('Subscription — Standard', '₦2,500', 'Paid', '1 May 2026'),
      ('Home visit — Emeka', '₦8,000', 'Held in escrow', '28 Apr 2026'),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Payments')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Wallet balance', style: TextStyle(fontSize: 12)),
                  Text('₦0',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  Text('Caregivers pay for family subscriptions and services'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text('Recent', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ...payments.map((p) {
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                title: Text(p.$1),
                subtitle: Text('${p.$4} · ${p.$3}'),
                trailing: Text(
                  p.$2,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Paystack checkout opens here')),
              );
            },
            icon: const Icon(Icons.add_card),
            label: const Text('Pay subscription'),
          ),
        ],
      ),
    );
  }
}
