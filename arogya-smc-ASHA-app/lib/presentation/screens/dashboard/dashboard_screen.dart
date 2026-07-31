import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';
import '../beneficiary/family_dashboard_screen.dart';
import '../growth/growth_monitoring_screen.dart';
import '../settings/settings_screen.dart';
import '../report/reports_screen.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../providers/providers.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final worker = ref.watch(currentWorkerProvider);
    if (worker == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final todayAsync = ref.watch(todaysReportsProvider);
    final pendingAsync = ref.watch(pendingCountProvider);
    final unreadAsync = ref.watch(unreadCountProvider);

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _DashboardHome(
            worker: worker,
            todayAsync: todayAsync,
            pendingAsync: pendingAsync,
            unreadAsync: unreadAsync,
          ),
          const FamilyDashboardScreen(),
          const ReportsScreen(),
          const SettingsScreen(),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton.extended(
              onPressed: () => context.go(AppRoutes.newReport),
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              icon: const Icon(Icons.add, size: 28),
              label: Text(
                'report.new_report'.tr(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildComingSoon(String title) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('common.loading'.tr())),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) {
          setState(() => _selectedIndex = i);
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textLight,
        elevation: 0,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.dashboard_outlined),
            activeIcon: const Icon(Icons.dashboard_rounded),
            label: 'dashboard.title'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.family_restroom_outlined),
            activeIcon: const Icon(Icons.family_restroom_rounded),
            label: 'families.title'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.assignment_outlined),
            activeIcon: const Icon(Icons.assignment_rounded),
            label: 'reports.title'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outlined),
            activeIcon: const Icon(Icons.person_rounded),
            label: 'profile.title'.tr(),
          ),
        ],
      ),
    );
  }
}

class _DashboardHome extends ConsumerWidget {
  final dynamic worker;
  final AsyncValue<dynamic> todayAsync;
  final AsyncValue<int> pendingAsync;
  final AsyncValue<int> unreadAsync;

  const _DashboardHome({
    required this.worker,
    required this.todayAsync,
    required this.pendingAsync,
    required this.unreadAsync,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final today = DateFormat('EEEE, dd MMM yyyy').format(DateTime.now());

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(todaysReportsProvider);
        ref.invalidate(pendingCountProvider);
        ref.invalidate(unreadCountProvider);
        ref.invalidate(allReportsProvider);
        await Future.delayed(const Duration(seconds: 1));
      },
      displacement: 80,
      color: AppColors.primary,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
        // App Bar with gradient
        SliverAppBar(
          expandedHeight: 200,
          pinned: true,
          backgroundColor: AppColors.primary,
          automaticallyImplyLeading: false,
          elevation: 0,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: const BoxDecoration(
                gradient: AppColors.headerGradient,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(77),
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.white,
                          child: Text(
                            worker.fullName.isNotEmpty ? worker.fullName[0].toUpperCase() : 'A',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${'dashboard.welcome'.tr()},',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withAlpha(204),
                                fontFamily: 'Poppins',
                              ),
                            ),
                            Text(
                              '${worker.fullName.split(' ')[0]}!',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                height: 1.1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Consumer(
                            builder: (context, ref, child) {
                              final isOnlineAsync = ref.watch(isOnlineProvider);
                              final isOnline = isOnlineAsync.value ?? false;
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: isOnline ? Colors.green.withAlpha(51) : Colors.red.withAlpha(51),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 8, height: 8, 
                                      decoration: BoxDecoration(
                                        color: isOnline ? Colors.greenAccent : Colors.redAccent, 
                                        shape: BoxShape.circle
                                      )
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      isOnline ? 'Online' : 'Offline', 
                                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 8),
                          Stack(
                        children: [
                          IconButton(
                            onPressed: () => context.push(AppRoutes.sync),
                            icon: const Icon(Icons.sync, color: Colors.white),
                            tooltip: 'dashboard.sync_data'.tr(),
                          ),
                          if (pendingAsync.valueOrNull != null && pendingAsync.value! > 0)
                            Positioned(
                              right: 8,
                              top: 8,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: AppColors.warningYellow,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '${pendingAsync.value}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ), // This closes the inner Row we added
                ],
              ), // This closes the outer Row
              const Spacer(),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, color: Colors.white70, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        'Solapur Ward: ${worker.wardCode}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const Spacer(),
                      Text(
                        today,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Stats Row
              _StatsRow(
                todayAsync: todayAsync,
                pendingAsync: pendingAsync,
                unreadAsync: unreadAsync,
              ),
              const SizedBox(height: 12),
              // Alerts Banner
              if (unreadAsync.valueOrNull != null && unreadAsync.value! > 0)
                GestureDetector(
                  onTap: () => context.push(AppRoutes.alerts),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.criticalRed.withAlpha(20),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.criticalRed.withAlpha(80)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.warning_amber_rounded, color: AppColors.criticalRed),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'You have ${unreadAsync.value} unread alerts',
                            style: const TextStyle(
                              color: AppColors.criticalRed,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: AppColors.criticalRed),
                      ],
                    ),
                  ),
                ),
              // Quick Actions
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 4),
                child: Text(
                  'Quick Actions',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                ),
              ),
              _QuickActionsGrid(),
              const SizedBox(height: 20),
              // Recent Reports
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Reports',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontFamily: 'Poppins',
                        ),
                  ),
                  TextButton(
                    onPressed: () => context.push(AppRoutes.reportHistory),
                    child: const Text(
                      'View All',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _RecentReportsList(),
              const SizedBox(height: 80),
            ]),
          ),
        ),
        ],
      ),
    );
  }
}

