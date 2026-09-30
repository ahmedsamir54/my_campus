import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/routes/app_launch_destination.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/splash_repository.dart';

class ResolveInitialRouteUseCase implements UseCase<AppLaunchDestination, NoParams> {
  final SplashRepository repository;

  ResolveInitialRouteUseCase({required this.repository});

  @override
  Future<Either<Failure, AppLaunchDestination>> call(NoParams params) async {
    return await repository.resolveInitialRoute();
  }
}
