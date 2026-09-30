import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/widgets/status_badge.dart';
import '../cubit/attendance_cubit.dart';
import '../cubit/attendance_state.dart';
import '../widgets/attendance_simulator_button.dart';
import '../widgets/bunk_simulator_bottom_sheet.dart';
import '../widgets/course_attendance_list.dart';
import '../widgets/overall_attendance_gauge_card.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  void _openSimulator(BuildContext context, AttendanceLoaded state) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) {
        return BunkSimulatorBottomSheet(
          attendanceData: state.data,
          initialSkips: state.simulatedSkips,
          onSkipsChanged: (courseId, skips) {
            context.read<AttendanceCubit>().simulateCourseSkips(courseId, skips);
          },
          onReset: () {
            context.read<AttendanceCubit>().resetSimulation();
          },
        );
      },
    );
  }

  void _showQrCheckInModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Classroom Attendance Check-In',
                style: AppTypography.heading2.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 6),
              Text(
                'Present this dynamic pass to your instructor scanner or scan classroom QR code',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.backgroundLight,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                ),
                child: QrImageView(
                  data: 'CAMPUS-ATTENDANCE:AHMED-SAMIR:CS201:ROOM-B12:${DateTime.now().millisecondsSinceEpoch}',
                  version: QrVersions.auto,
                  size: 180,
                  eyeStyle: const QrEyeStyle(
                    eyeShape: QrEyeShape.square,
                    color: AppColors.primary,
                  ),
                  dataModuleStyle: const QrDataModuleStyle(
                    dataModuleShape: QrDataModuleShape.square,
                    color: AppColors.primaryDark,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Dynamic Token Valid for 45s',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.primaryDark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Row(
                          children: [
                            Icon(Icons.check_circle_rounded, color: Colors.white),
                            SizedBox(width: 8),
                            Text('Attendance recorded for Data Structures (CS201)!'),
                          ],
                        ),
                        backgroundColor: AppColors.primary,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.qr_code_scanner_rounded),
                  label: const Text('Simulate Successful Scan'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Attendance Intelligence',
              style: AppTypography.heading2.copyWith(fontSize: 18),
            ),
            Text(
              'Exam Eligibility & Bunk Simulator',
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
                fontSize: 11,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 20,
                  color: AppColors.textPrimary,
                ),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        actions: [
          IconButton(
            tooltip: 'QR Check-in',
            icon: const Icon(
              Icons.qr_code_scanner_rounded,
              color: AppColors.primary,
            ),
            onPressed: () => _showQrCheckInModal(context),
          ),
          IconButton(
            tooltip: 'Refresh',
            icon: const Icon(
              Icons.refresh_rounded,
              color: AppColors.textPrimary,
            ),
            onPressed: () => context.read<AttendanceCubit>().loadAttendance(),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<AttendanceCubit, AttendanceState>(
          builder: (context, state) {
            if (state is AttendanceLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }

            if (state is AttendanceError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline_rounded,
                        size: 48,
                        color: AppColors.danger,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Failed to load attendance',
                        style: AppTypography.heading3,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        state.message,
                        style: AppTypography.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () =>
                            context.read<AttendanceCubit>().loadAttendance(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Try Again'),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is AttendanceLoaded) {
              final data = state.data;
              final summary = data.summary;
              final courses = data.courses;

              final safeCount =
                  courses.where((c) => c.status == 'Safe').length;
              final warningCount =
                  courses.where((c) => c.status == 'Warning').length;
              final atRiskCount =
                  courses.where((c) => c.status == 'At Risk').length;

              return RefreshIndicator(
                color: AppColors.primary,
                onRefresh: () =>
                    context.read<AttendanceCubit>().loadAttendance(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Row: Semester pill + Exam Clearance Badge
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: AppColors.primaryLight,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.school_rounded,
                                  size: 14,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  summary.semester,
                                  style: AppTypography.caption.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primaryDark,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          StatusBadge(
                            label: summary.isEligible
                                ? 'Hall Ticket Cleared'
                                : 'Debarred Warning',
                            type: summary.isEligible
                                ? BadgeType.success
                                : BadgeType.danger,
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      // Prominent Gauge Card
                      OverallAttendanceGaugeCard(
                        summary: summary,
                        isSimulating: state.isSimulating,
                        onResetSimulation: () {
                          context.read<AttendanceCubit>().resetSimulation();
                        },
                      ),

                      const SizedBox(height: 14),

                      // Quick Metric Summary Chips
                      Row(
                        children: [
                          Expanded(
                            child: _buildMetricTile(
                              title: 'Safe',
                              value: '$safeCount courses',
                              color: AppColors.primary,
                              bgColor: AppColors.primaryLight,
                              icon: Icons.check_circle_outline_rounded,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildMetricTile(
                              title: 'Warning',
                              value: '$warningCount courses',
                              color: AppColors.warning,
                              bgColor: AppColors.warningLight,
                              icon: Icons.error_outline_rounded,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildMetricTile(
                              title: 'At Risk',
                              value: '$atRiskCount courses',
                              color: AppColors.danger,
                              bgColor: AppColors.dangerLight,
                              icon: Icons.cancel_outlined,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      // Attendance Simulator CTA
                      AttendanceSimulatorButton(
                        isSimulating: state.isSimulating,
                        onTap: () => _openSimulator(context, state),
                      ),

                      const SizedBox(height: 20),

                      // Course-wise Breakdown Section Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Course-wise Attendance',
                                style: AppTypography.heading3.copyWith(
                                  fontSize: 17,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${courses.length} Enrolled Courses • Real-time Sync',
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.tune_rounded,
                              size: 20,
                              color: AppColors.primary,
                            ),
                            tooltip: 'Simulator',
                            onPressed: () => _openSimulator(context, state),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Course Attendance Cards List
                      CourseAttendanceList(courses: courses),

                      const SizedBox(height: 20),

                      // University Exam Policy Card
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.blueGrey.shade100),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.gavel_rounded,
                              color: Colors.blueGrey,
                              size: 22,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'University Academic Policy § 4.2',
                                    style: AppTypography.bodySmall.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey.shade800,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'A minimum aggregate attendance of 75% is strictly enforced in each individual subject to qualify for final examinations. Debarred students must submit medical appeals before Week 12.',
                                    style: AppTypography.caption.copyWith(
                                      color: Colors.blueGrey.shade600,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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

  Widget _buildMetricTile({
    required String title,
    required String value,
    required Color color,
    required Color bgColor,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 13, color: color),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: AppTypography.caption.copyWith(
                    fontWeight: FontWeight.w700,
                    color: color,
                    fontSize: 11,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  value,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textTertiary,
                    fontSize: 10,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
