import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../domain/entities/routine_entities.dart';

class UpcomingLectureTimeline extends StatelessWidget {
  final List<LectureEntity> lectures;
  final Function(LectureEntity)? onDownloadNotes;
  final Function(LectureEntity)? onViewRubric;
  final Function(LectureEntity)? onCheckInReservation;

  const UpcomingLectureTimeline({
    super.key,
    required this.lectures,
    this.onDownloadNotes,
    this.onViewRubric,
    this.onCheckInReservation,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (lectures.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 32),
        alignment: Alignment.center,
        child: Column(
          children: [
            Icon(
              Icons.event_busy_rounded,
              size: 36,
              color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
            ),
            const SizedBox(height: 8),
            Text(
              'No more lectures scheduled today',
              style: AppTypography.bodyMedium.copyWith(
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: lectures.map((lecture) {
        if (lecture.type == 'Reservation') {
          return _buildReservationCard(context, lecture);
        }
        return _buildUpcomingLectureCard(context, lecture);
      }).toList(),
    );
  }

  Widget _buildUpcomingLectureCard(BuildContext context, LectureEntity lecture) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isPresentation = lecture.statusTag.contains('Presentation');

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF131D28) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isPresentation
              ? (isDark ? const Color(0xFF7C2D12) : const Color(0xFFFFEDD5))
              : (isDark ? const Color(0xFF1E2D3D) : AppColors.borderSubtle),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: Status Tag & Time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isPresentation
                      ? (isDark ? const Color(0xFF3B1E08) : const Color(0xFFFFF7ED))
                      : (isDark ? const Color(0xFF132238) : const Color(0xFFEFF6FF)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isPresentation)
                      Icon(
                        Icons.warning_amber_rounded,
                        size: 12,
                        color: isDark ? const Color(0xFFFB923C) : const Color(0xFFEA580C),
                      )
                    else
                      Icon(
                        Icons.access_time_rounded,
                        size: 12,
                        color: isDark ? const Color(0xFF60A5FA) : const Color(0xFF2563EB),
                      ),
                    const SizedBox(width: 4),
                    Text(
                      lecture.statusTag,
                      style: AppTypography.badgeText.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: isPresentation
                            ? (isDark ? const Color(0xFFFB923C) : const Color(0xFFEA580C))
                            : (isDark ? const Color(0xFF60A5FA) : const Color(0xFF2563EB)),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                lecture.timeSpan,
                style: AppTypography.badgeText.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Title & Code
          Text(
            '${lecture.title} (${lecture.code})',
            style: AppTypography.heading3.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 4),

          // Instructor
          Row(
            children: [
              Icon(
                Icons.person_outline_rounded,
                size: 14,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              ),
              const SizedBox(width: 5),
              Text(
                lecture.instructor,
                style: AppTypography.bodySmall.copyWith(
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),

          // Hall
          Row(
            children: [
              Icon(
                Icons.room_outlined,
                size: 14,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              ),
              const SizedBox(width: 5),
              Text(
                lecture.hall,
                style: AppTypography.bodySmall.copyWith(
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                  fontSize: 11,
                ),
              ),
            ],
          ),

          // Lecture Notes Attachment Box
          if (lecture.attachmentName != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF101B27) : const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark ? const Color(0xFF1E2D3D) : const Color(0xFFE2E8F0),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF172554) : const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.description_outlined,
                      size: 18,
                      color: isDark ? const Color(0xFF60A5FA) : const Color(0xFF2563EB),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lecture.attachmentName!,
                          style: AppTypography.bodySmall.copyWith(
                            fontWeight: FontWeight.w600,
                            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                            fontSize: 11,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (lecture.attachmentSize != null)
                          Text(
                            lecture.attachmentSize!,
                            style: AppTypography.bodySmall.copyWith(
                              fontSize: 10,
                              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                            ),
                          ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => onDownloadNotes?.call(lecture),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      child: Icon(
                        Icons.download_rounded,
                        size: 18,
                        color: isDark ? const Color(0xFF34D399) : AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Presentation Group & Rubric
          if (lecture.groupSlot != null) ...[
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E2D3D) : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    lecture.groupSlot!,
                    style: AppTypography.badgeText.copyWith(
                      fontSize: 11,
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => onViewRubric?.call(lecture),
                  child: Text(
                    lecture.rubricLabel ?? 'View Rubric',
                    style: AppTypography.badgeText.copyWith(
                      color: isDark ? const Color(0xFF34D399) : AppColors.primary,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildReservationCard(BuildContext context, LectureEntity lecture) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF101B27) : const Color(0xFFF0FDF4),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark ? const Color(0xFF1E4636) : const Color(0xFFBBF7D0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF0F392B) : AppColors.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.bookmark_added_rounded,
              color: isDark ? const Color(0xFF34D399) : Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lecture.title,
                  style: AppTypography.heading3.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${lecture.hall} • ${lecture.startTime}',
                  style: AppTypography.bodySmall.copyWith(
                    fontSize: 11,
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => onCheckInReservation?.call(lecture),
            style: ElevatedButton.styleFrom(
              backgroundColor: isDark ? const Color(0xFF131D28) : Colors.white,
              foregroundColor: isDark ? const Color(0xFF34D399) : AppColors.primary,
              elevation: 0,
              side: BorderSide(
                color: isDark ? const Color(0xFF34D399) : AppColors.primary,
                width: 1.2,
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              minimumSize: const Size(0, 34),
            ),
            child: Text(
              lecture.reservationButton ?? 'Check In',
              style: AppTypography.badgeText.copyWith(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: isDark ? const Color(0xFF34D399) : AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
