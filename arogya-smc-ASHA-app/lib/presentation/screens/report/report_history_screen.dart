import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_theme.dart';
import '../../providers/providers.dart';
import '../../../data/models/models.dart';

class ReportHistoryScreen extends ConsumerWidget {
  const ReportHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportsAsync = ref.watch(allReportsProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Report History'),
      ),
      body: reportsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (reports) {
          if (reports.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('📋', style: TextStyle(fontSize: 64)),
                  const SizedBox(height: 16),
                  const Text(
                    'No reports found',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.textSecondary,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: reports.length,
            itemBuilder: (ctx, i) {
              final r = reports[i];
              return _ReportHistoryCard(report: r);
            },
          );
        },
      ),
    );
  }
}

class _ReportHistoryCard extends StatelessWidget {
  final AshaReport report;

  const _ReportHistoryCard({required this.report});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd MMM yyyy').format(report.reportDate);
    final time = DateFormat('hh:mm a').format(report.reportDate);

    final syncColor = report.isSynced
        ? AppColors.normalGreen
        : report.isPending
            ? AppColors.warningYellow
            : AppColors.criticalRed;
    final syncLabel =
        report.isSynced ? 'Synced' : report.isPending ? 'Pending' : 'Failed';

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ExpansionTile(
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
          date,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        subtitle: Row(
          children: [
            Text(
              time,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: syncColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                syncLabel,
                style: TextStyle(
                  fontSize: 10,
                  color: syncColor,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                _SectionRow('Fever', report.syndromic.feverCount),
                _SectionRow('Cough', report.syndromic.coughCount),
                _SectionRow('Diarrhea', report.syndromic.diarrheaCount),
                _SectionRow('Jaundice', report.syndromic.jaundiceCount),
                const Divider(),
                _TextRow(
                    'High Risk Pregnancy', report.maternal.highRiskPregnancy ? 'Yes' : 'No'),
                _TextRow(
                    'Post-natal Complications', report.maternal.postnatalComplications ? 'Yes' : 'No'),
                const Divider(),
                _TextRow(
                    'Malnourished', report.child.malnourished ? 'Yes' : 'No'),
                _TextRow(
                    'Sick Child', report.child.sickChild ? 'Yes' : 'No'),
                if (report.location != null) ...[
                  const Divider(),
                  _TextRow('Location',
                      '${report.location!.latitude.toStringAsFixed(4)}, ${report.location!.longitude.toStringAsFixed(4)}'),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionRow extends StatelessWidget {
  final String label;
  final int value;

  const _SectionRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
              fontFamily: 'Poppins',
            ),
          ),
          Text(
            '$value',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: value > 0 ? AppColors.primary : AppColors.textLight,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}

class _TextRow extends StatelessWidget {
  final String label;
  final String value;

  const _TextRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
              fontFamily: 'Poppins',
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
