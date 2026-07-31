import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../providers/providers.dart';

class Step4ReviewView extends ConsumerWidget {
  const Step4ReviewView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wizardState = ref.watch(reportWizardProvider);
    final notifier = ref.read(reportWizardProvider.notifier);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1B5E20).withOpacity(0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.fact_check_rounded, color: Colors.white, size: 36),
                ),
                const SizedBox(width: 20),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Review Report',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Finalize clinical details',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white70,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Syndromic Summary
          _ReviewSection(
            title: 'Syndromic Data',
            emoji: '🤒',
            color: const Color(0xFFF44336),
            rows: [
              _ReviewRow(
                  'Fever', wizardState.syndromic.feverCount.toString()),
              _ReviewRow(
                  'Cough', wizardState.syndromic.coughCount.toString()),
              _ReviewRow('Diarrhea',
                  wizardState.syndromic.diarrheaCount.toString()),
              _ReviewRow('Jaundice',
                  wizardState.syndromic.jaundiceCount.toString()),
              _ReviewRow('Rash Cases',
                  wizardState.syndromic.rashCount.toString()),
              _ReviewRow('Total Cases',
                  wizardState.syndromic.totalCases.toString(),
                  isHighlight: true),
            ],
          ),
          const SizedBox(height: 12),

          // Maternal Summary
          _ReviewSection(
            title: 'Maternal Health',
            emoji: '🤰',
            color: const Color(0xFF7B1FA2),
            rows: [
              _ReviewRow('High Risk Pregnancy',
                  wizardState.maternal.highRiskPregnancy ? '⚠️ Yes' : '✅ No',
                  isWarning: wizardState.maternal.highRiskPregnancy),
              _ReviewRow('Post-natal Complications',
                  wizardState.maternal.postnatalComplications ? '⚠️ Yes' : '✅ No',
                  isWarning: wizardState.maternal.postnatalComplications),
              _ReviewRow('No ANC Visit',
                  wizardState.maternal.noAncVisit ? '⚠️ Yes' : '✅ No',
                  isWarning: wizardState.maternal.noAncVisit),
            ],
          ),
          const SizedBox(height: 12),

          // Child Summary
          _ReviewSection(
            title: 'Child Health',
            emoji: '👶',
            color: const Color(0xFF1565C0),
            rows: [
              _ReviewRow('Malnourished',
                  wizardState.child.malnourished ? '⚠️ Yes' : '✅ No',
                  isWarning: wizardState.child.malnourished),
              _ReviewRow('Immunization Overdue',
                  wizardState.child.immunizationOverdue ? '⚠️ Yes' : '✅ No',
                  isWarning: wizardState.child.immunizationOverdue),
              _ReviewRow('Sick Child',
                  wizardState.child.sickChild ? '⚠️ Yes' : '✅ No',
                  isWarning: wizardState.child.sickChild),
            ],
          ),
          const SizedBox(height: 12),

          // Environmental Summary
          _ReviewSection(
            title: 'Environmental',
            emoji: '🌿',
            color: const Color(0xFF00695C),
            rows: [
              _ReviewRow('Stagnant Water',
                  wizardState.environmental.stagnantWaterPresent ? '⚠️ Yes' : '✅ No',
                  isWarning: wizardState.environmental.stagnantWaterPresent),
              _ReviewRow('Open Garbage',
                  wizardState.environmental.openGarbage ? '⚠️ Yes' : '✅ No',
                  isWarning: wizardState.environmental.openGarbage),
              _ReviewRow('No Toilet',
                  wizardState.environmental.noToilet ? '⚠️ Yes' : '✅ No',
                  isWarning: wizardState.environmental.noToilet),
              _ReviewRow('Mosquito Breeding',
                  wizardState.environmental.mosquitoBreeding ? '⚠️ Yes' : '✅ No',
                  isWarning: wizardState.environmental.mosquitoBreeding),
            ],
          ),
          const SizedBox(height: 12),

          // Location Summary
          _ReviewSection(
            title: 'Location Information',
            emoji: '📍',
            color: const Color(0xFF1565C0),
            rows: wizardState.location != null
                ? [
                    _ReviewRow(
                      'Ward Area',
                      wizardState.location!.placemark ?? 'Solapur, Maharashtra',
                      isHighlight: true,
                    ),
                    _ReviewRow(
                      'Coordinates',
                      '${wizardState.location!.latitude.toStringAsFixed(4)}, ${wizardState.location!.longitude.toStringAsFixed(4)}',
                    ),
                    _ReviewRow(
                      'Accuracy',
                      '±${wizardState.location!.accuracy.toStringAsFixed(1)} Meters',
                    ),
                  ]
                : [const _ReviewRow('Location', '⚠️ Not captured', isWarning: true)],
          ),
          const SizedBox(height: 12),

          // Photo Preview
          if (wizardState.photoPaths.isNotEmpty)
            _ReviewSection(
              title: 'Photos Attached',
              emoji: '📸',
              color: AppColors.primary,
              rows: [
                _ReviewRow('Total Photos', wizardState.photoPaths.length.toString()),
              ],
            ),
          const SizedBox(height: 24),

          // Error display
          if (wizardState.error != null)
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.criticalRed.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                wizardState.error!,
                style: const TextStyle(
                    color: AppColors.danger,
                    fontFamily: 'Poppins',
                    fontSize: 14),
              ),
            ),

          SizedBox(
            height: 64,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: wizardState.isSubmitting
                  ? null
                  : () async {
                      final success = await notifier.submit();
                      if (success && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                const Icon(Icons.check_circle, color: Colors.white),
                                const SizedBox(width: 12),
                                Text('report.submitted_success'.tr()),
                              ],
                            ),
                            backgroundColor: AppColors.normalGreen,
                            behavior: SnackBarBehavior.floating,
                            margin: const EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                        );
                        notifier.reset();
                        context.go(AppRoutes.dashboard);
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 4,
                shadowColor: AppColors.primary.withOpacity(0.4),
              ),
              child: wizardState.isSubmitting
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                      'report.submit'.tr().toUpperCase(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        letterSpacing: 1.2,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 12),

          // Save Draft Button
          SizedBox(
            height: 54,
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: wizardState.isSubmitting
                  ? null
                  : () async {
                      final success = await notifier.saveDraft();
                      if (success && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Draft saved successfully'),
                            backgroundColor: AppColors.info,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        );
                        notifier.reset();
                        context.go(AppRoutes.dashboard);
                      }
                    },
              icon: const Icon(Icons.save_outlined),
              label: Text('report.save_draft'.tr(),
                  style: const TextStyle(fontFamily: 'Poppins')),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class _ReviewSection extends StatelessWidget {
  final String title;
  final String emoji;
  final Color color;
  final List<_ReviewRow> rows;

  const _ReviewSection({
    required this.title,
    required this.emoji,
    required this.color,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(emoji, style: const TextStyle(fontSize: 20)),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: rows,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isHighlight;
  final bool isWarning;

  const _ReviewRow(
    this.label,
    this.value, {
    this.isHighlight = false,
    this.isWarning = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              fontFamily: 'Poppins',
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isHighlight ? 16 : 14,
              fontWeight: isHighlight
                  ? FontWeight.w700
                  : FontWeight.w600,
              color: isWarning
                  ? AppColors.warningYellow
                  : isHighlight
                      ? AppColors.primary
                      : AppColors.textPrimary,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
