// lib/widgets/hospital_card.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/theme/app_theme.dart';
import '../data/models/hospital_model.dart';

class HospitalCard extends StatelessWidget {
  final HospitalModel hospital;
  const HospitalCard({super.key, required this.hospital});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/hospitals/${hospital.id}'),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.divider),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.local_hospital_rounded,
                      color: AppColors.primary, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hospital.name,
                        style: Theme.of(context).textTheme.titleLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        hospital.ward,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                _TypeBadge(type: hospital.type),
              ],
            ),
            const SizedBox(height: 14),
            // Availability chips
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: [
                _AvailChip(
                  icon: Icons.bed_rounded,
                  label: '${hospital.bedsAvailable} Beds',
                  available: hospital.bedsAvailable > 0,
                ),
                _AvailChip(
                  icon: Icons.monitor_heart_rounded,
                  label: 'ICU',
                  available: hospital.icuAvailable,
                ),
                _AvailChip(
                  icon: Icons.air_rounded,
                  label: 'Vent.',
                  available: hospital.ventilatorsAvailable,
                ),
                _AvailChip(
                  icon: Icons.bubble_chart_rounded,
                  label: 'O₂',
                  available: hospital.oxygenAvailable,
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Footer row
            Row(
              children: [
                const Icon(Icons.phone_rounded,
                    size: 13, color: AppColors.textSecondary),
                const SizedBox(width: 4),
                Text(hospital.phone,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 12)),
                const Spacer(),
                Text(
                  'View details',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.primary,
                        fontSize: 12,
                      ),
                ),
                const Icon(Icons.chevron_right_rounded,
                    size: 16, color: AppColors.primary),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TypeBadge extends StatelessWidget {
  final String type;
  const _TypeBadge({required this.type});

  Color get _color {
    switch (type) {
      case 'Government':
        return AppColors.secondary;
      case 'PHC':
        return AppColors.info;
      default:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        type,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: _color,
              fontSize: 10,
            ),
      ),
    );
  }
}

class _AvailChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool available;
  const _AvailChip({required this.icon, required this.label, required this.available});

  @override
  Widget build(BuildContext context) {
    final color = available ? AppColors.success : AppColors.error;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                ),
          ),
        ],
      ),
    );
  }
}
