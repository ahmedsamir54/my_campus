import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../models/onboarding_item_model.dart';

abstract class OnboardingLocalDataSource {
  Future<bool> hasCompletedOnboarding();
  Future<void> setCompletedOnboarding();
  Future<List<OnboardingItemModel>> getOnboardingSlides();
}

class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  static const String kHasCompletedOnboarding = 'has_completed_onboarding';

  final SharedPreferences sharedPreferences;

  OnboardingLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> hasCompletedOnboarding() async {
    try {
      return sharedPreferences.getBool(kHasCompletedOnboarding) ?? false;
    } catch (e) {
      throw CacheException(
        message: 'Failed to read onboarding status: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> setCompletedOnboarding() async {
    try {
      await sharedPreferences.setBool(kHasCompletedOnboarding, true);
    } catch (e) {
      throw CacheException(
        message: 'Failed to save onboarding completion: ${e.toString()}',
      );
    }
  }

  @override
  Future<List<OnboardingItemModel>> getOnboardingSlides() async {
    return const [
      OnboardingItemModel(
        imagePath: 'assets/images/onboarding_campus.jpg',
        titlePrefix: 'Your Entire Campus Life,\n',
        titleHighlight: 'Elevated & Unified',
        description:
            'Effortlessly track real-time class routines, monitor attendance eligibility, submit coursework, and connect with faculty—all in one smart portal.',
        topBadgeText: 'Verified Academic Cloud',
        topBadgeIcon: 'check',
        bottomBadgeText: 'Spring Term Live Sync',
      ),
      OnboardingItemModel(
        imagePath: 'assets/images/onboarding_attendance.jpg',
        titlePrefix: 'Attendance Intelligence\n',
        titleHighlight: '& Exam Safe-Zone',
        description:
            'Real-time attendance radar tracking the mandatory 75% threshold with smart safe-skip simulations.',
        topBadgeText: '94.2% Safe Zone',
        topBadgeIcon: 'check',
        bottomBadgeText: 'Next: CS411 Lab',
      ),
      OnboardingItemModel(
        imagePath: 'assets/images/onboarding_card.jpg',
        titlePrefix: 'Digital PVC Pass\n',
        titleHighlight: '& Instant Gate Access',
        description:
            'One-tap contactless NFC turnstile access, dynamic digital student ID, and secure campus payments.',
        topBadgeText: 'NFC Wave Tap Ready',
        topBadgeIcon: 'bolt',
        bottomBadgeText: 'ST-2026-8841 Verified',
      ),
    ];
  }
}
