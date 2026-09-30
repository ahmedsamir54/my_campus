import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../cubit/routine_cubit.dart';
import '../cubit/routine_state.dart';
import '../widgets/active_ongoing_lecture_card.dart';
import '../widgets/day_selector_strip.dart';
import '../widgets/upcoming_lecture_timeline.dart';

class RoutinePage extends StatelessWidget {
  const RoutinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: BlocBuilder<RoutineCubit, RoutineState>(
          builder: (context, state) {
            if (state is RoutineLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }

            if (state is RoutineError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline_rounded, size: 48, color: AppColors.danger),
                    const SizedBox(height: 12),
                    Text('Failed to load routine', style: AppTypography.heading3),
                    const SizedBox(height: 6),
                    Text(state.message, style: AppTypography.bodyMedium),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.read<RoutineCubit>().loadWeeklyRoutine(),
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              );
            }

            if (state is RoutineLoaded) {
              final routine = state.routine;
              final selectedDay = routine.selectedDay;
              final ongoingLecture = selectedDay.lectures.where((l) => l.isOngoing).firstOrNull;
              final remainingLectures = selectedDay.lectures.where((l) => !l.isOngoing).toList();

              return RefreshIndicator(
                color: AppColors.primary,
                onRefresh: () => context.read<RoutineCubit>().loadWeeklyRoutine(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Row: Semester / Week Selector
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.borderSubtle),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '${routine.semester} • ${routine.week}',
                                  style: AppTypography.badgeText.copyWith(
                                    fontSize: 12,
                                    color: AppColors.textPrimaryLight,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: AppColors.textSecondaryLight),
                              ],
                            ),
                          ),
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.borderSubtle),
                            ),
                            child: const Icon(Icons.calendar_today_outlined, size: 18, color: AppColors.textPrimaryLight),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // 5-Day Horizontal Date Selector
                      DaySelectorStrip(
                        days: routine.days,
                        selectedDay: selectedDay,
                        onDaySelected: (dayName) {
                          context.read<RoutineCubit>().selectDay(dayName);
                        },
                      ),
                      const SizedBox(height: 16),

                      // Daily Summary Header Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${selectedDay.lecturesCount} Lectures Scheduled Today • ${selectedDay.totalHours}',
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.textPrimaryLight,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE2E8F0),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              selectedDay.progressPercentage,
                              style: AppTypography.badgeText.copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textSecondaryLight,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Active Ongoing Lecture Card (Happening Now)
                      if (ongoingLecture != null) ...[
                        ActiveOngoingLectureCard(
                          lecture: ongoingLecture,
                          onLocateHall: () {
                            _showLocateHallModal(context, ongoingLecture);
                          },
                        ),
                        const SizedBox(height: 14),
                      ],

                      // Upcoming Lectures & Reservations
                      UpcomingLectureTimeline(
                        lectures: remainingLectures,
                        onDownloadNotes: (l) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Downloading "${l.attachmentName}"...'),
                              backgroundColor: AppColors.primaryDark,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          );
                        },
                        onViewRubric: (l) {
                          _showRubricModal(context, l);
                        },
                        onCheckInReservation: (l) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Checked in at ${l.hall}!'),
                              backgroundColor: AppColors.success,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),

                      // Download Weekly Routine Button
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Weekly routine PDF downloaded successfully! (1.2 MB)'),
                                backgroundColor: AppColors.success,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryDark,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.download_rounded, size: 18),
                              const SizedBox(width: 8),
                              Text(
                                'Download Weekly Routine',
                                style: AppTypography.labelBold.copyWith(color: Colors.white, fontSize: 13),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  '1.2 MB',
                                  style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void _showLocateHallModal(BuildContext context, dynamic lecture) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hall Wayfinding Guide',
                  style: AppTypography.heading3.copyWith(fontSize: 18),
                ),
                IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
              ],
            ),
            const SizedBox(height: 12),
            Text('${lecture.title} • ${lecture.hall}', style: AppTypography.bodyLarge),
            const SizedBox(height: 8),
            Text(
              'Route: Enter North Wing entrance -> Take elevator or stairs to 2nd Floor -> Hall B-12 is right across the faculty lounge.',
              style: AppTypography.bodyMedium,
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(ctx),
                icon: const Icon(Icons.directions_walk_rounded),
                label: const Text('Start Indoor Navigation'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRubricModal(BuildContext context, dynamic lecture) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Presentation Rubric',
                  style: AppTypography.heading3.copyWith(fontSize: 18),
                ),
                IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
              ],
            ),
            const SizedBox(height: 12),
            Text('${lecture.title} • ${lecture.groupSlot}', style: AppTypography.bodyLarge),
            const SizedBox(height: 10),
            Text('• Architecture & System Design: 40% (20 pts)\n• Live Demonstration: 30% (15 pts)\n• Q&A & Code Quality: 30% (15 pts)', style: AppTypography.bodyMedium),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
