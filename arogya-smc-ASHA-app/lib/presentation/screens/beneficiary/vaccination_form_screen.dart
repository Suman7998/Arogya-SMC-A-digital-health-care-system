import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_theme.dart';
import '../../providers/providers.dart';
import '../../../data/models/models.dart';

class VaccinationFormScreen extends ConsumerStatefulWidget {
  final String beneficiaryId;
  const VaccinationFormScreen({super.key, required this.beneficiaryId});

  @override
  ConsumerState<VaccinationFormScreen> createState() => _VaccinationFormScreenState();
}

class _VaccinationFormScreenState extends ConsumerState<VaccinationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _vaccineName = 'BCG';
  int _doseNumber = 1;
  final _remarksController = TextEditingController();
  DateTime _dateGiven = DateTime.now();
  DateTime? _nextDueDate;
  bool _isLoading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);
    try {
      final record = VaccinationRecordModel(
        childId: widget.beneficiaryId,
        vaccineName: _vaccineName,
        doseNumber: _doseNumber,
        dateAdministered: _dateGiven,
        remarks: _remarksController.text,
        nextDueDate: _nextDueDate,
        createdAt: DateTime.now(),
      );

      await ref.read(beneficiaryRepositoryProvider).saveVaccination(record);

      if (mounted) {
        ref.invalidate(vaccinationsByBeneficiaryProvider(widget.beneficiaryId));
        ref.invalidate(familiesProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Vaccination record saved successfully'), backgroundColor: AppColors.success),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save vaccination: $e'), backgroundColor: AppColors.danger),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFB),
      appBar: AppBar(
        title: const Text('Record Immunization'),
        elevation: 0,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   const Text('VACCINATION LOG', style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold)),
                   const SizedBox(height: 4),
                   Text('ID: ${widget.beneficiaryId}', 
                     style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildFormCard(
                      title: 'Vaccine Details',
                      icon: Icons.vaccines_rounded,
                      child: Column(
                        children: [
                          DropdownButtonFormField<String>(
                            value: _vaccineName,
                            decoration: const InputDecoration(labelText: 'Vaccine Name', border: OutlineInputBorder()),
                            items: ['BCG', 'Polio', 'DPT', 'Measles', 'PCV', 'Rotavirus', 'Hepatitis B'].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
                            onChanged: (val) => setState(() => _vaccineName = val!),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            initialValue: _doseNumber.toString(),
                            decoration: const InputDecoration(labelText: 'Dose Number', border: OutlineInputBorder()),
                            keyboardType: TextInputType.number,
                            onChanged: (val) => setState(() => _doseNumber = int.tryParse(val) ?? 1),
                            validator: (val) => (val == null || val.isEmpty) ? 'Required' : null,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    _buildFormCard(
                      title: 'Scheduling',
                      icon: Icons.calendar_month_rounded,
                      child: Column(
                        children: [
                          _buildDatePickerTile(
                            'Date Administered', 
                            _dateGiven, 
                            Icons.today_rounded, 
                            () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: _dateGiven,
                                firstDate: DateTime(2000),
                                lastDate: DateTime.now(),
                              );
                              if (picked != null) setState(() => _dateGiven = picked);
                            }
                          ),
                          const Divider(),
                          _buildDatePickerTile(
                            'Next Due Date (Optional)', 
                            _nextDueDate, 
                            Icons.event_rounded, 
                            () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now().add(const Duration(days: 30)),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(const Duration(days: 365)),
                              );
                              if (picked != null) setState(() => _nextDueDate = picked);
                            }
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    _buildFormCard(
                      title: 'Notes & Remarks',
                      icon: Icons.speaker_notes_rounded,
                      child: TextFormField(
                        controller: _remarksController,
                        maxLines: 2,
                        decoration: const InputDecoration(
                          hintText: 'Enter observation or site details...',
                          border: OutlineInputBorder(),
                          fillColor: Color(0xFFF5F5F5),
                          filled: true,
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),
                    
                    ElevatedButton(
                      onPressed: _isLoading ? null : _submit,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        elevation: 4,
                      ),
                      child: _isLoading 
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('SAVE VACCINATION RECORD', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.1)),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormCard({required String title, required IconData icon, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 20),
              const SizedBox(width: 10),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textPrimary)),
            ],
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }

  Widget _buildDatePickerTile(String label, DateTime? date, IconData icon, VoidCallback onTap) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      title: Text(label, style: const TextStyle(fontSize: 14)),
      subtitle: Text(date == null ? 'Not set' : DateFormat('dd MMM yyyy').format(date), 
          style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 15)),
      trailing: Icon(icon, color: AppColors.primary, size: 20),
    );
  }
}
