import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/screens/splash/splash_screen.dart';
import '../../presentation/screens/role_selection/role_selection_screen.dart';
import '../../presentation/screens/login/auth_screen.dart';
import '../../presentation/screens/dashboard/dashboard_screen.dart';
import '../../presentation/screens/report/report_wizard_screen.dart';
import '../../presentation/screens/alerts/alerts_screen.dart';
import '../../presentation/screens/alerts/alert_detail_screen.dart';
import '../../presentation/screens/sync/sync_screen.dart';
import '../../presentation/screens/settings/settings_screen.dart';
import '../../presentation/screens/report/report_history_screen.dart';
import '../../presentation/screens/report/reports_screen.dart';
import '../../presentation/screens/beneficiary/beneficiary_list_screen.dart';
import '../../presentation/screens/beneficiary/beneficiary_detail_screen.dart';
import '../../presentation/screens/beneficiary/family_detail_screen.dart';
import '../../presentation/screens/beneficiary/family_dashboard_screen.dart';
import '../../presentation/screens/beneficiary/qr_scanner_screen.dart';
import '../../presentation/screens/beneficiary/visit_entry_screen.dart';
import '../../presentation/screens/beneficiary/visit_form_screen.dart';
import '../../presentation/screens/beneficiary/vaccination_management_screen.dart';
import '../../presentation/screens/beneficiary/vaccination_form_screen.dart';
import '../../presentation/screens/growth/growth_chart_screen.dart';
import '../../presentation/screens/growth/growth_monitoring_screen.dart';
import '../../presentation/screens/extra/emergency_help_screen.dart';
import '../../presentation/screens/extra/daily_tasks_screen.dart';
import '../../presentation/screens/extra/nearby_facilities_screen.dart';
import '../../presentation/screens/beneficiary/add_family_screen.dart';
import '../../presentation/screens/beneficiary/add_member_screen.dart';
import '../../presentation/providers/providers.dart';
import '../../data/models/models.dart';
import '../constants/app_constants.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: false,
    redirect: (context, state) {
      final currentPath = state.uri.path;
      final isSplash = currentPath == AppRoutes.splash;
      final isAuthRoute = currentPath == AppRoutes.login || 
                          currentPath == AppRoutes.roleSelection;
      
      final isLoggedIn = authState != null;

      // --- [PART 2: Startup Flow Fix] ---
      // 1. Always allow Splash Screen to show its own navigation logic
      if (isSplash) return null;

      // 2. If not logged in and not on an auth route, force to login
      if (!isLoggedIn && !isAuthRoute) {
        return AppRoutes.login;
      }
      
      // 3. If logged in and on an auth route, go to dashboard
      // (Except if we just landed on Splash, which we handled above)
      if (isLoggedIn && isAuthRoute) {
        return AppRoutes.dashboard;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.roleSelection,
        builder: (context, state) => const RoleSelectionScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) {
          final role = state.extra as String? ?? 'ASHA Worker';
          return AuthScreen(role: role);
        },
      ),
      GoRoute(
        path: AppRoutes.dashboard,
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.newReport,
        builder: (context, state) => const ReportWizardScreen(),
      ),
      GoRoute(
        path: AppRoutes.alerts,
        builder: (context, state) => const AlertsScreen(),
      ),
      GoRoute(
        path: '/alerts/detail',
        builder: (context, state) =>
            AlertDetailScreen(alert: state.extra as AlertModel),
      ),
      GoRoute(
        path: AppRoutes.sync,
        builder: (context, state) => const SyncScreen(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.reportHistory,
        builder: (context, state) => const ReportHistoryScreen(),
      ),
      GoRoute(
        path: AppRoutes.monthlyReports,
        builder: (context, state) => const ReportsScreen(),
      ),

      GoRoute(
        path: AppRoutes.addVisit,
        builder: (context, state) => VisitFormScreen(
          beneficiaryId: state.pathParameters['beneficiaryId']!,
        ),
      ),
      GoRoute(
        path: AppRoutes.vaccination,
        builder: (context, state) => VaccinationFormScreen(
          beneficiaryId: state.pathParameters['beneficiaryId']!,
        ),
      ),
      // ── Beneficiary / Family Routes ──────────────────────────────────
      GoRoute(
        path: AppRoutes.addFamily,
        builder: (context, state) => const AddFamilyScreen(),
      ),
      GoRoute(
        path: AppRoutes.addMember,
        builder: (context, state) => AddMemberScreen(
          familyId: state.pathParameters['familyId']!,
        ),
      ),
      GoRoute(
        path: AppRoutes.beneficiaryList,
        builder: (context, state) => const BeneficiaryListScreen(),
      ),
      GoRoute(
        // /families/detail/:familyId — full family profile
        path: AppRoutes.familyDetail,
        builder: (context, state) => FamilyDetailScreen(
          familyId: state.pathParameters['familyId']!,
        ),
      ),
      GoRoute(
        // /beneficiaries/detail/:id — individual beneficiary profile
        path: AppRoutes.beneficiaryDetail,
        builder: (context, state) => BeneficiaryDetailScreen(
          beneficiaryId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: AppRoutes.qrScanner,
        builder: (context, state) => const QRScannerScreen(),
      ),
      GoRoute(
        path: AppRoutes.familyDashboard,
        builder: (context, state) => const FamilyDashboardScreen(),
      ),

      // ── Visit Routes ─────────────────────────────────────────────────
      GoRoute(
        // /visits/new/:beneficiaryId
        path: AppRoutes.addVisit,
        builder: (context, state) => VisitEntryScreen(
          beneficiaryId: state.pathParameters['beneficiaryId']!,
        ),
      ),

      // ── Vaccination Routes ───────────────────────────────────────────
      GoRoute(
        // /vaccination/:beneficiaryId
        path: AppRoutes.vaccination,
        builder: (context, state) => VaccinationManagementScreen(
          beneficiaryId: state.pathParameters['beneficiaryId']!,
        ),
      ),

      // ── Growth Routes ────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.growthMonitoring,
        builder: (context, state) => const GrowthMonitoringScreen(),
      ),
      GoRoute(
        // /growth/chart/:childId
        path: AppRoutes.growthChart,
        builder: (context, state) => GrowthChartScreen(
          childId: state.pathParameters['childId']!,
        ),
      ),
      GoRoute(
        path: AppRoutes.emergencyHelp,
        builder: (context, state) => const EmergencyHelpScreen(),
      ),
      GoRoute(
        path: AppRoutes.dailyTasks,
        builder: (context, state) => const DailyTasksScreen(),
      ),
      GoRoute(
        path: AppRoutes.nearbyFacilities,
        builder: (context, state) => const NearbyFacilitiesScreen(),
      ),
    ],
    // Don't redirect authenticated users to login on route errors.
    // Show a user-friendly error page instead.
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🔍', style: TextStyle(fontSize: 64)),
            const SizedBox(height: 16),
            Text(
              'Route not found: ${state.uri.path}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    ),
  );
});
