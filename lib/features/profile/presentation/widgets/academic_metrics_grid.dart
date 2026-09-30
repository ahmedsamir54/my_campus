import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../domain/entities/profile_entities.dart';

class AcademicMetricsGrid extends StatelessWidget {
  final AcademicSummaryEntity academic;

  const AcademicMetricsGrid({
    super.key,
    required this.academic,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 1. CGPA Metric
        Expanded(
          child: _buildMetricCard(
            title: 'CGPA',
            value: academic.cgpa.toStringAsFixed(2),
            subtitle: '/ ${academic.maxCgpa.toStringAsFixed(2)} Scale',
            tag: 'Top 5%',
            tagColor: AppColors.primaryDark,
            tagBg: AppColors.primaryLight,
            icon: Icons.star_rounded,
            iconColor: const Color(0xFFD97706),
            iconBg: const Color(0xFFFEF3C7),
          ),
        ),
        const SizedBox(width: 10),

        // 2. Credits Metric
        Expanded(
          child: _buildMetricCard(
            title: 'Credits',
            value: '${academic.earnedCredits}',
            subtitle: '/ ${academic.totalCredits} Total',
            tag: '${((academic.earnedCredits / academic.totalCredits) * 100).toInt()}% Done',
            tagColor: const Color(0xFF0369A1),
            tagBg: const Color(0xFFE0F2FE),
            icon: Icons.school_rounded,
            iconColor: const Color(0xFF0284C7),
            iconBg: const Color(0xFFE0F2FE),
          ),
        ),
        const SizedBox(width: 10),

        // 3. Courses Metric
        Expanded(
          child: _buildMetricCard(
            title: 'Courses',
            value: '${academic.enrolledCourses}',
            subtitle: 'Enrolled',
            tag: academic.semester,
            tagColor: const Color(0xFF7C3AED),
            tagBg: const Color(0xFFF5F3FF),
            icon: Icons.menu_book_rounded,
            iconColor: const Color(0xFF7C3AED),
            iconBg: const Color(0xFFF5F3FF),
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String subtitle,
    required String tag,
    required Color tagColor,
    required Color tagBg,
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderSubtle),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: iconBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 14, color: iconColor),
              ),
              Flexible(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    color: tagBg,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    tag,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: tagColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTypography.heading2.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Text(
                title,
                style: AppTypography.caption.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimaryLight,
                  fontSize: 11,
                ),
              ),
              const SizedBox(width: 3),
              Expanded(
                child: Text(
                  subtitle,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textMutedLight,
                    fontSize: 10,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
