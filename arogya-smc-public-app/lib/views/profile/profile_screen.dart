// lib/views/profile/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_constants.dart';
import '../../providers/location_provider.dart';
import '../../providers/navigation_provider.dart';
import '../../data/services/local_storage_service.dart';

final _notificationsEnabledProvider = StateProvider<bool>((ref) {
  return LocalStorageService().getNotificationEnabled();
});

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationState = ref.watch(locationProvider);
    final notificationsEnabled = ref.watch(_notificationsEnabledProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Ward Info Card
          _SectionCard(
            children: [
              Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFF97316), Color(0xFFEA580C)],
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.location_on_rounded,
                        color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Your Ward',
                            style: Theme.of(context).textTheme.bodyMedium),
                        const SizedBox(height: 2),
                        Text(
                          locationState.wardInfo?.wardName ?? 'Detecting...',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: AppColors.primary),
                        ),
                        if (locationState.latitude != null)
                          Text(
                            '${locationState.latitude!.toStringAsFixed(4)}, ${locationState.longitude!.toStringAsFixed(4)}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontSize: 11),
                          ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: locationState.isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.refresh_rounded),
                    color: AppColors.primary,
                    onPressed: locationState.isLoading
                        ? null
                        : () =>
                            ref.read(locationProvider.notifier).detectLocation(),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Notifications
          _SectionCard(
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: const Icon(Icons.notifications_outlined,
                        color: AppColors.secondary),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Health Alerts',
                            style: Theme.of(context).textTheme.titleMedium),
                        Text('Receive dengue, flu & public health alerts',
                            style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                  ),
                  Switch(
                    value: notificationsEnabled,
                    activeThumbColor: AppColors.primary,
                    onChanged: (v) async {
                      ref
                          .read(_notificationsEnabledProvider.notifier)
                          .state = v;
                      await LocalStorageService().saveNotificationEnabled(v);
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // App Info Section
          Text('About', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 10),
          _SectionCard(
            children: [
              _InfoTile(
                icon: Icons.info_outline_rounded,
                label: 'App Name',
                value: AppConstants.appName,
              ),
              const Divider(height: 16),
              _InfoTile(
                icon: Icons.business_rounded,
                label: 'Issued By',
                value: AppConstants.corporationName,
              ),
              const Divider(height: 16),
              _InfoTile(
                icon: Icons.code_rounded,
                label: 'Version',
                value: AppConstants.appVersion,
              ),
              const Divider(height: 16),
              _InfoTile(
                icon: Icons.phone_rounded,
                label: 'SMC Helpline',
                value: '0217-2720100',
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Quick Links
          Text('Quick Links', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 10),
          _SectionCard(
            children: [
              _ActionTile(
                icon: Icons.local_hospital_rounded,
                label: 'View Hospitals',
                color: AppColors.primary,
                onTap: () {
                  ref.read(navigationIndexProvider.notifier).state = 1;
                  context.go('/hospitals');
                },
              ),
              const Divider(height: 16),
              _ActionTile(
                icon: Icons.campaign_rounded,
                label: 'Health Alerts',
                color: AppColors.alertDengue,
                onTap: () {
                  ref.read(navigationIndexProvider.notifier).state = 2;
                  context.go('/alerts');
                },
              ),
              const Divider(height: 16),
              _ActionTile(
                icon: Icons.emergency_rounded,
                label: 'Emergency: 108',
                color: AppColors.error,
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Footer
          Center(
            child: Text(
              '© 2026 Solapur Municipal Corporation\nAll rights reserved.',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 11),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final List<Widget> children;
  const _SectionCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoTile({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.textSecondary),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: Theme.of(context).textTheme.bodyMedium),
              Text(value, style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _ActionTile({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.titleMedium),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.textHint),
        ],
      ),
    );
  }
}
