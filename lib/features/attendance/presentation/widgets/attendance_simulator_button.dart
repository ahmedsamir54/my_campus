import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';

class AttendanceSimulatorButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isSimulating;

  const AttendanceSimulatorButton({
    super.key,
    required this.onTap,
    this.isSimulating = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isSimulating
                  ? [
                      AppColors.primaryDark,
                      AppColors.primary,
                    ]
                  : [
                      const Color(0xFFF0FDF4),
                      const Color(0xFFE8F5E9),
                    ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSimulating
                  ? AppColors.primary
                  : AppColors.primary.withValues(alpha: 0.25),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.08),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: isSimulating
                      ? Colors.white.withValues(alpha: 0.15)
                      : AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.tune_rounded,
                  color: isSimulating ? Colors.white : AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            'Absence & Bunk Simulator',
                            style: AppTypography.heading3.copyWith(
                              fontSize: 14.5,
                              color: isSimulating
                                  ? Colors.white
                                  : AppColors.textPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: isSimulating
                                ? AppColors.accentLight.withValues(alpha: 0.3)
                                : AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            isSimulating ? 'ACTIVE' : 'SIMULATOR',
                            style: AppTypography.caption.copyWith(
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              color: isSimulating
                                  ? Colors.white
                                  : AppColors.primaryDark,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      isSimulating
                          ? 'Hypothetical skips configured • Tap to adjust'
                          : 'Test hypothetical skipped classes vs 75% rule',
                      style: AppTypography.caption.copyWith(
                        color: isSimulating
                            ? Colors.white.withValues(alpha: 0.8)
                            : AppColors.textSecondary,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: isSimulating
                    ? Colors.white
                    : AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
