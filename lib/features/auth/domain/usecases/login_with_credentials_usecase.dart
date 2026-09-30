import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/auth_user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginParams extends Equatable {
  final String studentIdOrEmail;
  final String password;
  final bool rememberMe;

  const LoginParams({
    required this.studentIdOrEmail,
    required this.password,
    this.rememberMe = true,
  });

  @override
  List<Object?> get props => [studentIdOrEmail, password, rememberMe];
}

class LoginWithCredentialsUseCase implements UseCase<AuthUserEntity, LoginParams> {
  final AuthRepository repository;

  LoginWithCredentialsUseCase({required this.repository});

  @override
  Future<Either<Failure, AuthUserEntity>> call(LoginParams params) async {
    return await repository.loginWithCredentials(
      studentIdOrEmail: params.studentIdOrEmail,
      password: params.password,
      rememberMe: params.rememberMe,
    );
  }
}
