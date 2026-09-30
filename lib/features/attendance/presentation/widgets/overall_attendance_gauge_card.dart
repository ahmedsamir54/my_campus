import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../domain/entities/attendance_entities.dart';

class OverallAttendanceGaugeCard extends StatelessWidget {
  final AttendanceSummaryEntity summary;
  final bool isSimulating;
  final VoidCallback? onResetSimulation;

  const OverallAttendanceGaugeCard({
    super.key,
    required this.summary,
    this.isSimulating = false,
    this.onResetSimulation,
  });

  @override
  Widget build(BuildContext context) {
    final bool isEligible = summary.isEligible;
    final double percent = (summary.overallPercentage / 100.0).clamp(0.0, 1.0);

    Color gaugeColor;
    Color gaugeBg;
    if (summary.overallPercentage >= 85.0) {
      gaugeColor = AppColors.primary;
      gaugeBg = AppColors.primaryLight;
    } else if (summary.overallPercentage >= 75.0) {
      gaugeColor = AppColors.warning;
      gaugeBg = AppColors.warningLight;
    } else {
      gaugeColor = AppColors.danger;
      gaugeBg = AppColors.dangerLight;
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSimulating
              ? AppColors.primary.withValues(alpha: 0.4)
              : AppColors.border,
          width: isSimulating ? 1.5 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Status Badge & Threshold Indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: isEligible
                      ? AppColors.primaryLight
                      : AppColors.dangerLight,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isEligible
                        ? AppColors.primary.withValues(alpha: 0.3)
                        : AppColors.danger.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isEligible
                          ? Icons.verified_rounded
                          : Icons.warning_amber_rounded,
                      size: 14,
                      color: isEligible ? AppColors.primary : AppColors.danger,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      summary.statusBadgeText,
                      style: AppTypography.caption.copyWith(
                        color: isEligible ? AppColors.primary : AppColors.danger,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.backgroundLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.flag_rounded,
                      size: 12,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Min: ${summary.minimumThreshold.toInt()}%',
                      style: AppTypography.caption.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // Main Gauge & Metrics Row
          Row(
            children: [
              // Circular Gauge
              CircularPercentIndicator(
                radius: 52.0,
                lineWidth: 10.0,
                percent: percent,
                animation: true,
                animateFromLastPercent: true,
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: gaugeColor,
                backgroundColor: gaugeBg,
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${summary.overallPercentage.toStringAsFixed(0)}%',
                      style: AppTypography.heading1.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: gaugeColor,
                      ),
                    ),
                    Text(
                      'Overall',
                      style: AppTypography.caption.copyWith(
                        fontSize: 10,
                        color: AppColors.textTertiary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 20),

              // Metrics Breakdown Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${summary.totalAttended}',
                          style: AppTypography.heading2.copyWith(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          ' / ${summary.totalConducted} Lectures',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Attended vs Total Conducted',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Safe Zone Tag
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isEligible
                            ? AppColors.primaryLight.withValues(alpha: 0.5)
                            : AppColors.dangerLight.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isEligible
                                ? Icons.trending_up_rounded
                                : Icons.trending_down_rounded,
                            size: 13,
                            color: isEligible
                                ? AppColors.primary
                                : AppColors.danger,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            isEligible
                                ? '+${(summary.overallPercentage - summary.minimumThreshold).toStringAsFixed(1)}% safe margin'
                                : '${(summary.overallPercentage - summary.minimumThreshold).toStringAsFixed(1)}% deficit',
                            style: AppTypography.caption.copyWith(
                              color: isEligible
                                  ? AppColors.primary
                                  : AppColors.danger,
                              fontWeight: FontWeight.w700,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Simulation active notice bar
          if (isSimulating) ...[
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.auto_graph_rounded,
                    size: 16,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Hypothetical Projection Active',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.primaryDark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (onResetSimulation != null)
                    GestureDetector(
                      onTap: onResetSimulation,
                      child: Text(
                        'Reset',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w800,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
