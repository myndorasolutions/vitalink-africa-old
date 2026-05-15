import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../routing/app_router.dart';

class ConsentScreen extends StatefulWidget {
  const ConsentScreen({super.key});

  @override
  State<ConsentScreen> createState() => _ConsentScreenState();
}

class _ConsentScreenState extends State<ConsentScreen> {
  bool _healthData = false;
  bool _caregiverShare = false;
  bool _notifications = false;

  bool get _canContinue => _healthData && _notifications;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Consent')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Your privacy matters',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Please read and accept how we use your health information.',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 24),
          SwitchListTile(
            title: const Text('Store and process my health readings'),
            subtitle: const Text(
              'Blood pressure, glucose, and related vitals on secure servers.',
            ),
            value: _healthData,
            onChanged: (v) => setState(() => _healthData = v),
          ),
          SwitchListTile(
            title: const Text('Share with my caregiver (optional)'),
            subtitle: const Text('Only people you approve can see your data.'),
            value: _caregiverShare,
            onChanged: (v) => setState(() => _caregiverShare = v),
          ),
          SwitchListTile(
            title: const Text('Send health alerts and reminders'),
            subtitle: const Text('Push notifications for high-risk readings.'),
            value: _notifications,
            onChanged: (v) => setState(() => _notifications = v),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: _canContinue ? () => context.go(AppRoutes.plan) : null,
            child: const Text('I agree and continue'),
          ),
        ],
      ),
    );
  }
}
