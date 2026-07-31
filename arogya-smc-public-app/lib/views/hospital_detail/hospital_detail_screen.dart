// lib/views/hospital_detail/hospital_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/hospital_model.dart';
import '../../data/repositories/hospital_repository.dart';
import '../../widgets/app_loading_indicator.dart';

final _hospitalDetailProvider =
    FutureProvider.family<HospitalModel?, String>((ref, id) async {
  final repo = HospitalRepository();
  return repo.getHospitalById(id);
});

class HospitalDetailScreen extends ConsumerWidget {
  final String hospitalId;
  const HospitalDetailScreen({super.key, required this.hospitalId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hospitalAsync = ref.watch(_hospitalDetailProvider(hospitalId));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: hospitalAsync.when(
        data: (hospital) {
          if (hospital == null) {
            return const Center(child: Text('Hospital not found.'));
          }
          return _HospitalDetailBody(hospital: hospital);
        },
        loading: () => const AppLoadingIndicator(),
        error: (e, _) => const Center(child: Text('Error loading details.')),
      ),
    );
  }
}

class _HospitalDetailBody extends StatelessWidget {
  final HospitalModel hospital;
  const _HospitalDetailBody({required this.hospital});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Header
        SliverAppBar(
          expandedHeight: 200,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFF97316), Color(0xFFEA580C)],
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(80, 20, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          hospital.type,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        hospital.name,
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on_rounded,
                              color: Colors.white70, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            hospital.ward,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          backgroundColor: AppColors.primary,
          iconTheme: const IconThemeData(color: Colors.white),
        ),

        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Availability cards
              Text('Availability',
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _AvailCard(
                      label: 'Beds',
                      value: '${hospital.bedsAvailable}/${hospital.bedsTotal}',
                      available: hospital.bedsAvailable > 0,
                      icon: Icons.bed_rounded,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _AvailCard(
                      label: 'ICU',
                      value: hospital.icuAvailable
                          ? '${hospital.icuBeds} beds'
                          : 'Not Available',
                      available: hospital.icuAvailable,
                      icon: Icons.monitor_heart_rounded,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _AvailCard(
                      label: 'Ventilators',
                      value: hospital.ventilatorsAvailable
                          ? '${hospital.ventilators} units'
                          : 'Not Available',
                      available: hospital.ventilatorsAvailable,
                      icon: Icons.air_rounded,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _AvailCard(
                      label: 'Oxygen',
                      value: hospital.oxygenAvailable
                          ? 'Available'
                          : 'Not Available',
                      available: hospital.oxygenAvailable,
                      icon: Icons.bubble_chart_rounded,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Contact
              Text('Contact',
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 12),
              _InfoCard(
                children: [
                  _InfoRow(
                    icon: Icons.location_on_rounded,
                    label: 'Address',
                    value: hospital.address,
                  ),
                  const Divider(height: 20),
                  _InfoRow(
                    icon: Icons.phone_rounded,
                    label: 'Phone',
                    value: hospital.phone,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.phone_rounded),
                  label: Text('Call ${hospital.phone}'),
                  onPressed: () async {
                    final url = Uri(scheme: 'tel', path: hospital.phone);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Could not launch dialer')),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Departments
              Text('Departments',
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: hospital.departments
                    .map(
                      (dept) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: AppColors.secondary.withValues(alpha: 0.3)),
                        ),
                        child: Text(
                          dept,
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: AppColors.secondary,
                                fontSize: 12,
                              ),
                        ),
                      ),
                    )
                    .toList(),
              ),

              const SizedBox(height: 24),

              // Doctors
              Text('Doctors on Duty',
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 12),
              ...hospital.doctors.map(
                (doctor) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _InfoCard(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: AppColors.primaryLight,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.person_rounded,
                                color: AppColors.primary),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(doctor.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                                Text(doctor.specialization,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.secondary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              doctor.timings,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    color: AppColors.secondary,
                                    fontSize: 11,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ]),
          ),
        ),
      ],
    );
  }
}

class _AvailCard extends StatelessWidget {
  final String label;
  final String value;
  final bool available;
  final IconData icon;
  const _AvailCard({
    required this.label,
    required this.value,
    required this.available,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final color = available ? AppColors.success : AppColors.error;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(width: 6),
              Text(label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      )),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: color, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final List<Widget> children;
  const _InfoCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: AppColors.textSecondary),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 2),
              Text(value, style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
      ],
    );
  }
}
