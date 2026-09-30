import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../domain/entities/routine_entities.dart';

class DaySelectorStrip extends StatelessWidget {
  final List<RoutineDayEntity> days;
  final RoutineDayEntity selectedDay;
  final ValueChanged<String> onDaySelected;

  const DaySelectorStrip({
    super.key,
    required this.days,
    required this.selectedDay,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 78,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: days.map((day) {
          final isSelected = day.dayName == selectedDay.dayName;
          final isToday = day.isToday;

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => onDaySelected(day.dayName),
                  borderRadius: BorderRadius.circular(16),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primaryDark : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primaryDark
                            : AppColors.borderSubtle,
                        width: 1.2,
                      ),
                      boxShadow: [
                        if (isSelected)
                          BoxShadow(
                            color: AppColors.primaryDark.withValues(alpha: 0.25),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          )
                        else
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.02),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Day Label (e.g. Mon, TODAY, Wed)
                        Text(
                          isToday && isSelected ? 'TODAY' : day.dayName,
                          style: AppTypography.badgeText.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: isSelected
                                ? const Color(0xFF86EFAC)
                                : AppColors.textSecondaryLight,
                            letterSpacing: 0.3,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Day Number (e.g. 28, 29)
                        Text(
                          day.dayNumber,
                          style: AppTypography.heading3.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: isSelected ? Colors.white : AppColors.textPrimaryLight,
                          ),
                        ),
                        const SizedBox(height: 2),
                        // Active Indicator Dot
                        Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelected ? const Color(0xFF4ADE80) : Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
