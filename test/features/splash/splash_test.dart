import 'package:flutter_test/flutter_test.dart';
import 'package:my_campus/core/routes/app_launch_destination.dart';
import 'package:my_campus/core/usecases/usecase.dart';
import 'package:my_campus/features/splash/data/datasources/splash_local_data_source.dart';
import 'package:my_campus/features/splash/data/repositories/splash_repository_impl.dart';
import 'package:my_campus/features/splash/domain/usecases/resolve_initial_route_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SplashLocalDataSourceImpl', () {
    test('resolves to Onboarding when has_completed_onboarding is not set', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final dataSource = SplashLocalDataSourceImpl(sharedPreferences: prefs);

      final destination = await dataSource.resolveInitialRoute();
      expect(destination, AppLaunchDestination.onboarding);
    });

    test('resolves to Login when has_completed_onboarding is true but no token is cached', () async {
      SharedPreferences.setMockInitialValues({
        SplashLocalDataSourceImpl.kHasCompletedOnboarding: true,
      });
      final prefs = await SharedPreferences.getInstance();
      final dataSource = SplashLocalDataSourceImpl(sharedPreferences: prefs);

      final destination = await dataSource.resolveInitialRoute();
      expect(destination, AppLaunchDestination.login);
    });

    test('resolves to Dashboard when has_completed_onboarding is true and token exists', () async {
      SharedPreferences.setMockInitialValues({
        SplashLocalDataSourceImpl.kHasCompletedOnboarding: true,
        SplashLocalDataSourceImpl.kAuthToken: 'valid_jwt_token',
      });
      final prefs = await SharedPreferences.getInstance();
      final dataSource = SplashLocalDataSourceImpl(sharedPreferences: prefs);

      final destination = await dataSource.resolveInitialRoute();
      expect(destination, AppLaunchDestination.dashboard);
    });
  });

  group('SplashRepositoryImpl & ResolveInitialRouteUseCase', () {
    test('ResolveInitialRouteUseCase returns Right(AppLaunchDestination)', () async {
      SharedPreferences.setMockInitialValues({
        SplashLocalDataSourceImpl.kHasCompletedOnboarding: true,
        SplashLocalDataSourceImpl.kAuthSessionToken: 'session_token',
      });
      final prefs = await SharedPreferences.getInstance();
      final dataSource = SplashLocalDataSourceImpl(sharedPreferences: prefs);
      final repository = SplashRepositoryImpl(localDataSource: dataSource);
      final useCase = ResolveInitialRouteUseCase(repository: repository);

      final result = await useCase(const NoParams());

      expect(result.isRight(), true);
      result.fold(
        (failure) => fail('Expected Right but got Left'),
        (destination) => expect(destination, AppLaunchDestination.dashboard),
      );
    });
  });
}
