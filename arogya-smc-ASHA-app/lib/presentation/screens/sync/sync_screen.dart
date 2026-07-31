import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_theme.dart';
import '../../providers/providers.dart';
import '../../../data/models/models.dart';

class SyncScreen extends ConsumerWidget {
  const SyncScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syncState = ref.watch(syncNotifierProvider);
    final syncNotifier = ref.read(syncNotifierProvider.notifier);
    final pendingAsync = ref.watch(pendingReportsProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 64, 24, 32),
              decoration: const BoxDecoration(
                gradient: AppColors.headerGradient,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Data Synchronization',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Poppins'),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Sync your offline records to SMC Cloud',
                    style: TextStyle(fontSize: 15, color: Colors.white.withAlpha(230), fontFamily: 'Poppins'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SyncStatusCard(syncState: syncState),
                  const SizedBox(height: 20),
                  _LastSyncInfo(notifier: syncNotifier),
                  const SizedBox(height: 32),
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: syncState == SyncState.syncing ? null : () => syncNotifier.syncNow(),
                      icon: syncState == SyncState.syncing
                          ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                          : const Icon(Icons.cloud_upload_rounded, size: 28),
                      label: Text(
                        syncState == SyncState.syncing ? 'Synchronizing...' : 'Start Cloud Sync',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'PENDING REPORTS',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textSecondary, letterSpacing: 1.2),
                  ),
                  const SizedBox(height: 12),
                  pendingAsync.when(
                    loading: () => const Center(child: Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator())),
                    error: (e, _) => Text('Error: $e'),
                    data: (pending) {
                      if (pending.isEmpty) {
                        return _EmptyPendingCard();
                      }
                      return Column(
                        children: pending.map((r) => _PendingReportTile(report: r)).toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SyncStatusCard extends StatelessWidget {
  final SyncState syncState;

  const _SyncStatusCard({required this.syncState});

  @override
  Widget build(BuildContext context) {
    final configs = {
      SyncState.idle: (
        color: AppColors.normalGreen,
        icon: Icons.check_circle_outline,
        title: 'Ready to Sync',
        subtitle: 'Your data is ready to be synced to the server',
      ),
      SyncState.syncing: (
        color: AppColors.info,
        icon: Icons.sync,
        title: 'Sync.syncing',
        subtitle: 'Uploading your reports to the server...',
      ),
      SyncState.done: (
        color: AppColors.normalGreen,
        icon: Icons.cloud_done_outlined,
        title: 'Sync Complete!',
        subtitle: 'All reports have been synced successfully',
      ),
      SyncState.error: (
        color: AppColors.criticalRed,
        icon: Icons.cloud_off_outlined,
        title: 'Sync Failed',
        subtitle: 'Network unavailable. Will retry when online.',
      ),
    };

    final config = configs[syncState]!;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: config.color.withAlpha(13),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: config.color.withAlpha(51), width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: config.color.withAlpha(26),
              borderRadius: BorderRadius.circular(16),
            ),
            child: syncState == SyncState.syncing
                ? Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: config.color,
                        strokeWidth: 3,
                      ),
                    ),
                  )
                : Icon(config.icon, color: config.color, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  config.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: config.color,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  config.subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: config.color.withAlpha(204),
                    fontFamily: 'Poppins',
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

class _LastSyncInfo extends StatelessWidget {
  final SyncNotifier notifier;

  const _LastSyncInfo({required this.notifier});

  @override
  Widget build(BuildContext context) {
    final last = notifier.lastSynced;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.divider),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: AppColors.primaryLighter, borderRadius: BorderRadius.circular(10)),
          child: const Icon(Icons.history_rounded, color: AppColors.primary, size: 24),
        ),
        title: const Text(
          'Last Session Sync',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Poppins'),
        ),
        trailing: Text(
          last != null ? DateFormat('dd MMM, hh:mm a').format(last) : 'Not Synced Yet',
          style: TextStyle(fontSize: 13, color: last != null ? AppColors.primary : AppColors.textLight, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _EmptyPendingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.normalGreen.withAlpha(15),
        borderRadius: BorderRadius.circular(16),
        border:
            Border.all(color: AppColors.normalGreen.withAlpha(51)),
      ),
      child: Column(
        children: [
          const Text('✅', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 12),
          const Text(
            'All reports are synced!',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.normalGreen,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'No pending reports to sync.',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}

class _PendingReportTile extends StatelessWidget {
  final AshaReport report;

  const _PendingReportTile({required this.report});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd MMM yyyy, hh:mm a').format(report.reportDate);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.warningYellow.withAlpha(31),
            borderRadius: BorderRadius.circular(11),
          ),
          child: const Center(
            child: Icon(Icons.sync_problem,
                color: AppColors.warningYellow),
          ),
        ),
        title: Text(
          'Health Report',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        subtitle: Text(date,
            style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
                fontFamily: 'Poppins')),
        trailing: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.warningYellow.withAlpha(31),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Pending',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.warningYellow,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ),
    );
  }
}
