import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../providers/providers.dart';
import '../../../data/models/models.dart';

class BeneficiaryDetailScreen extends ConsumerWidget {
  final String beneficiaryId;

  const BeneficiaryDetailScreen({super.key, required this.beneficiaryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final beneficiaryAsync = ref.watch(beneficiaryDetailProvider(beneficiaryId));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Beneficiary Profile'),
        actions: [
          IconButton(
            onPressed: () {}, // Edit profile
            icon: const Icon(Icons.edit_outlined),
          ),
        ],
      ),
      body: beneficiaryAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
        data: (beneficiary) {
          if (beneficiary == null) {
            return const Center(child: Text('Beneficiary not found'));
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileHeader(context, beneficiary),
                _buildActionButtons(context, beneficiary),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoSection(context, 'Basic Information', [
                        _DetailRow(label: 'Aadhaar', value: beneficiary.aadhaarNumber ?? 'N/A'),
                        _DetailRow(label: 'Phone', value: beneficiary.phoneNumber ?? 'N/A'),
                        _DetailRow(label: 'Address', value: beneficiary.address),
                        _DetailRow(label: 'Age', value: '${beneficiary.age} Years'),
                        _DetailRow(label: 'Gender', value: beneficiary.gender.toUpperCase()),
                      ]),
                      const SizedBox(height: 24),
                      if (beneficiary.children.isNotEmpty) ...[
                        Text(
                          'Children',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 12),
                        ...beneficiary.children.map((child) => _ChildCard(child: child)),
                        const SizedBox(height: 24),
                      ],
                      _buildHistorySection(context, beneficiary),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, BeneficiaryModel beneficiary) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        gradient: AppColors.dashboardGradient,
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: Text(
              beneficiary.name[0],
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.primary),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            beneficiary.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 4),
          if (beneficiary.pregnancyStatus != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                beneficiary.pregnancyStatusDisplay,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, BeneficiaryModel beneficiary) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => context.push(
                AppRoutes.addVisit.replaceFirst(':beneficiaryId', beneficiary.beneficiaryId),
              ),
              icon: const Icon(Icons.add),
              label: const Text('Add Visit'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size(0, 48),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => context.push(
                AppRoutes.vaccination.replaceFirst(':beneficiaryId', beneficiary.beneficiaryId),
              ),
              icon: const Icon(Icons.vaccines),
              label: const Text('Vaccination'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(0, 48),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildHistorySection(BuildContext context, BeneficiaryModel beneficiary) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Health History',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        if (beneficiary.healthHistory.isEmpty)
          const Text('No previous records found.')
        else
          ...beneficiary.healthHistory.map((entry) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.history, size: 16, color: AppColors.primary),
                    const SizedBox(width: 8),
                    Expanded(child: Text(entry)),
                  ],
                ),
              )),
      ],
    );
  }
}

class _ChildCard extends StatelessWidget {
  final ChildProfileModel child;

  const _ChildCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: () => context.push(
          AppRoutes.growthChart.replaceFirst(':childId', child.childId),
        ),
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: child.gender == 'male' ? Colors.blue.shade50 : Colors.pink.shade50,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(child.gender == 'male' ? '👦' : '👧', style: const TextStyle(fontSize: 24)),
          ),
        ),
        title: Text(child.name, style: AppTextStyles.cardTitle),
        subtitle: Text('DOB: ${DateFormat('dd MMM yyyy').format(child.dateOfBirth)} (${child.ageDisplay})'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: child.nutritionColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                child.nutritionStatus.toUpperCase(),
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: child.nutritionColor),
              ),
            ),
            const SizedBox(height: 4),
            const Icon(Icons.chevron_right, size: 16, color: AppColors.textLight),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondary)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
