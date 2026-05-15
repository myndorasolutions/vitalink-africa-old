import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'data/isar/isar_service.dart';
import 'providers/app_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
  } catch (_) {
    // Firebase config files may be added per environment.
  }

  final prefs = await SharedPreferences.getInstance();
  final isarService = await IsarService.open();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        isarProvider.overrideWithValue(isarService.isar),
      ],
      child: const _SyncBootstrap(child: VitaLinkApp()),
    ),
  );
}

/// Triggers background sync when the app starts and after connectivity returns.
class _SyncBootstrap extends ConsumerStatefulWidget {
  const _SyncBootstrap({required this.child});

  final Widget child;

  @override
  ConsumerState<_SyncBootstrap> createState() => _SyncBootstrapState();
}

class _SyncBootstrapState extends ConsumerState<_SyncBootstrap> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(syncServiceProvider).scheduleBackgroundSync();
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
