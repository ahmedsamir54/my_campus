import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../domain/entities/attendance_entities.dart';

class CourseAttendanceList extends StatelessWidget {
  final List<CourseAttendanceEntity> courses;

  const CourseAttendanceList({
    super.key,
    required this.courses,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: courses.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final course = courses[index];
        return _CourseAttendanceCard(course: course);
      },
    );
  }
}

class _CourseAttendanceCard extends StatelessWidget {
  final CourseAttendanceEntity course;

  const _CourseAttendanceCard({required this.course});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    Color statusBg;
    IconData statusIcon;

    if (course.percentage >= 85.0) {
      statusColor = AppColors.primary;
      statusBg = AppColors.primaryLight;
      statusIcon = Icons.check_circle_outline_rounded;
    } else if (course.percentage >= 75.0) {
      statusColor = AppColors.warning;
      statusBg = AppColors.warningLight;
      statusIcon = Icons.info_outline_rounded;
    } else {
      statusColor = AppColors.danger;
      statusBg = AppColors.dangerLight;
      statusIcon = Icons.warning_amber_rounded;
    }

    final double percent = (course.percentage / 100.0).clamp(0.0, 1.0);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Course Header: Code, Title, Status Chip
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  course.courseCode,
                  style: AppTypography.caption.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryDark,
                    fontSize: 11,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.courseName,
                      style: AppTypography.heading3.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${course.instructor} • ${course.hall}',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textTertiary,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Status Chip
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: statusColor.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(statusIcon, size: 12, color: statusColor),
                    const SizedBox(width: 4),
                    Text(
                      course.status,
                      style: AppTypography.caption.copyWith(
                        color: statusColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Linear Progress Bar
          LinearPercentIndicator(
            lineHeight: 8.0,
            percent: percent,
            padding: EdgeInsets.zero,
            animation: true,
            animateFromLastPercent: true,
            barRadius: const Radius.circular(4),
            progressColor: statusColor,
            backgroundColor: statusBg,
          ),

          const SizedBox(height: 10),

          // Attendance Fraction & Percentage
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${course.attended} / ${course.conducted} Lectures Attended',
                style: AppTypography.caption.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                '${course.percentage.toStringAsFixed(1)}%',
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w800,
                  color: statusColor,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Safe Skips / Action Note Pill
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: statusBg.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.shield_outlined,
                  size: 14,
                  color: statusColor,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    course.safeSkipsText,
                    style: AppTypography.caption.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
                  ),
                ),
                if (course.nextClass.isNotEmpty)
                  Text(
                    course.nextClass,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textTertiary,
                      fontSize: 10,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
