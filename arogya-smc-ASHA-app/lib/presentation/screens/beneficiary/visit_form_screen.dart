import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../providers/providers.dart';
import '../../../data/models/models.dart';
import 'package:uuid/uuid.dart';

class VisitFormScreen extends ConsumerStatefulWidget {
  final String beneficiaryId;
  const VisitFormScreen({super.key, required this.beneficiaryId});

  @override
  ConsumerState<VisitFormScreen> createState() => _VisitFormScreenState();
}

class _VisitFormScreenState extends ConsumerState<VisitFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _healthStatus = 'Normal';
  bool _fever = false;
  bool _cough = false;
  bool _diarrhea = false;
  bool _followUp = false;
  final _notesController = TextEditingController();
  bool _isLoading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      final visitRecord = VisitRecordModel(
        visitId: const Uuid().v4(),
        familyId: widget.beneficiaryId,
        beneficiaryId: widget.beneficiaryId,
        visitDate: DateTime.now(),
        symptoms: [
          if (_fever) 'Fever',
          if (_cough) 'Cough',
          if (_diarrhea) 'Diarrhea',
        ],
        maternalStatus: _healthStatus,
        childStatus: '',
        environmentalRisk: '',
        notes: _notesController.text + (_followUp ? ' (Follow-up)' : ''),
        latitude: 0.0,
        longitude: 0.0,
        createdAt: DateTime.now(),
      );
      await ref.read(beneficiaryRepositoryProvider).saveVisit(visitRecord);
      if (mounted) {
        ref.invalidate(visitsByBeneficiaryProvider(widget.beneficiaryId));
        ref.invalidate(familiesProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Visit recorded successfully'), backgroundColor: AppColors.success),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.danger),
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
        title: const Text('New Health Visit'),
        elevation: 0,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
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
                   const Text('Patient Record', 
                     style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold)),
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
                      title: 'Basic Assessment',
                      icon: Icons.monitor_heart_rounded,
                      child: DropdownButtonFormField<String>(
                        value: _healthStatus,
                        decoration: const InputDecoration(labelText: 'Overall Status', border: OutlineInputBorder()),
                        items: ['Normal', 'Sick', 'Critical'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                        onChanged: (val) => setState(() => _healthStatus = val!),
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    _buildFormCard(
                      title: 'Symptoms Checklist',
                      icon: Icons.checklist_rounded,
                      child: Column(
                        children: [
                          _buildCheck('Fever', _fever, (v) => setState(() => _fever = v!)),
                          _buildCheck('Cough', _cough, (v) => setState(() => _cough = v!)),
                          _buildCheck('Diarrhea', _diarrhea, (v) => setState(() => _diarrhea = v!)),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    _buildFormCard(
                      title: 'Clinical Observations',
                      icon: Icons.note_alt_rounded,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _notesController,
                            maxLines: 3,
                            decoration: const InputDecoration(
                              hintText: 'Enter specific symptoms or notes...',
                              border: OutlineInputBorder(),
                              fillColor: Color(0xFFF5F5F5),
                              filled: true,
                            ),
                          ),
                          const SizedBox(height: 16),
                          SwitchListTile(
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Follow-up Required?', style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: const Text('Mark for priority re-visit', style: TextStyle(fontSize: 12)),
                            value: _followUp,
                            onChanged: (val) => setState(() => _followUp = val),
                          ),
                        ],
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
                        : const Text('SUBMIT VISIT REPORT', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.1)),
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

  Widget _buildCheck(String label, bool value, Function(bool?) onChanged) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label, style: const TextStyle(fontSize: 14)),
      value: value,
      activeColor: AppColors.primary,
      onChanged: onChanged,
    );
  }
}
