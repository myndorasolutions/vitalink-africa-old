import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants.dart';
import '../../providers/app_providers.dart';
import '../../routing/app_router.dart';

class LanguageSelectScreen extends ConsumerWidget {
  const LanguageSelectScreen({super.key});

  static const _languages = [
    ('en', 'English'),
    ('yo', 'Yorùbá'),
    ('ig', 'Igbo'),
    ('ha', 'Hausa'),
    ('pcm', 'Pidgin'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose language')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Which language do you prefer?',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'You can change this later in settings.',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 24),
          ..._languages.map((lang) {
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                title: Text(lang.$2),
                trailing: const Icon(Icons.chevron_right),
                onTap: () async {
                  final prefs = ref.read(sharedPreferencesProvider);
                  await prefs.setString(AppConstants.prefsLanguage, lang.$1);
                  if (context.mounted) context.go(AppRoutes.role);
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
