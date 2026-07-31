import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../providers/providers.dart';
import '../../../data/models/models.dart';
import 'package:uuid/uuid.dart';
import 'package:logger/logger.dart';

class AddMemberScreen extends ConsumerStatefulWidget {
  final String familyId;
  const AddMemberScreen({super.key, required this.familyId});

  @override
  ConsumerState<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends ConsumerState<AddMemberScreen> {
  final _formKey = GlobalKey<FormState>();
  final _logger = Logger();
  
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _healthStatusController = TextEditingController(text: 'Healthy');
  
  String _gender = 'female';
  String _pregnancyStatus = 'not';
  bool _isLoading = false;

  // For children
  bool get _isChild => (int.tryParse(_ageController.text) ?? 99) < 5;
  final _bloodGroupController = TextEditingController();
  DateTime _dob = DateTime.now();

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _healthStatusController.dispose();
    _bloodGroupController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    
    _logger.i('Submitting new member: name=${_nameController.text}, age=${_ageController.text}, gender=$_gender');
    
    setState(() => _isLoading = true);
    try {
      final familyAsync = ref.read(familyDetailProvider(widget.familyId));
      final family = familyAsync.value;
      if (family == null) throw Exception("Family not found");

      final beneficiaryId = const Uuid().v4();
      final now = DateTime.now();
      
      final newMember = BeneficiaryModel(
        beneficiaryId: beneficiaryId,
        familyId: widget.familyId,
        name: _nameController.text.trim(),
        age: int.tryParse(_ageController.text) ?? 0,
        gender: _gender,
        address: family.address,
        wardCode: family.wardCode,
        pregnancyStatus: _gender == 'female' ? _pregnancyStatus : 'not',
        createdAt: now,
        children: const [],
      );

      // Save member (we would normally call a repository function for addMember)
      // Since it's a mock, we recreate the family with the new member.
      final updatedFamily = FamilyModel(
        familyId: family.familyId,
        familyName: family.familyName,
        wardCode: family.wardCode,
        address: family.address,
        headOfFamily: family.headOfFamily,
        phoneNumber: family.phoneNumber,
        memberCount: family.memberCount + 1,
        registeredAt: family.registeredAt,
        lastVisit: family.lastVisit,
        members: [...family.members, newMember],
      );

      await ref.read(beneficiaryRepositoryProvider).saveFamily(updatedFamily);
      
      // If it's a child under 5, we should also save a Child record
      if (_isChild) {
        final childRecord = ChildProfileModel(
          childId: const Uuid().v4(),
          beneficiaryId: beneficiaryId,
          familyId: widget.familyId,
          name: _nameController.text.trim(),
          dateOfBirth: _dob,
          gender: _gender,
          bloodGroup: _bloodGroupController.text.trim(),
          nutritionStatus: 'normal',
          createdAt: now,
        );
        await ref.read(beneficiaryRepositoryProvider).saveChild(childRecord);
        _logger.i('Child saved with id ${childRecord.childId}');
      }

      if (mounted) {
        ref.invalidate(familyDetailProvider(widget.familyId));
        ref.invalidate(familiesProvider);
        if (_isChild) ref.invalidate(childrenUnderFiveProvider);
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Member added successfully'),
            backgroundColor: AppColors.success,
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        _logger.e('Failed to add member', error: e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add member: $e'),
            backgroundColor: AppColors.danger,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Family Member'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.person),
                ),
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Age (Years)',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        prefixIcon: const Icon(Icons.cake),
                      ),
                      onChanged: (val) => setState(() {}),
                      validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _gender,
                      decoration: InputDecoration(
                        labelText: 'Gender',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'female', child: Text('Female')),
                        DropdownMenuItem(value: 'male', child: Text('Male')),
                        DropdownMenuItem(value: 'other', child: Text('Other')),
                      ],
                      onChanged: (val) => setState(() => _gender = val!),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              if (_gender == 'female' && !_isChild) ...[
                DropdownButtonFormField<String>(
                  value: _pregnancyStatus,
                  decoration: InputDecoration(
                    labelText: 'Pregnancy Status',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    prefixIcon: const Icon(Icons.pregnant_woman),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'not', child: Text('Not Pregnant')),
                    DropdownMenuItem(value: 'pregnant', child: Text('Pregnant')),
                    DropdownMenuItem(value: 'post', child: Text('Post-natal')),
                  ],
                  onChanged: (val) => setState(() => _pregnancyStatus = val!),
                ),
                const SizedBox(height: 16),
              ],
              
              TextFormField(
                controller: _healthStatusController,
                decoration: InputDecoration(
                  labelText: 'Health Status',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.favorite),
                ),
              ),
              
              if (_isChild) ...[
                const SizedBox(height: 32),
                const Text('Child Information (Under 5)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary)),
                const SizedBox(height: 16),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Date of Birth'),
                  subtitle: Text(_dob.toString().split(' ')[0]),
                  trailing: const Icon(Icons.calendar_month, color: AppColors.primary),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _dob,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) setState(() => _dob = picked);
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _bloodGroupController,
                  decoration: InputDecoration(
                    labelText: 'Blood Group (Optional)',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    prefixIcon: const Icon(Icons.bloodtype),
                  ),
                ),
              ],

              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: _isLoading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Save Member',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
