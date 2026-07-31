import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/models.dart';
import '../../providers/providers.dart';
import '../../widgets/report_photo_section.dart';

class VisitEntryScreen extends ConsumerStatefulWidget {
  final String beneficiaryId;

  const VisitEntryScreen({super.key, required this.beneficiaryId});

  @override
  ConsumerState<VisitEntryScreen> createState() => _VisitEntryScreenState();
}

class _VisitEntryScreenState extends ConsumerState<VisitEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime _visitDate = DateTime.now();
  final _notesController = TextEditingController();
  final _maternalController = TextEditingController();
  final _childController = TextEditingController();
  final _envController = TextEditingController();
  
  final List<String> _selectedSymptoms = [];
  final List<String> _availableSymptoms = [
    'Fever', 'Cough', 'Cold', 'Diarrhea', 'Vomiting', 'Rash', 'Weakness'
  ];

  @override
  void dispose() {
    _notesController.dispose();
    _maternalController.dispose();
    _childController.dispose();
    _envController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _visitDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _visitDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final beneficiaryAsync = ref.watch(beneficiaryDetailProvider(widget.beneficiaryId));
    
    return Scaffold(
      appBar: AppBar(title: const Text('Add Household Visit')),
      body: beneficiaryAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
        data: (beneficiary) {
          if (beneficiary == null) return const Center(child: Text('Beneficiary not found'));
          
          return Stack(
            children: [
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Step Indicator Header
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                        decoration: const BoxDecoration(
                          gradient: AppColors.headerGradient,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32),
                            bottomRight: Radius.circular(32),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Record Visit',
                              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Poppins'),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Recording visit for ${beneficiary.name}',
                              style: TextStyle(fontSize: 15, color: Colors.white.withOpacity(0.9), fontFamily: 'Poppins'),
                            ),
                          ],
                        ),
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildStepLabel('1', 'CORE INFORMATION'),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: const Text('Visit Date', style: TextStyle(fontWeight: FontWeight.w600, fontFamily: 'Poppins')),
                                      subtitle: Text(DateFormat('EEEE, dd MMM yyyy').format(_visitDate)),
                                      trailing: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(color: AppColors.primaryLighter, borderRadius: BorderRadius.circular(10)),
                                        child: const Icon(Icons.calendar_month_rounded, color: AppColors.primary),
                                      ),
                                      onTap: _selectDate,
                                    ),
                                    const Divider(),
                                    const SizedBox(height: 12),
                                    const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Symptoms Observed', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary, fontFamily: 'Poppins')),
                                    ),
                                    const SizedBox(height: 12),
                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 4,
                                      children: _availableSymptoms.map((symptom) {
                                        final isSelected = _selectedSymptoms.contains(symptom);
                                        return FilterChip(
                                          label: Text(symptom),
                                          selected: isSelected,
                                          selectedColor: AppColors.primary.withOpacity(0.2),
                                          checkmarkColor: AppColors.primary,
                                          labelStyle: TextStyle(
                                            color: isSelected ? AppColors.primary : AppColors.textPrimary,
                                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                            fontSize: 13,
                                          ),
                                          onSelected: (val) {
                                            setState(() {
                                              if (val) {
                                                _selectedSymptoms.add(symptom);
                                              } else {
                                                _selectedSymptoms.remove(symptom);
                                              }
                                            });
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            
                            const SizedBox(height: 24),
                            _buildStepLabel('2', 'HEALTH OBSERVATIONS'),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: _maternalController,
                                      decoration: const InputDecoration(
                                        labelText: 'Maternal Status',
                                        prefixIcon: Icon(Icons.pregnant_woman_rounded),
                                        hintText: 'ANC check, high risk details...',
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    TextFormField(
                                      controller: _childController,
                                      decoration: const InputDecoration(
                                        labelText: 'Child Health',
                                        prefixIcon: Icon(Icons.child_care_rounded),
                                        hintText: 'Growth, feeding, illness...',
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    TextFormField(
                                      controller: _envController,
                                      decoration: const InputDecoration(
                                        labelText: 'Environment Risks',
                                        prefixIcon: Icon(Icons.eco_rounded),
                                        hintText: 'Water, sanitation, hygiene...',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            
                            const SizedBox(height: 24),
                            _buildStepLabel('3', 'RECORDS & EVIDENCE'),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    const ReportPhotoSection(),
                                    const SizedBox(height: 16),
                                    TextFormField(
                                      controller: _notesController,
                                      maxLines: 3,
                                      decoration: const InputDecoration(
                                        labelText: 'Additional Summary Notes',
                                        alignLabelWithHint: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            
                            const SizedBox(height: 48),
                            ElevatedButton(
                              onPressed: _isLoading ? null : () => _handleSave(beneficiary),
                              child: _isLoading
                                  ? const CircularProgressIndicator(color: Colors.white)
                                  : const Text('Verify & Submit Record'),
                            ),
                            const SizedBox(height: 32),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (_isLoading)
                Container(
                  color: Colors.black26,
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStepLabel(String stepNumber, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
            child: Center(
              child: Text(
                stepNumber,
                style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
              letterSpacing: 1.2,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }

  bool _isLoading = false;

  Future<void> _handleSave(BeneficiaryModel beneficiary) async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      try {
      final photoPaths = ref.read(reportWizardProvider).photoPaths;
      
      final visit = VisitRecordModel(
        visitId: const Uuid().v4(),
        familyId: beneficiary.familyId,
        beneficiaryId: beneficiary.beneficiaryId,
        visitDate: _visitDate,
        symptoms: _selectedSymptoms,
        maternalStatus: _maternalController.text,
        childStatus: _childController.text,
        environmentalRisk: _envController.text,
        notes: _notesController.text,
        photoPath: photoPaths.isNotEmpty ? photoPaths.first : null,
        createdAt: DateTime.now(),
      );

      final repo = ref.read(beneficiaryRepositoryProvider);
      await repo.saveVisit(visit);
      
      // Artificial delay for better UX on save
      await Future.delayed(const Duration(milliseconds: 1000));
      
      // Refresh beneficiary list and detail
      ref.invalidate(familiesProvider);
      ref.invalidate(beneficiaryDetailProvider(widget.beneficiaryId));
      
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Visit record saved successfully'),
            backgroundColor: AppColors.success,
          ),
        );
        context.pop();
      }
      } catch (e) {
        if (mounted) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.danger),
          );
        }
      }
    }
  }
}
