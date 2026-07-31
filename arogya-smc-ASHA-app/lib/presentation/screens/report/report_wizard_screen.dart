import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../providers/providers.dart';
import 'steps/step1_syndromic.dart';
import 'steps/step2_risk_flags.dart';
import 'steps/step3_location.dart';
import 'steps/step4_review.dart';

class ReportWizardScreen extends ConsumerStatefulWidget {
  const ReportWizardScreen({super.key});

  @override
  ConsumerState<ReportWizardScreen> createState() => _ReportWizardScreenState();
}

class _ReportWizardScreenState extends ConsumerState<ReportWizardScreen> {
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    final state = ref.read(reportWizardProvider);
    if (state.currentStep < 3) {
      ref.read(reportWizardProvider.notifier).nextStep();
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _prevPage() {
    final state = ref.read(reportWizardProvider);
    if (state.currentStep > 0) {
      ref.read(reportWizardProvider.notifier).prevStep();
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.go(AppRoutes.dashboard);
    }
  }

  @override
  Widget build(BuildContext context) {
    final wizardState = ref.watch(reportWizardProvider);
    final step = wizardState.currentStep;

    final stepLabels = [
      'report.step1'.tr(),
      'report.step2'.tr(),
      'report.step3'.tr(),
      'report.step4'.tr(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textPrimary,
        title: Text(
          'report.new_report'.tr(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.go(AppRoutes.dashboard),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                'Step ${step + 1} of 4',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Step Progress Indicator
          Container(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: List.generate(4, (i) {
                    final isActive = i == step;
                    final isDone = i < step;
                    return Expanded(
                      child: Container(
                        height: 6,
                        margin: EdgeInsets.only(right: i == 3 ? 0 : 6),
                        decoration: BoxDecoration(
                          color: isDone 
                              ? AppColors.normalGreen 
                              : isActive ? AppColors.primary : Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      _getStepIcon(step),
                      size: 20,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      stepLabels[step],
                      style: const TextStyle(
                        fontSize: 15,
                        color: AppColors.textPrimary,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Page content
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                Step1SyndromicView(),
                Step2RiskFlagsView(),
                Step3LocationView(),
                Step4ReviewView(),
              ],
            ),
          ),

          // Navigation Buttons
          Container(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 36),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              children: [
                if (step > 0) ...[
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _prevPage,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text(
                        'report.previous'.tr(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
                Expanded(
                  flex: step > 0 ? 2 : 1,
                  child: ElevatedButton(
                    onPressed: step == 3 ? _submitReport : _nextPage, // Changed to 3 for 4 steps
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: Text(
                      step == 3 ? 'report.submit'.tr() : 'report.next'.tr(), // Changed to 3 and 'report.submit'.tr()
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getStepIcon(int step) {
    switch (step) {
      case 0: return Icons.personal_injury_outlined;
      case 1: return Icons.warning_amber_rounded;
      case 2: return Icons.location_on_outlined;
      case 3: return Icons.fact_check_outlined;
      default: return Icons.circle; // Default for out-of-bounds steps
    }
  }

  Future<void> _submitReport() async {
    final worker = ref.read(currentWorkerProvider);
    if (worker == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('common.error'.tr(), style: const TextStyle(fontFamily: 'Poppins'))),
      );
      return;
    }

    final wizardState = ref.read(reportWizardProvider);
    final loc = wizardState.location;
    if (loc == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('report.capture_location'.tr(), style: const TextStyle(fontFamily: 'Poppins'))),
      );
      return;
    }

    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      await ref.read(reportRepositoryProvider).saveReport(
        workerId: worker.id,
        workerName: worker.fullName,
        wardCode: loc.placemark ?? 'Unknown',
        syndromic: wizardState.syndromic,
        maternal: wizardState.maternal,
        child: wizardState.child,
        environmental: wizardState.environmental,
        location: loc,
        photoPaths: wizardState.photoPaths,
      );

      if (mounted) {
        Navigator.pop(context); // close dialog
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('report.submitted_success'.tr(), style: const TextStyle(fontFamily: 'Poppins')), backgroundColor: AppColors.success),
        );
        ref.read(reportWizardProvider.notifier).reset();
        Navigator.pop(context); // close wizard
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context); // close dialog
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${'common.error'.tr()}: $e', style: const TextStyle(fontFamily: 'Poppins')), backgroundColor: AppColors.danger),
        );
      }
    }
  }
}
