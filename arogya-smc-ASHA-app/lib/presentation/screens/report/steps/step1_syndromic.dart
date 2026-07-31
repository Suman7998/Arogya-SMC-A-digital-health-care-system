import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../providers/providers.dart';
import '../../../../data/models/models.dart';

class Step1SyndromicView extends ConsumerWidget {
  const Step1SyndromicView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wizard = ref.watch(reportWizardProvider);
    final syndromic = wizard.syndromic;
    final notifier = ref.read(reportWizardProvider.notifier);
    final wardsAsync = ref.watch(wardsProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            title: 'report.step1'.tr(),
            subtitle: 'Select ward and enter observed cases',
            icon: Icons.personal_injury_outlined,
          ),
          const SizedBox(height: 20),
          // Ward Selection Dropdown
          wardsAsync.when(
            data: (wards) => Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: wizard.wardCode,
                    isExpanded: true,
                    hint: const Text('Select Patient Ward'),
                    icon: const Icon(Icons.location_city_rounded, color: AppColors.primary),
                    items: wards.map((w) => DropdownMenuItem(
                      value: w['code'],
                      child: Text(w['name']!, style: const TextStyle(fontFamily: 'Poppins')),
                    )).toList(),
                    onChanged: (code) {
                      if (code != null) notifier.updateWard(code);
                    },
                  ),
                ),
              ),
            ),
            loading: () => const LinearProgressIndicator(),
            error: (_, __) => const Text('Could not load wards'),
          ),
          const SizedBox(height: 24),
          _CounterCard(
            label: 'report.fever'.tr(),
            emoji: '🌡️',
            value: syndromic.feverCount,
            color: const Color(0xFFF44336),
            onChanged: (v) => notifier.updateSyndromic(
              syndromic.copyWith(feverCount: v),
            ),
          ),
          _CounterCard(
            label: 'report.cough'.tr(),
            emoji: '😷',
            value: syndromic.coughCount,
            color: const Color(0xFFFF9800),
            onChanged: (v) => notifier.updateSyndromic(
              syndromic.copyWith(coughCount: v),
            ),
          ),
          _CounterCard(
            label: 'report.diarrhea'.tr(),
            emoji: '💧',
            value: syndromic.diarrheaCount,
            color: const Color(0xFF2196F3),
            onChanged: (v) => notifier.updateSyndromic(
              syndromic.copyWith(diarrheaCount: v),
            ),
          ),
          _CounterCard(
            label: 'report.jaundice'.tr(),
            emoji: '🟡',
            value: syndromic.jaundiceCount,
            color: const Color(0xFFFFC107),
            onChanged: (v) => notifier.updateSyndromic(
              syndromic.copyWith(jaundiceCount: v),
            ),
          ),
          _CounterCard(
            label: 'report.rash'.tr(),
            emoji: '🔴',
            value: syndromic.rashCount,
            color: const Color(0xFFE91E63),
            onChanged: (v) => notifier.updateSyndromic(
              syndromic.copyWith(rashCount: v),
            ),
          ),
          const SizedBox(height: 16),
          // Custom Disease Cards
          ...syndromic.otherSymptoms.entries.map((entry) {
            return _CounterCard(
              label: entry.key,
              emoji: '🦠',
              value: entry.value,
              color: const Color(0xFF9C27B0),
              onChanged: (v) {
                final newMap = Map<String, int>.from(syndromic.otherSymptoms);
                if (v <= 0) {
                  newMap.remove(entry.key);
                } else {
                  newMap[entry.key] = v;
                }
                notifier.updateSyndromic(syndromic.copyWith(otherSymptoms: newMap));
              },
            );
          }),
          const SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<String>.empty();
                  }
                  final options = ['Dengue', 'Malaria', 'Typhoid', 'Chikungunya', 'Cholera', 'COVID-19', 'TB', 'Measles'];
                  final filtered = options.where((String option) {
                    return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                  }).toList();
                  if (!filtered.any((e) => e.toLowerCase() == textEditingValue.text.toLowerCase())) {
                    filtered.add(textEditingValue.text);
                  }
                  return filtered;
                },
                onSelected: (String selection) {
                  if (selection.isNotEmpty && !syndromic.otherSymptoms.containsKey(selection)) {
                    final newMap = Map<String, int>.from(syndromic.otherSymptoms);
                    newMap[selection] = 1; // Auto increment to 1 on select
                    notifier.updateSyndromic(syndromic.copyWith(otherSymptoms: newMap));
                  }
                },
                fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
                  return TextField(
                    controller: controller,
                    focusNode: focusNode,
                    onSubmitted: (val) {
                      if (val.isNotEmpty && !syndromic.otherSymptoms.containsKey(val)) {
                        final newMap = Map<String, int>.from(syndromic.otherSymptoms);
                        newMap[val] = 1;
                        notifier.updateSyndromic(syndromic.copyWith(otherSymptoms: newMap));
                        controller.clear();
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Add Custom Disease...',
                      hintText: 'e.g. Dengue, Malaria, etc.',
                      border: InputBorder.none,
                      icon: const Icon(Icons.add_circle_outline, color: AppColors.primary),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          if (controller.text.isNotEmpty && !syndromic.otherSymptoms.containsKey(controller.text)) {
                            final newMap = Map<String, int>.from(syndromic.otherSymptoms);
                            newMap[controller.text] = 1;
                            notifier.updateSyndromic(syndromic.copyWith(otherSymptoms: newMap));
                            controller.clear();
                            focusNode.unfocus();
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          _TotalCasesBanner(total: syndromic.totalCases),
        ],
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

class _CounterCard extends StatelessWidget {
  final String label;
  final String emoji;
  final int value;
  final Color color;
  final ValueChanged<int> onChanged;

  const _CounterCard({
    required this.label,
    required this.emoji,
    required this.value,
    required this.color,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: value > 0 ? color.withOpacity(0.5) : Colors.grey.shade200, width: value > 0 ? 1.5 : 1),
        boxShadow: value > 0 ? [BoxShadow(color: color.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))] : null,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(emoji, style: const TextStyle(fontSize: 24)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          // Decrement
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => value > 0 ? onChanged(value - 1) : null,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: value > 0 ? color.withOpacity(0.1) : Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: value > 0 ? color.withOpacity(0.3) : Colors.grey[200]!),
                ),
                child: Icon(
                  Icons.remove,
                  color: value > 0 ? color : Colors.grey[400],
                  size: 20,
                ),
              ),
            ),
          ),
          // Count
          SizedBox(
            width: 44,
            child: Center(
              child: Text(
                '$value',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: value > 0 ? color : AppColors.textLight,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
          // Increment
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => onChanged(value + 1),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: color.withOpacity(0.3)),
                ),
                child: Icon(Icons.add, color: color, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TotalCasesBanner extends StatelessWidget {
  final int total;

  const _TotalCasesBanner({required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2E7D32), Color(0xFF43A047)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Cases Today',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                'All Symptoms',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
          Text(
            '$total',
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
