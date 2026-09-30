import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/auth_user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthUserEntity>> loginWithCredentials({
    required String studentIdOrEmail,
    required String password,
    bool rememberMe = true,
  });

  Future<Either<Failure, AuthUserEntity>> loginWithBiometrics();

  Future<Either<Failure, AuthUserEntity?>> getCurrentUser();

  Future<Either<Failure, void>> logout();
}
