import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/models.dart';
import '../../providers/providers.dart';

class VaccinationManagementScreen extends ConsumerWidget {
  final String beneficiaryId; // Mother/Head beneficiary ID

  const VaccinationManagementScreen({super.key, required this.beneficiaryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final beneficiaryAsync = ref.watch(beneficiaryDetailProvider(beneficiaryId));

    return Scaffold(
      appBar: AppBar(title: const Text('Vaccination Management')),
      body: beneficiaryAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
        data: (beneficiary) {
          if (beneficiary == null) return const Center(child: Text('Beneficiary not found'));
          
          final children = beneficiary.children;
          if (children.isEmpty) {
            return const Center(child: Text('No children registered for this family'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: children.length,
            itemBuilder: (context, index) {
              final child = children[index];
              return _ChildVaccinationCard(child: child);
            },
          );
        },
      ),
    );
  }
}

class _ChildVaccinationCard extends ConsumerWidget {
  final ChildProfileModel child;

  const _ChildVaccinationCard({required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.only(bottom: 20),
      child: ExpansionTile(
        initiallyExpanded: true,
        shape: const Border(), // Remove default borders
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: child.gender == 'male' ? Colors.blue.shade50 : Colors.pink.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              child.gender == 'male' ? '👦' : '👧',
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ),
        title: Text(
          child.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            fontFamily: 'Poppins',
          ),
        ),
        subtitle: Text(
          'Age: ${child.ageDisplay}',
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.textSecondary,
            fontFamily: 'Poppins',
          ),
        ),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: AppColors.background,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'IMMUNIZATION SCHEDULE',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textLight,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                _buildVaccineSchedule(context, ref),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton.icon(
              onPressed: () => _showAddVaccineDialog(context, ref),
              icon: const Icon(Icons.add_circle_outline_rounded),
              label: const Text('New Vaccination Entry'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVaccineSchedule(BuildContext context, WidgetRef ref) {
    // Standard schedule for India (simplified)
    final schedule = [
      {'name': 'BCG', 'due': 'At birth'},
      {'name': 'OPV 0', 'due': 'At birth'},
      {'name': 'Hepatitis B1', 'due': 'At birth'},
      {'name': 'OPV 1,2,3', 'due': '6, 10, 14 weeks'},
      {'name': 'Pentavalent 1,2,3', 'due': '6, 10, 14 weeks'},
      {'name': 'Rotavirus 1,2,3', 'due': '6, 10, 14 weeks'},
      {'name': 'IPV', 'due': '6, 14 weeks'},
      {'name': 'MR 1st Dose', 'due': '9-12 months'},
      {'name': 'Vitamin A 1st Dose', 'due': '9 months'},
    ];

    return Column(
      children: schedule.map((v) {
        final key = v['name']!.split(' ').first.toLowerCase();
        final isDone = child.vaccinationStatus[key] ?? false;
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isDone ? AppColors.success.withOpacity(0.2) : AppColors.divider),
          ),
          child: ListTile(
            dense: true,
            visualDensity: VisualDensity.compact,
            title: Text(
              v['name']!,
              style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
            ),
            subtitle: Text('Due: ${v['due']}', style: const TextStyle(fontSize: 11)),
            trailing: isDone
                ? const Icon(Icons.verified_rounded, color: AppColors.success, size: 24)
                : const Icon(Icons.pending_actions_rounded, color: AppColors.warning, size: 22),
          ),
        );
      }).toList(),
    );
  }

  void _showAddVaccineDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final doseController = TextEditingController(text: '1');
    final remarksController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: Column(
            children: [
              const Icon(Icons.medical_services_outlined, color: AppColors.primary, size: 40),
              const SizedBox(height: 12),
              Text(
                'Record for ${child.name}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Vaccine Name'),
                ),
                TextField(
                  controller: doseController,
                  decoration: const InputDecoration(labelText: 'Dose Number'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                ListTile(
                  title: const Text('Date Administered'),
                  subtitle: Text(DateFormat('dd-MM-yyyy').format(selectedDate)),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) setState(() => selectedDate = picked);
                  },
                ),
                TextField(
                  controller: remarksController,
                  decoration: const InputDecoration(labelText: 'Remarks'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.isEmpty) return;
                
                final record = VaccinationRecordModel(
                  childId: child.childId,
                  vaccineName: nameController.text,
                  doseNumber: int.parse(doseController.text),
                  dateAdministered: selectedDate,
                  remarks: remarksController.text,
                  createdAt: DateTime.now(),
                );

                await ref.read(beneficiaryRepositoryProvider).saveVaccination(record);
                // Invalidate both the individual beneficiary and the full families list
                ref.invalidate(beneficiaryDetailProvider(child.beneficiaryId));
                ref.invalidate(familiesProvider);
                
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Vaccination recorded successfully')),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
