import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/routes/app_launch_destination.dart';

abstract class SplashLocalDataSource {
  Future<AppLaunchDestination> resolveInitialRoute();
  Future<bool> hasCompletedOnboarding();
  Future<String?> getAuthToken();
}

class SplashLocalDataSourceImpl implements SplashLocalDataSource {
  static const String kHasCompletedOnboarding = 'has_completed_onboarding';
  static const String kAuthToken = 'auth_token';
  static const String kAuthSessionToken = 'auth_session_token_key';

  final SharedPreferences sharedPreferences;

  SplashLocalDataSourceImpl({required this.sharedPreferences});

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
  Future<String?> getAuthToken() async {
    try {
      return sharedPreferences.getString(kAuthToken) ??
          sharedPreferences.getString(kAuthSessionToken);
    } catch (e) {
      throw CacheException(
        message: 'Failed to read auth token: ${e.toString()}',
      );
    }
  }

  @override
  Future<AppLaunchDestination> resolveInitialRoute() async {
    try {
      final hasCompleted = await hasCompletedOnboarding();
      final token = await getAuthToken();

      if (!hasCompleted) {
        return AppLaunchDestination.onboarding;
      } else if (token == null || token.isEmpty) {
        return AppLaunchDestination.login;
      } else {
        return AppLaunchDestination.dashboard;
      }
    } catch (e) {
      throw CacheException(
        message: 'Failed to resolve initial route: ${e.toString()}',
      );
    }
  }
}
