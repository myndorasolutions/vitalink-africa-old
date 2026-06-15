import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/integration/models/pilot_role.dart';
import '../features/integration/presentation/screens/integration_checkup_screen.dart';
import '../features/integration/presentation/screens/integration_coordinator_screen.dart';
import '../features/dev/presentation/screens/role_switcher_screen.dart';
import '../features/integration/presentation/screens/integration_sponsor_screen.dart';
import '../features/integration/presentation/screens/integration_sync_dashboard_screen.dart';
import '../features/integration/providers/integration_auth_provider.dart';

class IntegrationRoutes {
  static const login = '/integration/login';
  static const checkup = '/integration/checkup';
  static const sponsor = '/integration/sponsor';
  static const coordinator = '/integration/coordinator';
  static const sync = '/integration/sync';
}

final integrationRouterProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(integrationAuthProvider);

  return GoRouter(
    initialLocation: IntegrationRoutes.login,
    redirect: (context, state) {
      final loc = state.matchedLocation;
      if (!auth.isAuthenticated && loc != IntegrationRoutes.login) {
        return IntegrationRoutes.login;
      }
      if (auth.isAuthenticated && loc == IntegrationRoutes.login) {
        return auth.pilotRole?.homeRoute ?? IntegrationRoutes.checkup;
      }

      final role = auth.pilotRole;
      if (role != null && auth.isAuthenticated) {
        if (loc == IntegrationRoutes.sync && role != PilotRole.coordinator) {
          return role.homeRoute;
        }
        if (loc == IntegrationRoutes.checkup && role != PilotRole.chw) {
          return role.homeRoute;
        }
        if (loc == IntegrationRoutes.sponsor && role != PilotRole.sponsor) {
          return role.homeRoute;
        }
        if (loc == IntegrationRoutes.coordinator &&
            role != PilotRole.coordinator) {
          return role.homeRoute;
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: IntegrationRoutes.login,
        builder: (_, _) => const RoleSwitcherScreen(),
      ),
      GoRoute(
        path: IntegrationRoutes.checkup,
        builder: (_, _) => const IntegrationCheckupScreen(),
      ),
      GoRoute(
        path: IntegrationRoutes.sponsor,
        builder: (_, _) => const IntegrationSponsorScreen(),
      ),
      GoRoute(
        path: IntegrationRoutes.coordinator,
        builder: (_, _) => const IntegrationCoordinatorScreen(),
      ),
      GoRoute(
        path: IntegrationRoutes.sync,
        builder: (_, _) => const IntegrationSyncDashboardScreen(),
      ),
    ],
  );
});
