import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme.dart';
import 'routing/app_router.dart';

class VitaLinkApp extends ConsumerWidget {
  const VitaLinkApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'VitaLink Africa',
      theme: VitaLinkTheme.light(),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
