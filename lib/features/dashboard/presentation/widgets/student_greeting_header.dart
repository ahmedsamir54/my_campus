import 'package:flutter/material.dart';
import 'package:my_campus/core/constants/app_colors.dart';
import 'package:my_campus/core/constants/app_typography.dart';

class StudentGreetingHeader extends StatelessWidget {
  final String studentName;
  final String status;
  final VoidCallback? onAvatarTap;

  const StudentGreetingHeader({
    super.key,
    required this.studentName,
    required this.status,
    this.onAvatarTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Hello, $studentName',
                    style: AppTypography.heading2.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text('👋', style: TextStyle(fontSize: 18)),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF0F392B) : AppColors.mintBadge,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Omi',
                          style: AppTypography.badgeText.copyWith(
                            color: isDark ? const Color(0xFF6EE7B7) : AppColors.primaryDark,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Make your campus life easier with MyCampus.',
                style: AppTypography.bodyMedium.copyWith(
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        // Student avatar with active online green badge
        InkWell(
          onTap: onAvatarTap,
          borderRadius: BorderRadius.circular(25),
          child: Stack(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary, width: 2),
                  color: isDark ? const Color(0xFF0F2C20) : AppColors.primaryLight,
                ),
                child: const ClipOval(
                  child: Icon(
                    Icons.person,
                    color: AppColors.primary,
                    size: 30,
                  ),
                ),
              ),
              Positioned(
                bottom: 2,
                right: 2,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isDark ? AppColors.backgroundDark : Colors.white,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
