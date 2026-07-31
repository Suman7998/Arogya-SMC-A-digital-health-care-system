// lib/views/home/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../providers/alert_provider.dart';
import '../../providers/location_provider.dart';
import '../../widgets/announcement_carousel.dart';
import '../../widgets/quick_access_card.dart';
import '../../widgets/alert_card.dart';
import '../../widgets/section_header.dart';
import '../../widgets/app_loading_indicator.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(locationProvider.notifier).detectLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    final locationState = ref.watch(locationProvider);
    final advisoriesAsync = ref.watch(advisoriesProvider);
    final alertsAsync = ref.watch(alertListProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            floating: true,
            pinned: false,
            title: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.health_and_safety_rounded,
                      color: Colors.white, size: 20),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Arogya SMC',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      locationState.wardInfo?.wardName ?? 'Detecting ward...',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 11,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {},
              ),
            ],
          ),

          // Advisory Carousel
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: advisoriesAsync.when(
                data: (advisories) => advisories.isNotEmpty
                    ? AnnouncementCarousel(advisories: advisories)
                    : const SizedBox.shrink(),
                loading: () => Container(
                  height: 160,
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const AppLoadingIndicator(),
                ),
                error: (_, _) => const SizedBox.shrink(),
              ),
            ),
          ),

          // Quick Access Grid
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
              child: SectionHeader(
                title: 'Quick Access',
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.55,
              ),
              delegate: SliverChildListDelegate([
                QuickAccessCard(
                  icon: Icons.local_hospital_rounded,
                  label: 'Hospitals',
                  subtitle: 'Find & check beds',
                  gradientColors: const [Color(0xFFF97316), Color(0xFFEA580C)],
                  onTap: () => context.go('/hospitals'),
                ),
                QuickAccessCard(
                  icon: Icons.campaign_rounded,
                  label: 'Health Alerts',
                  subtitle: 'Advisories & warnings',
                  gradientColors: const [Color(0xFF7C3AED), Color(0xFFA855F7)],
                  onTap: () => context.go('/alerts'),
                ),
                QuickAccessCard(
                  icon: Icons.card_membership_rounded,
                  label: 'Medical Schemes',
                  subtitle: 'Gov. welfare programs',
                  gradientColors: const [Color(0xFF0F766E), Color(0xFF14B8A6)],
                  onTap: () => _showSchemesDialog(context),
                ),
                QuickAccessCard(
                  icon: Icons.emergency_rounded,
                  label: 'Emergency',
                  subtitle: 'Helplines & contacts',
                  gradientColors: const [Color(0xFFDC2626), Color(0xFFF87171)],
                  onTap: () => _showEmergencyDialog(context),
                ),
              ]),
            ),
          ),

          // Recent Alerts Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
              child: SectionHeader(
                title: 'Recent Health Updates',
                actionLabel: 'See all',
                onAction: () => context.go('/alerts'),
              ),
            ),
          ),

          alertsAsync.when(
            data: (alerts) => SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (ctx, i) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: AlertCard(alert: alerts[i]),
                  ),
                  childCount: alerts.length > 3 ? 3 : alerts.length,
                ),
              ),
            ),
            loading: () => const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: AppLoadingIndicator(),
              ),
            ),
            error: (error, stack) => SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: _ErrorBanner(
                  message: 'Could not load alerts.',
                  onRetry: () => ref.invalidate(alertListProvider),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEmergencyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.emergency_rounded, color: AppColors.error),
            const SizedBox(width: 8),
            Text('Emergency Contacts',
                style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _EmergencyTile('Police', '100', Icons.local_police_rounded),
            _EmergencyTile('Ambulance', '108', Icons.local_shipping_rounded),
            _EmergencyTile('Fire', '101', Icons.local_fire_department_rounded),
            _EmergencyTile(
                'SMC Helpline', '0217-2720100', Icons.local_hospital_rounded),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showSchemesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Government Health Schemes'),
        content: const Text(
          '1. Ayushman Bharat – Free treatment up to ₹5 lakh.\n'
          '2. Mahatma Jyotiba Phule Jan Arogya Yojana – Cashless treatment.\n'
          '3. Pradhan Mantri Matru Vandana Yojana – Maternity benefit.\n\n'
          'Visit SMC health office for more details.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorBanner({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.wifi_off_rounded, color: AppColors.error, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(message,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.error)),
          ),
          TextButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

class _EmergencyTile extends StatelessWidget {
  final String label;
  final String number;
  final IconData icon;
  const _EmergencyTile(this.label, this.number, this.icon);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: AppColors.error.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.error, size: 20),
      ),
      title: Text(label, style: Theme.of(context).textTheme.titleMedium),
      trailing: Text(
          number,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              )),
    );
  }
}
