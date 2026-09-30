import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/auth_user_entity.dart';
import '../repositories/auth_repository.dart';

class BiometricLoginUseCase implements UseCase<AuthUserEntity, NoParams> {
  final AuthRepository repository;

  BiometricLoginUseCase({required this.repository});

  @override
  Future<Either<Failure, AuthUserEntity>> call(NoParams params) async {
    return await repository.loginWithBiometrics();
  }
}
