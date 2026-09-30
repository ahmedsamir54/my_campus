import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/onboarding_item.dart';
import '../repositories/onboarding_repository.dart';

class GetOnboardingItemsUseCase implements UseCase<List<OnboardingItem>, NoParams> {
  final OnboardingRepository repository;

  GetOnboardingItemsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<OnboardingItem>>> call(NoParams params) async {
    return await repository.getOnboardingItems();
  }
}
