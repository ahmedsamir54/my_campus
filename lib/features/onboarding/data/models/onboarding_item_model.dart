import '../../domain/entities/onboarding_item.dart';

class OnboardingItemModel extends OnboardingItem {
  const OnboardingItemModel({
    required super.imagePath,
    required super.titlePrefix,
    required super.titleHighlight,
    required super.description,
    required super.topBadgeText,
    super.topBadgeIcon = 'check',
    required super.bottomBadgeText,
  });

  factory OnboardingItemModel.fromJson(Map<String, dynamic> json) {
    return OnboardingItemModel(
      imagePath: json['imagePath'] as String,
      titlePrefix: json['titlePrefix'] as String,
      titleHighlight: json['titleHighlight'] as String,
      description: json['description'] as String,
      topBadgeText: json['topBadgeText'] as String,
      topBadgeIcon: json['topBadgeIcon'] as String? ?? 'check',
      bottomBadgeText: json['bottomBadgeText'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imagePath': imagePath,
      'titlePrefix': titlePrefix,
      'titleHighlight': titleHighlight,
      'description': description,
      'topBadgeText': topBadgeText,
      'topBadgeIcon': topBadgeIcon,
      'bottomBadgeText': bottomBadgeText,
    };
  }
}
