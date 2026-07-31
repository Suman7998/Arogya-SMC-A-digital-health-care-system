// lib/views/alerts/alerts_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/alert_model.dart';
import '../../providers/alert_provider.dart';
import '../../widgets/alert_card.dart';
import '../../widgets/app_loading_indicator.dart';
import '../../widgets/app_error_widget.dart';

class AlertsScreen extends ConsumerWidget {
  const AlertsScreen({super.key});

  static const _filterOptions = [
    (label: 'All', type: null),
    (label: 'Dengue', type: AlertType.dengue),
    (label: 'Flu', type: AlertType.flu),
    (label: 'Vaccination', type: AlertType.vaccination),
    (label: 'General', type: AlertType.general),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFilter = ref.watch(alertFilterProvider);
    final filteredAsync = ref.watch(filteredAlertsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Health Alerts'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter chips
          SizedBox(
            height: 52,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              scrollDirection: Axis.horizontal,
              itemCount: _filterOptions.length,
              separatorBuilder: (_, s) => const SizedBox(width: 8),
              itemBuilder: (ctx, i) {
                final option = _filterOptions[i];
                final isSelected = selectedFilter == option.type;
                return FilterChip(
                  label: Text(option.label),
                  selected: isSelected,
                  onSelected: (_) => ref
                      .read(alertFilterProvider.notifier)
                      .state = option.type,
                  selectedColor: AppColors.primaryLight,
                  checkmarkColor: AppColors.primary,
                  labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.textSecondary,
                        fontSize: 12,
                      ),
                );
              },
            ),
          ),
          // Alert list
          Expanded(
            child: filteredAsync.when(
              data: (alerts) => alerts.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.check_circle_outline_rounded,
                              size: 56, color: AppColors.success),
                          const SizedBox(height: 12),
                          Text('No alerts in this category',
                              style: Theme.of(context).textTheme.titleMedium),
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        await ref.read(alertListProvider.notifier).refresh();
                      },
                      child: ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                        itemCount: alerts.length,
                        itemBuilder: (ctx, i) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: AlertCard(alert: alerts[i], expanded: true),
                        ),
                      ),
                    ),
              loading: () => const AppLoadingIndicator(),
              error: (e, _) => AppErrorWidget(
                message: 'Could not load alerts.',
                onRetry: () => ref.read(alertListProvider.notifier).refresh(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
