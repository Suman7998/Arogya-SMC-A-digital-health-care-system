// lib/widgets/alert_card.dart

import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../data/models/alert_model.dart';

class AlertCard extends StatelessWidget {
  final AlertModel alert;
  final bool expanded;
  const AlertCard({super.key, required this.alert, this.expanded = false});

  Color _typeColor() {
    switch (alert.type) {
      case AlertType.dengue:
        return AppColors.alertDengue;
      case AlertType.flu:
        return AppColors.alertFlu;
      case AlertType.vaccination:
        return AppColors.alertVaccination;
      case AlertType.general:
        return AppColors.alertGeneral;
    }
  }

  IconData _typeIcon() {
    switch (alert.type) {
      case AlertType.dengue:
        return Icons.bug_report_rounded;
      case AlertType.flu:
        return Icons.sick_rounded;
      case AlertType.vaccination:
        return Icons.vaccines_rounded;
      case AlertType.general:
        return Icons.info_outline_rounded;
    }
  }

  String _typeLabel() {
    switch (alert.type) {
      case AlertType.dengue:
        return 'Dengue';
      case AlertType.flu:
        return 'Flu';
      case AlertType.vaccination:
        return 'Vaccination';
      case AlertType.general:
        return 'General';
    }
  }

  Color _severityColor() {
    switch (alert.severity) {
      case AlertSeverity.high:
        return AppColors.error;
      case AlertSeverity.medium:
        return AppColors.warning;
      case AlertSeverity.low:
        return AppColors.success;
    }
  }

  String _severityLabel() {
    switch (alert.severity) {
      case AlertSeverity.high:
        return 'High';
      case AlertSeverity.medium:
        return 'Medium';
      case AlertSeverity.low:
        return 'Low';
    }
  }

  @override
  Widget build(BuildContext context) {
    final typeColor = _typeColor();
    final severityColor = _severityColor();
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: typeColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(_typeIcon(), color: typeColor, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            color: typeColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            _typeLabel(),
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(color: typeColor, fontSize: 10),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            color: severityColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '${_severityLabel()} Risk',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(color: severityColor, fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      alert.title,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: expanded ? null : 1,
                      overflow: expanded ? null : TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (expanded) ...[
            const SizedBox(height: 10),
            Text(
              alert.description,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
            ),
          ],
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.calendar_today_rounded,
                  size: 12, color: AppColors.textHint),
              const SizedBox(width: 4),
              Text(
                _formatDate(alert.date),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 11),
              ),
              const Spacer(),
              Text(
                alert.issuedBy,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day} ${months[date.month]} ${date.year}';
  }
}
