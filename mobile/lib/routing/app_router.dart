import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/caregiver/alerts_screen.dart';
import '../features/caregiver/dashboard_screen.dart';
import '../features/caregiver/patient_detail_screen.dart';
import '../features/caregiver/payments_screen.dart';
import '../features/chw/earnings_screen.dart';
import '../features/chw/tasks_screen.dart';
import '../features/chw/visit_form_screen.dart';
import '../features/onboarding/consent_screen.dart';
import '../features/onboarding/language_select_screen.dart';
import '../features/onboarding/plan_select_screen.dart';
import '../features/onboarding/profile_setup_screen.dart';
import '../features/onboarding/role_select_screen.dart';
import '../features/onboarding/signup_screen.dart';
import '../features/onboarding/splash_screen.dart';
import '../features/patient/add_reading_screen.dart';
import '../features/patient/care_screen.dart';
import '../features/patient/home_screen.dart';
import '../features/patient/profile_screen.dart';
import '../features/patient/readings_screen.dart';
import '../features/patient/service_booking_screen.dart';
import '../providers/app_providers.dart';

class AppRoutes {
  static const splash = '/';
  static const language = '/onboarding/language';
  static const role = '/onboarding/role';
  static const signup = '/onboarding/signup';
  static const profileSetup = '/onboarding/profile';
  static const consent = '/onboarding/consent';
  static const plan = '/onboarding/plan';

  static const patientHome = '/patient/home';
  static const patientAddReading = '/patient/add-reading';
  static const patientReadings = '/patient/readings';
  static const patientCare = '/patient/care';
  static const patientBooking = '/patient/booking';
  static const patientProfile = '/patient/profile';

  static const caregiverDashboard = '/caregiver/dashboard';
  static const caregiverPatient = '/caregiver/patient/:id';
  static const caregiverAlerts = '/caregiver/alerts';
  static const caregiverPayments = '/caregiver/payments';

  static const chwTasks = '/chw/tasks';
  static const chwVisit = '/chw/visit/:patientId';
  static const chwEarnings = '/chw/earnings';
}

final routerProvider = Provider<GoRouter>((ref) {
  final onboardingDone = ref.watch(onboardingCompleteProvider);
  final role = ref.watch(userRoleProvider);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    redirect: (context, state) {
      final loc = state.matchedLocation;
      final isOnboarding =
          loc.startsWith('/onboarding') || loc == AppRoutes.splash;

      if (!onboardingDone && !isOnboarding) {
        return AppRoutes.splash;
      }
      if (onboardingDone && isOnboarding && loc != AppRoutes.splash) {
        return _homeForRole(role);
      }
      if (onboardingDone && loc == AppRoutes.splash) {
        return _homeForRole(role);
      }
      return null;
    },
    routes: [
      GoRoute(path: AppRoutes.splash, builder: (_, _) => const SplashScreen()),
      GoRoute(
        path: AppRoutes.language,
        builder: (_, _) => const LanguageSelectScreen(),
      ),
      GoRoute(
        path: AppRoutes.role,
        builder: (_, _) => const RoleSelectScreen(),
      ),
      GoRoute(path: AppRoutes.signup, builder: (_, _) => const SignupScreen()),
      GoRoute(
        path: AppRoutes.profileSetup,
        builder: (_, _) => const ProfileSetupScreen(),
      ),
      GoRoute(
        path: AppRoutes.consent,
        builder: (_, _) => const ConsentScreen(),
      ),
      GoRoute(
        path: AppRoutes.plan,
        builder: (_, _) => const PlanSelectScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => PatientShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.patientHome,
            builder: (_, _) => const PatientHomeScreen(),
          ),
          GoRoute(
            path: AppRoutes.patientReadings,
            builder: (_, _) => const PatientReadingsScreen(),
          ),
          GoRoute(
            path: AppRoutes.patientCare,
            builder: (_, _) => const PatientCareScreen(),
          ),
          GoRoute(
            path: AppRoutes.patientProfile,
            builder: (_, _) => const PatientProfileScreen(),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.patientAddReading,
        builder: (_, _) => const AddReadingScreen(),
      ),
      GoRoute(
        path: AppRoutes.patientBooking,
        builder: (_, _) => const ServiceBookingScreen(),
      ),
      GoRoute(
        path: AppRoutes.caregiverDashboard,
        builder: (_, _) => const CaregiverDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.caregiverPatient,
        builder: (context, state) => PatientDetailScreen(
          patientId: state.pathParameters['id'] ?? 'demo',
          patientName: state.uri.queryParameters['name'] ?? 'Patient',
        ),
      ),
      GoRoute(
        path: AppRoutes.caregiverAlerts,
        builder: (_, _) => const CaregiverAlertsScreen(),
      ),
      GoRoute(
        path: AppRoutes.caregiverPayments,
        builder: (_, _) => const CaregiverPaymentsScreen(),
      ),
      GoRoute(
        path: AppRoutes.chwTasks,
        builder: (_, _) => const ChwTasksScreen(),
      ),
      GoRoute(
        path: AppRoutes.chwVisit,
        builder: (context, state) => ChwVisitFormScreen(
          patientId: state.pathParameters['patientId'] ?? 'demo',
          patientName: state.uri.queryParameters['name'] ?? 'Patient',
        ),
      ),
      GoRoute(
        path: AppRoutes.chwEarnings,
        builder: (_, _) => const ChwEarningsScreen(),
      ),
    ],
  );
});

String _homeForRole(String? role) {
  switch (role) {
    case 'caregiver':
      return AppRoutes.caregiverDashboard;
    case 'chw':
      return AppRoutes.chwTasks;
    default:
      return AppRoutes.patientHome;
  }
}

class PatientShell extends StatelessWidget {
  const PatientShell({super.key, required this.child});

  final Widget child;

  int _indexForLocation(String location) {
    if (location.startsWith(AppRoutes.patientReadings)) return 1;
    if (location.startsWith(AppRoutes.patientCare)) return 2;
    if (location.startsWith(AppRoutes.patientProfile)) return 3;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final index = _indexForLocation(location);

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) {
          switch (i) {
            case 0:
              context.go(AppRoutes.patientHome);
            case 1:
              context.go(AppRoutes.patientReadings);
            case 2:
              context.go(AppRoutes.patientCare);
            case 3:
              context.go(AppRoutes.patientProfile);
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(
            icon: Icon(Icons.monitor_heart_outlined),
            label: 'Readings',
          ),
          NavigationDestination(
            icon: Icon(Icons.medical_services_outlined),
            label: 'Care',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: index == 0
          ? FloatingActionButton.extended(
              onPressed: () => context.push(AppRoutes.patientAddReading),
              icon: const Icon(Icons.add),
              label: const Text('Add reading'),
            )
          : null,
    );
  }
}
