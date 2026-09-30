import 'package:flutter_test/flutter_test.dart';
import 'package:my_campus/core/routes/app_launch_destination.dart';
import 'package:my_campus/features/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:my_campus/features/onboarding/data/models/onboarding_item_model.dart';
import 'package:my_campus/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:my_campus/features/onboarding/domain/usecases/complete_onboarding_usecase.dart';
import 'package:my_campus/features/onboarding/domain/usecases/get_onboarding_items_usecase.dart';
import 'package:my_campus/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('OnboardingItemModel', () {
    test('should properly serialize to and from JSON', () {
      const model = OnboardingItemModel(
        imagePath: 'assets/images/onboarding_campus.jpg',
        titlePrefix: 'Your Entire Campus Life,\n',
        titleHighlight: 'Elevated & Unified',
        description: 'Test description',
        topBadgeText: 'Verified Cloud',
        topBadgeIcon: 'check',
        bottomBadgeText: 'Live Sync',
      );

      final jsonMap = model.toJson();
      final parsed = OnboardingItemModel.fromJson(jsonMap);

      expect(parsed.titleHighlight, 'Elevated & Unified');
      expect(parsed.topBadgeIcon, 'check');
      expect(parsed.bottomBadgeText, 'Live Sync');
    });
  });

  group('Onboarding Lifecycle & Persistence', () {
    test('enforces kHasCompletedOnboarding persistence flag in SharedPreferences', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final dataSource = OnboardingLocalDataSourceImpl(sharedPreferences: prefs);

      // Initially not completed
      expect(await dataSource.hasCompletedOnboarding(), false);

      // Mark completed
      await dataSource.setCompletedOnboarding();
      expect(await dataSource.hasCompletedOnboarding(), true);
      expect(prefs.getBool(OnboardingLocalDataSourceImpl.kHasCompletedOnboarding), true);
    });

    test('OnboardingRepositoryImpl correctly delegates to local data source', () async {
      SharedPreferences.setMockInitialValues({
        OnboardingLocalDataSourceImpl.kHasCompletedOnboarding: false,
      });
      final prefs = await SharedPreferences.getInstance();
      final dataSource = OnboardingLocalDataSourceImpl(sharedPreferences: prefs);
      final repo = OnboardingRepositoryImpl(localDataSource: dataSource);

      final initialCheck = await repo.hasCompletedOnboarding();
      expect(initialCheck.isRight(), true);
      initialCheck.fold((l) => fail('should succeed'), (r) => expect(r, false));

      final completeResult = await repo.completeOnboarding();
      expect(completeResult.isRight(), true);

      final secondCheck = await repo.hasCompletedOnboarding();
      secondCheck.fold((l) => fail('should succeed'), (r) => expect(r, true));
    });

    test('OnboardingCubit transitions page index and completes onboarding', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final dataSource = OnboardingLocalDataSourceImpl(sharedPreferences: prefs);
      final repo = OnboardingRepositoryImpl(localDataSource: dataSource);
      final getItemsUseCase = GetOnboardingItemsUseCase(repository: repo);
      final completeUseCase = CompleteOnboardingUseCase(repository: repo);

      final cubit = OnboardingCubit(
        getOnboardingItemsUseCase: getItemsUseCase,
        completeOnboardingUseCase: completeUseCase,
      );

      await cubit.loadOnboarding();
      expect(cubit.state.items.length, 3);
      expect(cubit.state.currentIndex, 0);

      cubit.onPageChanged(1);
      expect(cubit.state.currentIndex, 1);

      cubit.onPageChanged(2);
      expect(cubit.state.currentIndex, 2);
      expect(cubit.state.isLastPage, true);

      await cubit.completeOnboarding();
      expect(cubit.state.isCompleted, true);
      expect(await dataSource.hasCompletedOnboarding(), true);
    });
  });

  group('resolveAppLaunchDestination Lifecycle Logic', () {
    test('routes to Onboarding when has_completed_onboarding is false or missing', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      final destination = resolveAppLaunchDestination(prefs);
      expect(destination, AppLaunchDestination.onboarding);
    });

    test('routes to Login when has_completed_onboarding is true but no token is stored', () async {
      SharedPreferences.setMockInitialValues({
        'has_completed_onboarding': true,
      });
      final prefs = await SharedPreferences.getInstance();

      final destination = resolveAppLaunchDestination(prefs);
      expect(destination, AppLaunchDestination.login);
    });

    test('routes to Dashboard when has_completed_onboarding is true and auth_token is present', () async {
      SharedPreferences.setMockInitialValues({
        'has_completed_onboarding': true,
        'auth_token': 'test_mock_jwt_token_2026',
      });
      final prefs = await SharedPreferences.getInstance();

      final destination = resolveAppLaunchDestination(prefs);
      expect(destination, AppLaunchDestination.dashboard);
    });

    test('never returns onboarding once has_completed_onboarding is set to true', () async {
      SharedPreferences.setMockInitialValues({
        'has_completed_onboarding': true,
      });
      final prefs = await SharedPreferences.getInstance();

      final destination = resolveAppLaunchDestination(prefs);
      expect(destination != AppLaunchDestination.onboarding, true);
    });
  });
}
