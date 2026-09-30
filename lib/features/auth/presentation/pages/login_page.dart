import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/widgets/app_button.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/biometric_auth_button.dart';
import '../widgets/student_credential_fields.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _idController = TextEditingController(text: 'CU-2023-8841');
  final _passwordController = TextEditingController(text: 'password123');
  final _formKey = GlobalKey<FormState>();
  bool _rememberMe = true;

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignIn() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().login(
            studentIdOrEmail: _idController.text.trim(),
            password: _passwordController.text.trim(),
            rememberMe: _rememberMe,
          );
    }
  }

  void _showForgotPasswordSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Self-Service Password Recovery',
                style: AppTypography.heading2.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                'University password resets require institutional multi-factor verification or visit to campus registrar office.',
                style: AppTypography.bodyMedium,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.backgroundLight,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.borderSubtle),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.mark_email_read_rounded,
                        color: AppColors.primary, size: 24),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Password reset links can be dispatched to your registered recovery mobile or alternate email.',
                        style: TextStyle(fontSize: 12, height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          'OTP verification sent to your registered phone number (+20 100 *** 5678)',
                        ),
                        backgroundColor: AppColors.primary,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Send Reset OTP to Phone'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showHelpdeskSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Campus IT Services & Helpdesk',
                style: AppTypography.heading2.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                'For student SSO, digital credentials, turnstile RFID cards, and institutional Wi-Fi support:',
                style: AppTypography.bodyMedium,
              ),
              const SizedBox(height: 16),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryLight,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.location_on_rounded,
                      color: AppColors.primary, size: 20),
                ),
                title: const Text('IT Innovation Hub • Building C, Floor 1'),
                subtitle: const Text('Operating Hours: Sun - Thu, 8:30 AM - 4:00 PM'),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color(0xFFEFF6FF),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.email_rounded,
                      color: Color(0xFF2563EB), size: 20),
                ),
                title: const Text('support@it.campus.edu'),
                subtitle: const Text('Response time: Under 2 hours during term'),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Dismiss'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      const Icon(Icons.verified_user_rounded,
                          color: Colors.white),
                      const SizedBox(width: 8),
                      Text('Welcome back, ${state.user.fullName}!'),
                    ],
                  ),
                  backgroundColor: AppColors.primary,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );

              // Route to MainNavigationShell / Dashboard
              Navigator.pushReplacementNamed(context, AppRoutes.mainShell);
            }

            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      const Icon(Icons.error_outline_rounded,
                          color: Colors.white),
                      const SizedBox(width: 8),
                      Expanded(child: Text(state.message)),
                    ],
                  ),
                  backgroundColor: AppColors.danger,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthLoading;

            return Center(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 1. University Brand Header
                    Container(
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF073A27),
                            Color(0xFF006B4D),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.25),
                            blurRadius: 14,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.school_rounded,
                          color: Colors.white,
                          size: 34,
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    Text(
                      'Central University Portal',
                      style: AppTypography.heading1.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimaryLight,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 4),

                    Text(
                      'Student Single Sign-On (SSO)',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textSecondaryLight,
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 10),

                    // Security Encryption Tag
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.lock_rounded,
                            size: 12,
                            color: AppColors.primary,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'SSL 256-Bit TLS Secured SSO',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryDark,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // 2. Credential Form Container
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.borderSubtle),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StudentCredentialFields(
                            idController: _idController,
                            passwordController: _passwordController,
                            formKey: _formKey,
                            onSubmitted: _handleSignIn,
                          ),

                          const SizedBox(height: 12),

                          // Remember Me & Forgot Password Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Checkbox(
                                      value: _rememberMe,
                                      activeColor: AppColors.primary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      onChanged: (val) {
                                        setState(() {
                                          _rememberMe = val ?? true;
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Remember Me',
                                    style: AppTypography.caption.copyWith(
                                      color: AppColors.textSecondaryLight,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: _showForgotPasswordSheet,
                                child: Text(
                                  'Forgot Password?',
                                  style: AppTypography.caption.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // Main CTA: Sign In Button
                          AppButton(
                            text: 'Sign In to Portal',
                            isLoading: isLoading,
                            width: double.infinity,
                            height: 48,
                            icon: Icons.login_rounded,
                            onPressed: _handleSignIn,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 3. Alternative Login Divider
                    Row(
                      children: [
                        Expanded(
                            child: Divider(color: Colors.blueGrey.shade100)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'OR',
                            style: AppTypography.caption.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.textMutedLight,
                            ),
                          ),
                        ),
                        Expanded(
                            child: Divider(color: Colors.blueGrey.shade100)),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // 4. Biometric Quick Login Button
                    BiometricAuthButton(
                      isLoading: isLoading,
                      onTap: () {
                        context.read<AuthCubit>().loginWithBiometrics();
                      },
                    ),

                    const SizedBox(height: 24),

                    // 5. Helpdesk Support Footer
                    GestureDetector(
                      onTap: _showHelpdeskSheet,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.help_outline_rounded,
                            size: 15,
                            color: AppColors.textSecondaryLight,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Campus IT Helpdesk & Support',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textSecondaryLight,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
