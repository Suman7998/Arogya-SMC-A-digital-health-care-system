import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../providers/providers.dart';

class AuthScreen extends ConsumerStatefulWidget {
  final String role;
  const AuthScreen({super.key, this.role = 'ASHA Worker'});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Registration Controllers
  final _regFormKey = GlobalKey<FormState>();
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _regEmailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _aadhaarCtrl = TextEditingController();
  final _regPasswordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();
  
  // Login Controllers
  final _loginFormKey = GlobalKey<FormState>();
  final _loginEmailCtrl = TextEditingController();
  final _loginPasswordCtrl = TextEditingController();

  bool _isLoading = false;
  bool _obscureRegPassword = true;
  bool _obscureLoginPassword = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _regEmailCtrl.dispose();
    _phoneCtrl.dispose();
    _aadhaarCtrl.dispose();
    _regPasswordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    _loginEmailCtrl.dispose();
    _loginPasswordCtrl.dispose();
    super.dispose();
  }

  // --- [REQUIREMENT: Authentication Logic (untouched)] ---
  Future<void> _handleRegister() async {
    if (!_regFormKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      final email = _regEmailCtrl.text.trim();
      final password = _regPasswordCtrl.text.trim();
      final fullName = "${_firstNameCtrl.text.trim()} ${_lastNameCtrl.text.trim()}";
      await ref.read(authNotifierProvider.notifier).register(email: email, password: password, fullName: fullName);
      if (mounted) {
        _showSuccessDialog('Verification link sent to $email. Please verify before login.');
        _tabController.animateTo(0);
      }
    } catch (e) {
      if (mounted) _showErrorSnackBar(e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _handleLogin() async {
    if (!_loginFormKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      final email = _loginEmailCtrl.text.trim();
      final password = _loginPasswordCtrl.text.trim();
      final success = await ref.read(authNotifierProvider.notifier).login(email, password);
      if (success && mounted) context.go(AppRoutes.dashboard);
    } catch (e) {
      if (mounted) _showErrorSnackBar(e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message.replaceFirst('Exception: ', ''), style: const TextStyle(fontFamily: 'Poppins')),
        backgroundColor: AppColors.danger,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success!', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
        content: Text(message, style: const TextStyle(fontFamily: 'Poppins')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color softBlue = Color(0xFFF0F7FB);
    const Color headerTeal = Color(0xFF00796B);

    return Scaffold(
      backgroundColor: softBlue,
      // --- [USER REQUIREMENT 1: resizeToAvoidBottomInset] ---
      resizeToAvoidBottomInset: true,
      // --- [USER REQUIREMENT 2: SafeArea] ---
      body: SafeArea(
        // --- [USER REQUIREMENT 3: SingleChildScrollView] ---
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          // --- [USER REQUIREMENT 7: ConstrainedBox] ---
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
            ),
            // --- [USER REQUIREMENT 8: IntrinsicHeight] ---
            child: IntrinsicHeight(
              // --- [USER REQUIREMENT 4: Padding] ---
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  // --- [USER REQUIREMENT 6: crossAxisAlignment] ---
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // --- [Header Section] ---
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      decoration: BoxDecoration(
                        color: headerTeal,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))],
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                            child: const Icon(Icons.health_and_safety_rounded, size: 40, color: headerTeal),
                          ),
                          const SizedBox(height: 12),
                          const Text('AAROGYA - SMC', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1.2, fontFamily: 'Poppins')),
                          const Text('Health Worker Portal', style: TextStyle(color: Colors.white70, fontSize: 12, fontFamily: 'Poppins')),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // --- [Toggle Switch] ---
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: const [BoxShadow(color: Color(0x0D000000), blurRadius: 8)]),
                      child: TabBar(
                        controller: _tabController,
                        indicator: BoxDecoration(color: headerTeal, borderRadius: BorderRadius.circular(12)),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.grey.shade600,
                        labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: Colors.transparent,
                        tabs: const [Tab(text: 'LOGIN'), Tab(text: 'REGISTER')],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // --- [USER REQUIREMENT 5: Form] ---
                    Expanded(
                      child: _tabController.index == 0 
                        ? Form(key: _loginFormKey, child: _buildLoginFields())
                        : Form(key: _regFormKey, child: _buildRegisterFields()),
                    ),

                    // --- [Footer] ---
                    const SizedBox(height: 20),
                    Center(child: Text('Solapur Municipal Corporation © 2026', style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontFamily: 'Poppins'))),
                    
                    // --- [USER REQUIREMENT: Keyboard Handling] ---
                    SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginFields() {
    return Column(
      children: [
        _buildTextField(
          controller: _loginEmailCtrl,
          label: 'Medical Email ID',
          icon: Icons.alternate_email_rounded,
          keyboard: TextInputType.emailAddress,
          validator: (v) => (v == null || !v.contains('@')) ? 'Enter a valid official email' : null,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _loginPasswordCtrl,
          label: 'Access Password',
          icon: Icons.key_rounded,
          isPassword: true,
          obscure: _obscureLoginPassword,
          onToggle: () => setState(() => _obscureLoginPassword = !_obscureLoginPassword),
          validator: (v) => (v == null || v.length < 6) ? 'Password must be 6+ characters' : null,
        ),
        const Spacer(),
        // Spacing above button
        const SizedBox(height: 20),
        _buildActionButton(label: 'LOGIN TO SYSTEM', onPressed: _isLoading ? null : _handleLogin),
      ],
    );
  }

  Widget _buildRegisterFields() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildTextField(controller: _firstNameCtrl, label: 'First Name', icon: Icons.person_outline_rounded, validator: (v) => v!.isEmpty ? 'Required' : null)),
            const SizedBox(width: 12),
            Expanded(child: _buildTextField(controller: _lastNameCtrl, label: 'Last Name', icon: Icons.person_outline_rounded, validator: (v) => v!.isEmpty ? 'Required' : null)),
          ],
        ),
        const SizedBox(height: 14),
        _buildTextField(
          controller: _regEmailCtrl,
          label: 'Primary Email Address',
          icon: Icons.email_outlined,
          validator: (v) => (v == null || !v.contains('@')) ? 'Enter valid email' : null,
        ),
        const SizedBox(height: 14),
        _buildTextField(
          controller: _phoneCtrl,
          label: 'Authorized Mobile (10 Digits)',
          icon: Icons.phone_android_rounded,
          keyboard: TextInputType.phone,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)],
          validator: (v) => (v == null || v.length != 10) ? 'Exactly 10 digits required' : null,
        ),
        const SizedBox(height: 14),
        _buildTextField(
          controller: _aadhaarCtrl,
          label: 'Aadhaar Number (12 Digits)',
          icon: Icons.badge_outlined,
          keyboard: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(12)],
          validator: (v) => (v == null || v.length != 12) ? 'Exactly 12 digits required' : null,
        ),
        const SizedBox(height: 14),
        _buildTextField(
          controller: _regPasswordCtrl,
          label: 'Set New Password',
          icon: Icons.lock_outline_rounded,
          isPassword: true,
          obscure: _obscureRegPassword,
          onToggle: () => setState(() => _obscureRegPassword = !_obscureRegPassword),
          validator: (v) => (v == null || v.length < 6) ? 'At least 6 characters' : null,
        ),
        const SizedBox(height: 14),
        _buildTextField(
          controller: _confirmPasswordCtrl,
          label: 'Verify Password',
          icon: Icons.lock_reset_rounded,
          isPassword: true,
          obscure: true,
          validator: (v) => (v != _regPasswordCtrl.text) ? 'Passwords must match' : null,
        ),
        // Spacing above button
        const SizedBox(height: 20),
        _buildActionButton(label: 'CONFIRM REGISTRATION', onPressed: _isLoading ? null : _handleRegister),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboard = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    bool isPassword = false,
    bool obscure = false,
    VoidCallback? onToggle,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      obscureText: obscure,
      inputFormatters: inputFormatters,
      style: const TextStyle(fontSize: 15, fontFamily: 'Poppins'),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey.shade600, fontSize: 13),
        prefixIcon: Icon(icon, color: const Color(0xFF00796B), size: 20),
        suffixIcon: isPassword ? IconButton(icon: Icon(obscure ? Icons.visibility_off : Icons.visibility, color: Colors.grey.shade400, size: 18), onPressed: onToggle) : null,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF00796B), width: 1.5)),
        errorStyle: const TextStyle(fontSize: 12, fontFamily: 'Poppins', fontWeight: FontWeight.w500),
      ),
      validator: validator,
    );
  }

  Widget _buildActionButton({required String label, required VoidCallback? onPressed}) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00796B),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
        ),
        child: _isLoading 
          ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
          : Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Poppins', letterSpacing: 0.5)),
      ),
    );
  }
}
