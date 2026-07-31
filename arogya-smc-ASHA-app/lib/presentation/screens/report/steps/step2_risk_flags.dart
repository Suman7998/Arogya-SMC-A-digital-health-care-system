import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../providers/providers.dart';

class Step2RiskFlagsView extends ConsumerWidget {
  const Step2RiskFlagsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wizardState = ref.watch(reportWizardProvider);
    final maternal = wizardState.maternal;
    final child = wizardState.child;
    final notifier = ref.read(reportWizardProvider.notifier);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            title: 'report.step2'.tr(),
            subtitle: 'Mark any identified health risks',
            icon: Icons.warning_amber_rounded,
          ),
          const SizedBox(height: 20),
          
          // Maternal Risk Flags
          _GroupHeader(title: '🤰 Maternal Risk Flags', color: const Color(0xFF7B1FA2)),
          const SizedBox(height: 12),
          _ToggleCard(
            label: 'report.high_risk_pregnancy'.tr(),
            value: maternal.highRiskPregnancy,
            color: const Color(0xFFD32F2F),
            onChanged: (v) => notifier.updateMaternal(
              maternal.copyWith(highRiskPregnancy: v),
            ),
          ),
          _ToggleCard(
            label: 'report.post_natal_complications'.tr(),
            value: maternal.postnatalComplications,
            color: const Color(0xFF7B1FA2),
            onChanged: (v) => notifier.updateMaternal(
              maternal.copyWith(postnatalComplications: v),
            ),
          ),
          _ToggleCard(
            label: 'report.no_anc_visit'.tr(),
            value: maternal.noAncVisit,
            color: const Color(0xFFE65100),
            onChanged: (v) => notifier.updateMaternal(
              maternal.copyWith(noAncVisit: v),
            ),
          ),

          const SizedBox(height: 24),

          // Child Risk Flags
          _GroupHeader(title: '👶 Child Risk Flags', color: const Color(0xFF1565C0)),
          const SizedBox(height: 12),
          _ToggleCard(
            label: 'report.malnourished'.tr(),
            value: child.malnourished,
            color: const Color(0xFFD32F2F),
            onChanged: (v) => notifier.updateChild(
              child.copyWith(malnourished: v),
            ),
          ),
          _ToggleCard(
            label: 'report.immunization_overdue'.tr(),
            value: child.immunizationOverdue,
            color: const Color(0xFFFF8F00),
            onChanged: (v) => notifier.updateChild(
              child.copyWith(immunizationOverdue: v),
            ),
          ),
          _ToggleCard(
            label: 'report.sick_child'.tr(),
            value: child.sickChild,
            color: const Color(0xFF1565C0),
            onChanged: (v) => notifier.updateChild(
              child.copyWith(sickChild: v),
            ),
          ),
          
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _GroupHeader extends StatelessWidget {
  final String title;
  final Color color;

  const _GroupHeader({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ToggleCard extends StatelessWidget {
  final String label;
  final bool value;
  final Color color;
  final ValueChanged<bool> onChanged;

  const _ToggleCard({
    required this.label,
    required this.value,
    required this.color,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: value ? color.withOpacity(0.04) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: value ? color : Colors.grey.shade100,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: value ? color.withOpacity(0.1) : Colors.grey[50],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.warning_amber_rounded,
                color: value ? color : Colors.grey[400],
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: value ? FontWeight.bold : FontWeight.w600,
                  color: value ? color : AppColors.textPrimary,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            Switch.adaptive(
              value: value,
              activeColor: color,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _SectionHeader({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: AppColors.primary, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
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
