import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../domain/entities/attendance_entities.dart';

class BunkSimulatorBottomSheet extends StatefulWidget {
  final AttendanceDataEntity attendanceData;
  final Map<String, int> initialSkips;
  final Function(String courseId, int skips) onSkipsChanged;
  final VoidCallback onReset;

  const BunkSimulatorBottomSheet({
    super.key,
    required this.attendanceData,
    required this.initialSkips,
    required this.onSkipsChanged,
    required this.onReset,
  });

  @override
  State<BunkSimulatorBottomSheet> createState() =>
      _BunkSimulatorBottomSheetState();
}

class _BunkSimulatorBottomSheetState extends State<BunkSimulatorBottomSheet> {
  late Map<String, int> _skips;

  @override
  void initState() {
    super.initState();
    _skips = Map<String, int>.from(widget.initialSkips);
  }

  void _incrementSkip(String courseId) {
    setState(() {
      final current = _skips[courseId] ?? 0;
      final updated = current + 1;
      _skips[courseId] = updated;
      widget.onSkipsChanged(courseId, updated);
    });
  }

  void _decrementSkip(String courseId) {
    setState(() {
      final current = _skips[courseId] ?? 0;
      if (current > 0) {
        final updated = current - 1;
        if (updated == 0) {
          _skips.remove(courseId);
        } else {
          _skips[courseId] = updated;
        }
        widget.onSkipsChanged(courseId, updated);
      }
    });
  }

  void _handleReset() {
    setState(() {
      _skips.clear();
      widget.onReset();
    });
  }

  @override
  Widget build(BuildContext context) {
    final summary = widget.attendanceData.summary;
    final courses = widget.attendanceData.courses;
    final hasActiveSkips = _skips.values.any((s) => s > 0);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag Handle
          const SizedBox(height: 12),
          Center(
            child: Container(
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bunk & Absence Simulator',
                      style: AppTypography.heading2.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Simulate missed lectures vs 75% rule',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                if (hasActiveSkips)
                  TextButton.icon(
                    onPressed: _handleReset,
                    icon: const Icon(Icons.refresh_rounded, size: 16),
                    label: const Text('Reset'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.danger,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Real-time Impact Banner
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: summary.isEligible
                    ? AppColors.primaryLight
                    : AppColors.dangerLight,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: summary.isEligible
                      ? AppColors.primary.withValues(alpha: 0.3)
                      : AppColors.danger.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    summary.isEligible
                        ? Icons.verified_user_rounded
                        : Icons.dangerous_rounded,
                    color: summary.isEligible
                        ? AppColors.primary
                        : AppColors.danger,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          summary.isEligible
                              ? 'Projected Attendance: ${summary.overallPercentage.toStringAsFixed(1)}%'
                              : 'Exam Disqualification Warning!',
                          style: AppTypography.bodyLarge.copyWith(
                            fontWeight: FontWeight.bold,
                            color: summary.isEligible
                                ? AppColors.primaryDark
                                : AppColors.danger,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          summary.isEligible
                              ? 'Status: Cleared for End-Semester Examinations'
                              : 'One or more subjects fell below the 75% boundary!',
                          style: AppTypography.caption.copyWith(
                            color: summary.isEligible
                                ? AppColors.textSecondary
                                : AppColors.danger,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          const Divider(height: 1),

          // Course Steppers List
          Flexible(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shrinkWrap: true,
              itemCount: courses.length,
              separatorBuilder: (_, __) => const Divider(height: 16),
              itemBuilder: (context, index) {
                final course = courses[index];
                final currentSkips = _skips[course.courseId] ?? 0;

                Color statusColor;
                if (course.percentage >= 85.0) {
                  statusColor = AppColors.primary;
                } else if (course.percentage >= 75.0) {
                  statusColor = AppColors.warning;
                } else {
                  statusColor = AppColors.danger;
                }

                return Row(
                  children: [
                    // Course Title & Percentage
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                course.courseCode,
                                style: AppTypography.caption.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  course.courseName,
                                  style: AppTypography.bodyMedium.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                '${course.percentage.toStringAsFixed(1)}%',
                                style: AppTypography.bodySmall.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: statusColor,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '• ${course.attended}/${course.conducted} lectures',
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.textTertiary,
                                ),
                              ),
                            ],
                          ),
                          if (currentSkips > 0) ...[
                            const SizedBox(height: 2),
                            Text(
                              '+$currentSkips simulated missed class${currentSkips > 1 ? 'es' : ''}',
                              style: AppTypography.caption.copyWith(
                                color: AppColors.danger,
                                fontWeight: FontWeight.w600,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    // Stepper Controls
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.backgroundLight,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove, size: 16),
                            color: currentSkips > 0
                                ? AppColors.textPrimary
                                : Colors.grey.shade400,
                            padding: const EdgeInsets.all(6),
                            constraints: const BoxConstraints(),
                            onPressed: currentSkips > 0
                                ? () => _decrementSkip(course.courseId)
                                : null,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              '$currentSkips',
                              style: AppTypography.bodyMedium.copyWith(
                                fontWeight: FontWeight.bold,
                                color: currentSkips > 0
                                    ? AppColors.primary
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add, size: 16),
                            color: AppColors.primary,
                            padding: const EdgeInsets.all(6),
                            constraints: const BoxConstraints(),
                            onPressed: () => _incrementSkip(course.courseId),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // Bottom Action
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Apply & View Projections',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
