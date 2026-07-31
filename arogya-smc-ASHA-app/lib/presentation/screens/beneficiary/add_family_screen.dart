import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../providers/providers.dart';
import '../../../data/models/models.dart';
import 'package:uuid/uuid.dart';

class AddFamilyScreen extends ConsumerStatefulWidget {
  const AddFamilyScreen({super.key});

  @override
  ConsumerState<AddFamilyScreen> createState() => _AddFamilyScreenState();
}

class _AddFamilyScreenState extends ConsumerState<AddFamilyScreen> {
  final _formKey = GlobalKey<FormState>();
  
  final _familyNameController = TextEditingController();
  final _headNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _totalMembersController = TextEditingController(text: "1");
  
  late String _selectedWard;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final worker = ref.read(currentWorkerProvider);
    _selectedWard = worker?.wardCode ?? AppConstants.wards.first['code']!;
  }

  @override
  void dispose() {
    _familyNameController.dispose();
    _headNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _totalMembersController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);
    try {
      final family = FamilyModel(
        familyId: const Uuid().v4(),
        familyName: _familyNameController.text.trim(),
        headOfFamily: _headNameController.text.trim(),
        wardCode: _selectedWard,
        address: _addressController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        memberCount: int.tryParse(_totalMembersController.text) ?? 1,
        registeredAt: DateTime.now(),
        members: const [],
      );

      // Save family via repository
      await ref.read(beneficiaryRepositoryProvider).saveFamily(family);

      if (mounted) {
        ref.invalidate(familiesProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Family registered successfully'),
            backgroundColor: AppColors.success,
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to register family: $e'),
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
        title: const Text('Register New Family'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSectionTitle('Basic Information', Icons.family_restroom),
              const SizedBox(height: 16),
              TextFormField(
                controller: _familyNameController,
                decoration: InputDecoration(
                  labelText: 'Family Name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.badge_outlined),
                ),
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _headNameController,
                decoration: InputDecoration(
                  labelText: 'Head of Family Name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.person_outline),
                ),
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _totalMembersController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Total Family Members',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.groups_outlined),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Required';
                  if (int.tryParse(val) == null || int.parse(val) <= 0) return 'Must be a valid number';
                  return null;
                },
              ),
              
              const SizedBox(height: 32),
              _buildSectionTitle('Contact Details', Icons.contact_phone_outlined),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.phone_outlined),
                ),
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedWard,
                decoration: InputDecoration(
                  labelText: 'Ward',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.location_city_outlined),
                ),
                items: AppConstants.wards.map((w) => DropdownMenuItem(
                  value: w['code']!,
                  child: Text(w['name']!),
                )).toList(),
                onChanged: (val) => setState(() => _selectedWard = val!),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: 'Full Address',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.home_outlined),
                ),
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: _isLoading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 2,
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Register Family',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.1, color: Colors.white),
                      ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
