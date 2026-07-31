// lib/views/hospitals/hospitals_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../providers/hospital_provider.dart';
import '../../widgets/hospital_card.dart';
import '../../widgets/app_loading_indicator.dart';
import '../../widgets/app_error_widget.dart';

class HospitalsScreen extends ConsumerStatefulWidget {
  const HospitalsScreen({super.key});

  @override
  ConsumerState<HospitalsScreen> createState() => _HospitalsScreenState();
}

class _HospitalsScreenState extends ConsumerState<HospitalsScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredAsync = ref.watch(filteredHospitalsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Hospitals'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => ref.read(hospitalListProvider.notifier).refresh(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: TextField(
              controller: _searchController,
              onChanged: (v) =>
                  ref.read(hospitalSearchQueryProvider.notifier).state = v,
              decoration: const InputDecoration(
                hintText: 'Search by name, ward or type...',
                prefixIcon: Icon(Icons.search_rounded, color: AppColors.textHint),
              ),
            ),
          ),
          // Stats row
          filteredAsync.when(
            data: (hospitals) => Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Row(
                children: [
                  _StatChip(
                    label: '${hospitals.length} Facilities',
                    icon: Icons.local_hospital_rounded,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 8),
                  _StatChip(
                    label:
                        '${hospitals.fold(0, (sum, h) => sum + h.bedsAvailable)} Beds',
                    icon: Icons.bed_rounded,
                    color: AppColors.secondary,
                  ),
                ],
              ),
            ),
            loading: () => const SizedBox.shrink(),
            error: (e, _) => const SizedBox.shrink(),
          ),
          // Hospital list
          Expanded(
            child: filteredAsync.when(
              data: (hospitals) => hospitals.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.search_off_rounded,
                              size: 56, color: AppColors.textHint),
                          const SizedBox(height: 12),
                          Text('No hospitals found',
                              style: Theme.of(context).textTheme.titleMedium),
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        await ref.read(hospitalListProvider.notifier).refresh();
                      },
                      child: ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                        itemCount: hospitals.length,
                        itemBuilder: (ctx, i) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: HospitalCard(hospital: hospitals[i]),
                        ),
                      ),
                    ),
              loading: () => const AppLoadingIndicator(),
              error: (error, _) => AppErrorWidget(
                message: 'Could not load hospitals.',
                onRetry: () => ref.read(hospitalListProvider.notifier).refresh(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  const _StatChip({required this.label, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: color,
                    fontSize: 12,
                  )),
        ],
      ),
    );
  }
}
