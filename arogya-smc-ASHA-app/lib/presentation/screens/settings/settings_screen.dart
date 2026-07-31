import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../providers/providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final worker = ref.watch(currentWorkerProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Professional Profile Header
            if (worker != null) _ProfileHeader(worker: worker),
            
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  _buildSectionLabel('profile.language'.tr().toUpperCase()),
                  Card(
                    child: Column(
                      children: [
                        _LanguageTile(label: 'English', locale: const Locale('en'), context: context),
                        const Divider(height: 1),
                        _LanguageTile(label: 'मराठी (Marathi)', locale: const Locale('mr'), context: context),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  _buildSectionLabel('profile.sync'.tr().toUpperCase()),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.sync_rounded, color: AppColors.primary),
                      title: Text('profile.sync'.tr(), style: const TextStyle(fontFamily: 'Poppins', fontSize: 14)),
                      subtitle: const Text('Sync all offline data now', style: TextStyle(fontFamily: 'Poppins', fontSize: 12)),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () async {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Syncing started...')),
                        );
                        await ref.read(syncNotifierProvider.notifier).syncNow();
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Sync completed')),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildSectionLabel('profile.settings'.tr().toUpperCase()),
                  Card(
                    child: Column(
                      children: [
                        _InfoTile('App Name', AppConstants.appName),
                        const Divider(height: 1),
                        _InfoTile('Version', '${AppConstants.version} (${AppConstants.buildNumber})'),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.info_outline_rounded, color: AppColors.primary),
                          title: Text('profile.about'.tr(), style: const TextStyle(fontFamily: 'Poppins', fontSize: 14)),
                          trailing: const Icon(Icons.chevron_right_rounded),
                          onTap: () => _showAboutDialog(context),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => _confirmLogout(context, ref),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: AppColors.danger.withAlpha(13),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.danger.withAlpha(51)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.logout_rounded, color: AppColors.danger),
                            const SizedBox(width: 12),
                            Text(
                              'settings.logout'.tr(),
                              style: const TextStyle(
                                color: AppColors.danger,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppColors.textSecondary,
          letterSpacing: 1.2,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Text('🏥', style: TextStyle(fontSize: 28)),
            SizedBox(width: 10),
            Text(
              'Arogya SMC',
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700),
            ),
          ],
        ),
        content: const Text(
          'Arogya SMC is a digital health monitoring system for ASHA workers in Solapur Municipal Corporation.\n\n'
          'This app enables field workers to collect and report daily health data including syndromic surveillance, '
          'maternal health, child health, and environmental risks.\n\n'
          'Version: 1.0.0\nDeveloped for: SMC Health Department',
          style: TextStyle(fontFamily: 'Poppins', fontSize: 14, height: 1.5),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(100, 44),
            ),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _confirmLogout(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Logout',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700),
        ),
        content: const Text(
          'Are you sure you want to logout?',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.danger,
              minimumSize: const Size(100, 44),
            ),
            onPressed: () async {
              await ref.read(authNotifierProvider.notifier).logout();
              if (context.mounted) {
                Navigator.pop(context);
                context.go(AppRoutes.login);
              }
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final dynamic worker;

  const _ProfileHeader({required this.worker});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 32),
      decoration: const BoxDecoration(
        gradient: AppColors.headerGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black.withAlpha(26), blurRadius: 10)],
            ),
            child: const CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.primaryLighter,
              child: Text('👩‍⚕️', style: TextStyle(fontSize: 40)),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  worker.fullName,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    height: 1.1,
                  ),
                ),
                Text(
                  '@${worker.username}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(204),
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(51),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.location_on_rounded, color: Colors.white, size: 14),
                      const SizedBox(width: 6),
                      Text(
                        worker.wardName,
                        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



class _LanguageTile extends StatelessWidget {
  final String label;
  final Locale locale;
  final BuildContext context;

  const _LanguageTile({
    required this.label,
    required this.locale,
    required this.context,
  });

  @override
  Widget build(BuildContext ctx) {
    final isSelected = context.locale == locale;
    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight:
              isSelected ? FontWeight.w600 : FontWeight.w400,
          color: isSelected ? AppColors.primary : AppColors.textPrimary,
        ),
      ),
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: AppColors.primary)
          : null,
      onTap: () => context.setLocale(locale),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;

  const _InfoTile(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          color: AppColors.textSecondary,
          fontFamily: 'Poppins',
        ),
      ),
      trailing: Text(
        value,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}
