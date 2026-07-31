import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../providers/providers.dart';
import '../../../data/models/models.dart';

class AlertsScreen extends ConsumerStatefulWidget {
  const AlertsScreen({super.key});

  @override
  ConsumerState<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends ConsumerState<AlertsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _refreshAlerts() async {
    // We already fetch inside getAllAlerts so we just invalidate the provider
    ref.invalidate(alertsProvider);
    // Wait for the new future to complete
    await ref.read(alertsProvider.future);
  }

  @override
  Widget build(BuildContext context) {
    final alertsAsync = ref.watch(alertsProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('alerts.title'.tr()),
        actions: [
          IconButton(
            onPressed: () async {
              await ref.read(alertRepositoryProvider).markAllRead();
              ref.invalidate(alertsProvider);
              ref.invalidate(unreadCountProvider);
            },
            icon: const Icon(Icons.check),
            tooltip: 'Mark Read',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white.withOpacity(0.7),
          labelStyle: const TextStyle(
              fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(
              fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w500),
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'High'),
            Tab(text: 'Med'),
            Tab(text: 'Low'),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshAlerts,
        child: alertsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => ListView( // ListView needed for RefreshIndicator
            children: [
               SizedBox(height: MediaQuery.of(context).size.height * 0.4),
               Center(child: Text('Error loading alerts: $e')),
            ],
          ),
          data: (alerts) {
            // Sort to ensure descending date
            final sortedAlerts = List<AlertModel>.from(alerts)
              ..sort((a, b) => b.generatedAt.compareTo(a.generatedAt));

            return TabBarView(
              controller: _tabController,
              children: [
                _AlertsList(alerts: sortedAlerts),
                _AlertsList(
                    alerts: sortedAlerts.where((a) => a.severity == 'high').toList()),
                _AlertsList(
                    alerts: sortedAlerts.where((a) => a.severity == 'medium').toList()),
                _AlertsList(
                    alerts: sortedAlerts.where((a) => a.severity == 'low').toList()),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _AlertsList extends ConsumerWidget {
  final List<AlertModel> alerts;

  const _AlertsList({required this.alerts});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (alerts.isEmpty) {
      return ListView(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.2),
          Container(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLighter,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.notifications_none_rounded, size: 64, color: AppColors.primary),
                ),
                const SizedBox(height: 24),
                Text(
                  'alerts.no_alerts'.tr(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.textSecondary,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: alerts.length,
      itemBuilder: (ctx, i) {
        final alert = alerts[i];
        return _AlertCard(
          alert: alert,
          onTap: () async {
            await ref.read(alertRepositoryProvider).markRead(int.parse(alert.id));
            ref.invalidate(alertsProvider);
            ref.invalidate(unreadCountProvider);
            context.push('/alerts/detail', extra: alert);
          },
        );
      },
    );
  }

}

class _AlertCard extends StatelessWidget {
  final AlertModel alert;
  final VoidCallback onTap;

  const _AlertCard({required this.alert, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final severityColors = {
      'critical': const Color(0xFFF44336),
      'high': const Color(0xFFFF5722),
      'medium': const Color(0xFFFFC107),
      'low': const Color(0xFF4CAF50),
    };
    final color =
        severityColors[alert.severity] ?? const Color(0xFF9E9E9E);

    final typeIcons = {
      'outbreak': '🦠',
      'resource': '💊',
      'weather': '☀️',
      'other': '📢',
    };
    final emoji = typeIcons[alert.type] ?? '📢';

    return Card(
      elevation: alert.isRead ? 0 : 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: alert.isRead ? Colors.grey.shade50 : Colors.white,
            border: Border.all(
              color: alert.isRead
                  ? AppColors.divider
                  : color.withOpacity(0.2),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(
                    alert.type == 'outbreak' ? Icons.coronavirus_rounded :
                    alert.type == 'resource' ? Icons.medical_information_rounded :
                    alert.type == 'weather' ? Icons.wb_sunny_rounded : Icons.campaign_rounded,
                    color: color,
                    size: 26,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            alert.severity.toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: color,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                        if (!alert.isRead) ...[
                          const SizedBox(width: 8),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      alert.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: alert.isRead
                            ? FontWeight.w500
                            : FontWeight.w600,
                        color: AppColors.textPrimary,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      alert.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      DateFormat('dd MMM, hh:mm a')
                          .format(alert.generatedAt),
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textLight,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
