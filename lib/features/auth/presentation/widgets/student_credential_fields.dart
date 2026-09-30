import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/app_text_field.dart';

class StudentCredentialFields extends StatefulWidget {
  final TextEditingController idController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final VoidCallback onSubmitted;

  const StudentCredentialFields({
    super.key,
    required this.idController,
    required this.passwordController,
    required this.formKey,
    required this.onSubmitted,
  });

  @override
  State<StudentCredentialFields> createState() =>
      _StudentCredentialFieldsState();
}

class _StudentCredentialFieldsState extends State<StudentCredentialFields> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Student ID or Email Field
          AppTextField(
            controller: widget.idController,
            labelText: 'Student ID or Institutional Email',
            hintText: 'e.g. CU-2023-8841 or student@campus.edu',
            prefixIcon: Icons.badge_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your Student ID or university email';
              }
              return null;
            },
          ),

          const SizedBox(height: 16),

          // 2. Password Field with Visibility Toggle
          AppTextField(
            controller: widget.passwordController,
            labelText: 'Portal Password',
            hintText: 'Enter your SSO secret password',
            prefixIcon: Icons.lock_outline_rounded,
            obscureText: _obscurePassword,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: AppColors.textSecondaryLight,
                size: 20,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 4) {
                return 'Password must be at least 4 characters';
              }
              return null;
            },
          ),

          const SizedBox(height: 6),

          // Quick helper chip for demo credentials
          Row(
            children: [
              const Icon(
                Icons.info_outline_rounded,
                size: 13,
                color: AppColors.primary,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  'Demo credentials: CU-2023-8841 / password123',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.primaryDark,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
