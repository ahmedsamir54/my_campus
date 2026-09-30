import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/onboarding_item.dart';

abstract class OnboardingRepository {
  Future<Either<Failure, bool>> hasCompletedOnboarding();
  Future<Either<Failure, void>> completeOnboarding();
  Future<Either<Failure, List<OnboardingItem>>> getOnboardingItems();
}
