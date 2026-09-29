import 'package:flutter/material.dart';
import 'package:my_campus/core/constants/app_colors.dart';
import 'package:my_campus/core/constants/app_typography.dart';
import '../../domain/entities/dashboard_entities.dart';

class QuickActionsGrid extends StatelessWidget {
  final List<QuickActionItemEntity> actions;
  final String semester;
  final Function(QuickActionItemEntity) onActionTap;

  const QuickActionsGrid({
    super.key,
    required this.actions,
    required this.semester,
    required this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'QUICK ACTIONS',
              style: AppTypography.labelBold.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimaryLight,
                letterSpacing: 0.6,
              ),
            ),
            Text(
              semester,
              style: AppTypography.bodySmall.copyWith(
                fontSize: 11,
                color: AppColors.textSecondaryLight,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // 4x2 Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: actions.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.85,
          ),
          itemBuilder: (context, index) {
            final item = actions[index];
            final config = _getTileConfig(item.id);
            final isAttendance = item.id == 'attendance';

            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => onActionTap(item),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isAttendance ? AppColors.primary : AppColors.borderSubtle,
                      width: isAttendance ? 1.5 : 1.0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Badge for Attendance (94%)
                      if (item.badge != null)
                        Positioned(
                          top: -6,
                          right: -4,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              item.badge!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      // Content
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: config.bgColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                config.icon,
                                color: config.iconColor,
                                size: 20,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item.label,
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.textPrimaryLight,
                                fontWeight: FontWeight.w600,
                                fontSize: 11,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  _TileConfig _getTileConfig(String id) {
    switch (id) {
      case 'notices':
        return _TileConfig(
          icon: Icons.description_outlined,
          bgColor: const Color(0xFFEFF6FF),
          iconColor: const Color(0xFF2563EB),
        );
      case 'classes':
        return _TileConfig(
          icon: Icons.laptop_chromebook_rounded,
          bgColor: const Color(0xFFE6F9F5),
          iconColor: const Color(0xFF0D9488),
        );
      case 'attendance':
        return _TileConfig(
          icon: Icons.event_available_rounded,
          bgColor: const Color(0xFFFDF2F8),
          iconColor: const Color(0xFFDB2777),
        );
      case 'results':
        return _TileConfig(
          icon: Icons.bar_chart_rounded,
          bgColor: const Color(0xFFECFDF5),
          iconColor: const Color(0xFF059669),
        );
      case 'assignments':
        return _TileConfig(
          icon: Icons.assignment_turned_in_outlined,
          bgColor: const Color(0xFFF5F3FF),
          iconColor: const Color(0xFF7C3AED),
        );
      case 'events':
        return _TileConfig(
          icon: Icons.calendar_month_outlined,
          bgColor: const Color(0xFFFFF7ED),
          iconColor: const Color(0xFFEA580C),
        );
      case 'profile':
        return _TileConfig(
          icon: Icons.person_outline_rounded,
          bgColor: const Color(0xFFF0FDF4),
          iconColor: const Color(0xFF16A34A),
        );
      case 'more':
      default:
        return _TileConfig(
          icon: Icons.more_horiz_rounded,
          bgColor: const Color(0xFFF1F5F9),
          iconColor: const Color(0xFF64748B),
        );
    }
  }
}

class _TileConfig {
  final IconData icon;
  final Color bgColor;
  final Color iconColor;

  _TileConfig({
    required this.icon,
    required this.bgColor,
    required this.iconColor,
  });
}
