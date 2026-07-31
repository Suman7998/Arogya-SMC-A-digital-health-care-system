import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/services/auth_storage_service.dart';
import '../../providers/providers.dart';

class OtpVerificationScreen extends ConsumerStatefulWidget {
  final String expectedOtp;
  final DateTime? otpTimestamp;
  final Map<String, dynamic>? accountData;
  final bool isLogin;
  final String? aadhaarNumber;

  const OtpVerificationScreen({
    super.key,
    required this.expectedOtp,
    this.otpTimestamp,
    this.accountData,
    this.isLogin = false,
    this.aadhaarNumber,
  });

  @override
  ConsumerState<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends ConsumerState<OtpVerificationScreen> {
  final _otpCtrl = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  void _verifyOtp() async {
    final otp = _otpCtrl.text.trim();
    if (otp.length != 6) {
      setState(() => _errorMessage = 'Please enter a valid 6-digit OTP.');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Check for expiry (5 mins)
      if (widget.otpTimestamp != null) {
        final elapsed = DateTime.now().difference(widget.otpTimestamp!);
        if (elapsed.inMinutes >= 5) {
          setState(() {
            _isLoading = false;
            _errorMessage = 'OTP expired. Please request a new one.';
          });
          return;
        }
      }

      if (otp != widget.expectedOtp) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Invalid OTP entered.';
        });
        return;
      }

      // If we reach here, verification was successful
      if (widget.isLogin) {
         final password = widget.accountData?['plainPassword'] ?? '';
         final success = await ref.read(authNotifierProvider.notifier).login(widget.aadhaarNumber!, password);
         
         if (mounted) {
           setState(() => _isLoading = false);
           if (success) {
             context.go(AppRoutes.dashboard);
           } else {
             setState(() => _errorMessage = 'Login failed during session creation.');
           }
         }
      } else {
         final accountDataToSave = Map<String, dynamic>.from(widget.accountData!);
         final plainPw = accountDataToSave['plainPassword'] as String;
         final pwHash = AuthStorageService.hashPassword(plainPw);
         accountDataToSave.remove('plainPassword');
         accountDataToSave['passwordHash'] = pwHash;

         // Mark email as verified if needed (implicit for now based on success passage)
         final storageService = AuthStorageService();
         await storageService.saveAccount(accountDataToSave);

         if (mounted) {
           setState(() => _isLoading = false);
           ScaffoldMessenger.of(context).showSnackBar(
             const SnackBar(
               content: Text('Account successfully created! Please log in.'),
               backgroundColor: AppColors.success,
             ),
           );
           context.go(AppRoutes.login);
         }
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'An error occurred: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('OTP Verification'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              decoration: const BoxDecoration(
                gradient: AppColors.headerGradient,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.mark_email_read_rounded, size: 64, color: Colors.white),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Verification Code',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Step 2: Enter the 6-digit code sent to your email',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Registered Email Security',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextField(
                    controller: _otpCtrl,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 6,
                    style: const TextStyle(
                      fontSize: 36,
                      letterSpacing: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                      fontFamily: 'Poppins',
                    ),
                    decoration: InputDecoration(
                      counterText: '',
                      filled: true,
                      fillColor: Colors.white,
                      hintText: '000000',
                      hintStyle: TextStyle(color: Colors.grey.shade300, letterSpacing: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: AppColors.divider),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: AppColors.divider),
                      ),
                    ),
                  ),
                  if (_errorMessage != null) ...[
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.danger.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.danger.withOpacity(0.3)),
                      ),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(
                          color: AppColors.danger,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                  const SizedBox(height: 48),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _verifyOtp,
                    child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          )
                        : const Text('Verify to Continue'),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.timer_outlined, size: 18, color: AppColors.textLight),
                      const SizedBox(width: 8),
                      Text(
                        'Code expires in 5:00 minutes',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textLight,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
