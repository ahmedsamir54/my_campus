import 'package:flutter/material.dart';
import 'package:my_campus/core/constants/app_colors.dart';
import 'package:my_campus/core/constants/app_typography.dart';
import '../../domain/entities/dashboard_entities.dart';

class NextClassCard extends StatelessWidget {
  final NextClassEntity nextClass;
  final VoidCallback? onTap;

  const NextClassCard({
    super.key,
    required this.nextClass,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFFEFFCF5),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xFFBBF0D4),
              width: 1.2,
            ),
          ),
          child: Row(
            children: [
              // Green Rounded Clock Icon Container
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.access_time_filled_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              // Class Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'NEXT CLASS',
                      style: AppTypography.badgeText.copyWith(
                        color: AppColors.primary,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${nextClass.courseTitle} • ${nextClass.room}',
                      style: AppTypography.heading3.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimaryLight,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${nextClass.startTime} (${nextClass.instructor})',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondaryLight,
                        fontSize: 11,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // "In 15m" Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  nextClass.countdown,
                  style: AppTypography.badgeText.copyWith(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
