import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/onboarding_repository.dart';

class CompleteOnboardingUseCase implements UseCase<void, NoParams> {
  final OnboardingRepository repository;

  CompleteOnboardingUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.completeOnboarding();
  }
}
