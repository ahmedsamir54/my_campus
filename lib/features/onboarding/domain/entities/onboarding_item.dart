import 'package:equatable/equatable.dart';

class OnboardingItem extends Equatable {
  final String imagePath;
  final String titlePrefix;
  final String titleHighlight;
  final String description;
  final String topBadgeText;
  final String topBadgeIcon;
  final String bottomBadgeText;

  const OnboardingItem({
    required this.imagePath,
    required this.titlePrefix,
    required this.titleHighlight,
    required this.description,
    required this.topBadgeText,
    this.topBadgeIcon = 'check',
    required this.bottomBadgeText,
  });

  @override
  List<Object?> get props => [
        imagePath,
        titlePrefix,
        titleHighlight,
        description,
        topBadgeText,
        topBadgeIcon,
        bottomBadgeText,
      ];
}
