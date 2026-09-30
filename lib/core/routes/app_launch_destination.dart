import 'package:shared_preferences/shared_preferences.dart';
import '../../features/onboarding/data/datasources/onboarding_local_data_source.dart';

enum AppLaunchDestination {
  onboarding,
  login,
  dashboard,
}

AppLaunchDestination resolveAppLaunchDestination(SharedPreferences sharedPreferences) {
  final bool hasCompletedOnboarding =
      sharedPreferences.getBool(OnboardingLocalDataSourceImpl.kHasCompletedOnboarding) ?? false;
  final String? authToken = sharedPreferences.getString('auth_token') ??
      sharedPreferences.getString('auth_session_token_key');

  if (!hasCompletedOnboarding) {
    return AppLaunchDestination.onboarding;
  } else if (authToken == null || authToken.isEmpty) {
    return AppLaunchDestination.login;
  } else {
    return AppLaunchDestination.dashboard;
  }
}