class _StatsRow extends ConsumerWidget {
  final AsyncValue<dynamic> todayAsync;
  final AsyncValue<int> pendingAsync;
  final AsyncValue<int> unreadAsync;

  const _StatsRow({
    required this.todayAsync,
    required this.pendingAsync,
    required this.unreadAsync,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayCount = todayAsync.when(
      data: (list) => list.length,
      loading: () => 0,
      error: (_, __) => 0,
    );
    final pendingCount = pendingAsync.when(
      data: (v) => v,
      loading: () => 0,
      error: (_, __) => 0,
    );
    final unreadCount = unreadAsync.when(
      data: (v) => v,
      loading: () => 0,
      error: (_, __) => 0,
    );

    return Row(
      children: [
        Expanded(
          child: _StatCard(
            label: 'dashboard.todays_reports'.tr(),
            value: todayCount.toString(),
            icon: Icons.assignment_outlined,
            color: AppColors.normalGreen,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatCard(
            label: 'dashboard.pending_sync'.tr(),
            value: pendingCount.toString(),
            icon: Icons.sync_outlined,
            color: pendingCount > 0
                ? AppColors.warningYellow
                : AppColors.normalGreen,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatCard(
            label: 'dashboard.unread_alerts'.tr(),
            value: unreadCount.toString(),
            icon: Icons.notifications_outlined,
            color: unreadCount > 0
                ? AppColors.criticalRed
                : AppColors.normalGreen,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: color,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textSecondary,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionsGrid extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actions = [
      _QuickAction(
        label: 'dashboard.beneficiaries'.tr(),
        emoji: '👥',
        color: const Color(0xFF00796B),
        route: AppRoutes.beneficiaryList,
      ),
      _QuickAction(
        label: 'dashboard.health_alerts'.tr(),
        emoji: '⚠️',
        color: const Color(0xFFED6C02),
        route: AppRoutes.alerts,
      ),
      _QuickAction(
        label: 'dashboard.emergency_help'.tr(),
        emoji: '🆘',
        color: const Color(0xFFD32F2F),
        route: AppRoutes.emergencyHelp,
      ),
      _QuickAction(
        label: 'dashboard.daily_tasks'.tr(),
        emoji: '✅',
        color: const Color(0xFF7B1FA2),
        route: AppRoutes.dailyTasks,
      ),
      _QuickAction(
        label: 'dashboard.growth_monitoring'.tr(),
        emoji: '📈',
        color: const Color(0xFF0288D1),
        route: AppRoutes.growthMonitoring,
      ),
      _QuickAction(
        label: 'dashboard.nearby_facilities'.tr(),
        emoji: '🏥',
        color: const Color(0xFF00897B),
        route: AppRoutes.nearbyFacilities,
      ),
    ];

    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.95,
      ),
      itemCount: actions.length,
      itemBuilder: (ctx, i) {
        final action = actions[i];
        return _QuickActionCard(action: action);
      },
    );
  }
}

class _QuickAction {
  final String label;
  final String emoji;
  final Color color;
  final String route;

  const _QuickAction({
    required this.label,
    required this.emoji,
    required this.color,
    required this.route,
  });
}

class _QuickActionCard extends StatelessWidget {
  final _QuickAction action;

  const _QuickActionCard({required this.action});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(action.route),
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: action.color.withAlpha(31),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(action.emoji,
                      style: const TextStyle(fontSize: 24)),
                ),
              ),
              const SizedBox(height: 2),
              Expanded(
                child: Center(
                  child: Text(
                    action.label,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecentReportsList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportsAsync = ref.watch(allReportsProvider);

    return reportsAsync.when(
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: CircularProgressIndicator(),
        ),
      ),
      error: (e, __) => Center(child: Text('${'common.error'.tr()}: $e')),
      data: (reports) {
        if (reports.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Column(
                children: [
                  const Text('📋', style: TextStyle(fontSize: 48)),
                  const SizedBox(height: 12),
                  Text(
                    'dashboard.no_reports'.tr(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 15,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        final recent = reports.take(5).toList();
        return Column(
          children: recent
              .map((r) => _ReportListItem(report: r))
              .toList(),
        );
      },
    );
  }
}

class _ReportListItem extends StatelessWidget {
  final dynamic report;

  const _ReportListItem({required this.report});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd MMM yyyy, hh:mm a').format(report.reportDate);
    final isSynced = report.isSynced;
    final isPending = report.isPending;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.primaryLighter,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Text('📋', style: TextStyle(fontSize: 24)),
          ),
        ),
        title: Text(
          'Health Report',
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        subtitle: Text(
          date,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
            fontFamily: 'Poppins',
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: isSynced
                ? AppColors.normalGreen.withAlpha(31)
                : isPending
                    ? AppColors.warningYellow.withAlpha(31)
                    : AppColors.criticalRed.withAlpha(31),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            isSynced
                ? 'Synced'
                : isPending
                    ? 'Pending'
                    : 'Failed',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isSynced
                  ? AppColors.normalGreen
                  : isPending
                      ? AppColors.warningYellow
                      : AppColors.criticalRed,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ),
    );
  }
}
