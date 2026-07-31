// lib/navigation/app_router.dart

import 'package:go_router/go_router.dart';
import '../views/splash/splash_screen.dart';
import '../views/welcome/welcome_screen.dart';
import '../views/home/home_screen.dart';
import '../views/hospitals/hospitals_screen.dart';
import '../views/hospital_detail/hospital_detail_screen.dart';
import '../views/alerts/alerts_screen.dart';
import '../views/profile/profile_screen.dart';
import 'main_scaffold.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const WelcomeScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => MainScaffold(child: child),
      routes: [
        GoRoute(
          path: '/home',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HomeScreen(),
          ),
        ),
        GoRoute(
          path: '/hospitals',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HospitalsScreen(),
          ),
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) => HospitalDetailScreen(
                hospitalId: state.pathParameters['id']!,
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/alerts',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: AlertsScreen(),
          ),
        ),
        GoRoute(
          path: '/profile',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ProfileScreen(),
          ),
        ),
      ],
    ),
  ],
);
