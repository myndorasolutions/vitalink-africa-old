import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/constants.dart';
import 'core/theme.dart';
import 'routing/app_router.dart';
import 'routing/integration_router.dart';

class MyndoraCareApp extends ConsumerWidget {
  const MyndoraCareApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = AppConstants.integrationFlow
        ? ref.watch(integrationRouterProvider)
        : ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Myndora Care',
      theme: MyndoraCareTheme.light(),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
