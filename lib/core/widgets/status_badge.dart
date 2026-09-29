import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_typography.dart';

enum BadgeType { success, warning, danger, info, primary, neutral }

class StatusBadge extends StatelessWidget {
  final String label;
  final BadgeType type;
  final IconData? icon;
  final bool hasDot;
  final Color? customBgColor;
  final Color? customTextColor;
  final EdgeInsetsGeometry padding;

  const StatusBadge({
    super.key,
    required this.label,
    this.type = BadgeType.primary,
    this.icon,
    this.hasDot = false,
    this.customBgColor,
    this.customTextColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color text;

    switch (type) {
      case BadgeType.success:
        bg = AppColors.successLight;
        text = AppColors.success;
        break;
      case BadgeType.warning:
        bg = AppColors.warningLight;
        text = AppColors.warning;
        break;
      case BadgeType.danger:
        bg = AppColors.dangerLight;
        text = AppColors.danger;
        break;
      case BadgeType.info:
        bg = AppColors.infoLight;
        text = AppColors.info;
        break;
      case BadgeType.neutral:
        bg = const Color(0xFFF1F5F9);
        text = AppColors.textSecondaryLight;
        break;
      case BadgeType.primary:
        bg = AppColors.primaryLight;
        text = AppColors.primaryDark;
        break;
    }

    if (customBgColor != null) bg = customBgColor!;
    if (customTextColor != null) text = customTextColor!;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hasDot) ...[
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: text,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 5),
          ],
          if (icon != null) ...[
            Icon(icon, size: 13, color: text),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: AppTypography.badgeText.copyWith(
              color: text,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
