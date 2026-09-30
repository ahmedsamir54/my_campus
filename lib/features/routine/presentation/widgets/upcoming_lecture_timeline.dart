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
    if (lectures.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 32),
        alignment: Alignment.center,
        child: Column(
          children: [
            const Icon(Icons.event_busy_rounded, size: 36, color: AppColors.textMutedLight),
            const SizedBox(height: 8),
            Text(
              'No more lectures scheduled today',
              style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondaryLight),
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
    final isPresentation = lecture.statusTag.contains('Presentation');

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isPresentation ? const Color(0xFFFFEDD5) : AppColors.borderSubtle,
          width: 1,
        ),
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
          // Header Row: Status Tag & Time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isPresentation ? const Color(0xFFFFF7ED) : const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isPresentation)
                      const Icon(Icons.warning_amber_rounded, size: 12, color: Color(0xFFEA580C))
                    else
                      const Icon(Icons.access_time_rounded, size: 12, color: Color(0xFF2563EB)),
                    const SizedBox(width: 4),
                    Text(
                      lecture.statusTag,
                      style: AppTypography.badgeText.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: isPresentation ? const Color(0xFFEA580C) : const Color(0xFF2563EB),
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
                  color: AppColors.textPrimaryLight,
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
            ),
          ),
          const SizedBox(height: 4),

          // Instructor
          Row(
            children: [
              const Icon(Icons.person_outline_rounded, size: 14, color: AppColors.textSecondaryLight),
              const SizedBox(width: 5),
              Text(
                lecture.instructor,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textPrimaryLight,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),

          // Hall
          Row(
            children: [
              const Icon(Icons.room_outlined, size: 14, color: AppColors.textSecondaryLight),
              const SizedBox(width: 5),
              Text(
                lecture.hall,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondaryLight,
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
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.description_outlined, size: 18, color: Color(0xFF2563EB)),
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
                            color: AppColors.textPrimaryLight,
                            fontSize: 11,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (lecture.attachmentSize != null)
                          Text(
                            lecture.attachmentSize!,
                            style: AppTypography.bodySmall.copyWith(
                              fontSize: 10,
                              color: AppColors.textSecondaryLight,
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
                      child: const Icon(Icons.download_rounded, size: 18, color: AppColors.primary),
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
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    lecture.groupSlot!,
                    style: AppTypography.badgeText.copyWith(
                      fontSize: 11,
                      color: AppColors.textPrimaryLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => onViewRubric?.call(lecture),
                  child: Text(
                    lecture.rubricLabel ?? 'View Rubric',
                    style: AppTypography.badgeText.copyWith(
                      color: AppColors.primary,
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
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDF4),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFBBF7D0)),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.bookmark_added_rounded, color: Colors.white, size: 20),
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
                    color: AppColors.textPrimaryLight,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${lecture.hall} • ${lecture.startTime}',
                  style: AppTypography.bodySmall.copyWith(
                    fontSize: 11,
                    color: AppColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => onCheckInReservation?.call(lecture),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primary,
              elevation: 0,
              side: const BorderSide(color: AppColors.primary, width: 1.2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              minimumSize: const Size(0, 34),
            ),
            child: Text(
              lecture.reservationButton ?? 'Check In',
              style: AppTypography.badgeText.copyWith(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
