import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../domain/entities/routine_entities.dart';

class ActiveOngoingLectureCard extends StatelessWidget {
  final LectureEntity lecture;
  final VoidCallback? onLocateHall;

  const ActiveOngoingLectureCard({
    super.key,
    required this.lecture,
    this.onLocateHall,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF101B27) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark ? const Color(0xFF1E4636) : const Color(0xFFD1FAE5),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.25)
                : AppColors.primary.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Emerald Left Accent Strip
              Container(
                width: 6,
                color: AppColors.primary,
              ),
              // Content Area
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Row: Tag & Time
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                            decoration: BoxDecoration(
                              color: isDark ? const Color(0xFF0F392B) : const Color(0xFFD1FAE5),
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
                                const SizedBox(width: 5),
                                Text(
                                  lecture.statusTag.toUpperCase(),
                                  style: AppTypography.badgeText.copyWith(
                                    color: isDark ? const Color(0xFF34D399) : AppColors.primaryDark,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            lecture.timeSpan,
                            style: AppTypography.badgeText.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Progress Bar & Elapsed Info
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Class Elapsed',
                            style: AppTypography.bodySmall.copyWith(
                              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                              fontSize: 11,
                            ),
                          ),
                          Text(
                            '${lecture.elapsedMinutes} min of ${lecture.totalMinutes} min (${(lecture.elapsedPercentage * 100).toInt()}%)',
                            style: AppTypography.badgeText.copyWith(
                              color: isDark ? const Color(0xFF34D399) : AppColors.primaryDark,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      // Linear progress track
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: lecture.elapsedPercentage,
                          minHeight: 5,
                          backgroundColor: isDark ? const Color(0xFF1E2D3D) : const Color(0xFFE2E8F0),
                          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Course Title & Code
                      Text(
                        '${lecture.title} (${lecture.code})',
                        style: AppTypography.heading3.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Instructor
                      Row(
                        children: [
                          Icon(
                            Icons.person_outline_rounded,
                            size: 15,
                            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            lecture.instructor,
                            style: AppTypography.bodyMedium.copyWith(
                              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),

                      // Hall / Location
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 15,
                            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              lecture.hall,
                              style: AppTypography.bodySmall.copyWith(
                                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                                fontSize: 11,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Action Chips: Locate Hall & Attendance Marked
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          if (lecture.locateWalkMinutes != null)
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: onLocateHall,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: isDark ? const Color(0xFF0F392B) : const Color(0xFFE8F5E9),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.near_me_outlined,
                                        size: 13,
                                        color: isDark ? const Color(0xFF34D399) : AppColors.primary,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'Locate Hall (${lecture.locateWalkMinutes})',
                                        style: AppTypography.badgeText.copyWith(
                                          color: isDark ? const Color(0xFF34D399) : AppColors.primaryDark,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          if (lecture.attendanceMarked != null)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: isDark ? const Color(0xFF1E2D3D) : const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.check_circle_rounded, size: 13, color: AppColors.success),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Attendance Marked (${lecture.attendanceMarked})',
                                    style: AppTypography.badgeText.copyWith(
                                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
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
