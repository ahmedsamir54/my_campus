import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../domain/entities/profile_entities.dart';

class StudentDetailsCard extends StatelessWidget {
  final StudentProfileEntity profile;
  final AcademicSummaryEntity academic;

  const StudentDetailsCard({
    super.key,
    required this.profile,
    required this.academic,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderSubtle),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Student Information & Records',
                style: AppTypography.heading3.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  profile.status,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primaryDark,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Detail Items
          _buildDetailItem(
            icon: Icons.account_balance_rounded,
            label: 'Faculty',
            value: profile.faculty,
            iconColor: const Color(0xFF0D9488),
            iconBg: const Color(0xFFCCFBF1),
          ),
          const Divider(height: 18),
          _buildDetailItem(
            icon: Icons.email_outlined,
            label: 'Institutional Email',
            value: profile.email,
            iconColor: const Color(0xFF2563EB),
            iconBg: const Color(0xFFEFF6FF),
          ),
          const Divider(height: 18),
          _buildDetailItem(
            icon: Icons.phone_android_rounded,
            label: 'Phone Number',
            value: profile.phone,
            iconColor: const Color(0xFF16A34A),
            iconBg: const Color(0xFFDCFCE7),
          ),
          const Divider(height: 18),
          _buildDetailItem(
            icon: Icons.contact_emergency_rounded,
            label: 'Emergency Contact',
            value: profile.emergencyContact,
            iconColor: const Color(0xFFDC2626),
            iconBg: const Color(0xFFFEE2E2),
          ),
          const Divider(height: 18),
          _buildDetailItem(
            icon: Icons.military_tech_rounded,
            label: 'Academic Standing',
            value: academic.academicStanding,
            iconColor: const Color(0xFFD97706),
            iconBg: const Color(0xFFFEF3C7),
          ),

          const SizedBox(height: 16),

          // Clearances Status Row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.backgroundLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderSubtle),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        academic.libraryCleared
                            ? Icons.check_circle_rounded
                            : Icons.cancel_rounded,
                        color: academic.libraryCleared
                            ? AppColors.success
                            : AppColors.danger,
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Library: Cleared',
                        style: AppTypography.caption.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimaryLight,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 16,
                  width: 1,
                  color: AppColors.borderSubtle,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        academic.financialCleared
                            ? Icons.verified_rounded
                            : Icons.warning_rounded,
                        color: academic.financialCleared
                            ? AppColors.success
                            : AppColors.warning,
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Tuition: Cleared',
                        style: AppTypography.caption.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimaryLight,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
    required Color iconBg,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: iconBg,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 15, color: iconColor),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTypography.caption.copyWith(
                  color: AppColors.textMutedLight,
                  fontSize: 10,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimaryLight,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
