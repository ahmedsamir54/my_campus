import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/routes/app_launch_destination.dart';

abstract class SplashRepository {
  Future<Either<Failure, AppLaunchDestination>> resolveInitialRoute();
}
