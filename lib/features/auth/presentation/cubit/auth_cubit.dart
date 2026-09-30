import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/biometric_login_usecase.dart';
import '../../domain/usecases/login_with_credentials_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginWithCredentialsUseCase loginWithCredentialsUseCase;
  final BiometricLoginUseCase biometricLoginUseCase;
  final AuthRepository authRepository;

  AuthCubit({
    required this.loginWithCredentialsUseCase,
    required this.biometricLoginUseCase,
    required this.authRepository,
  }) : super(AuthInitial());

  Future<void> checkAuthStatus() async {
    final result = await authRepository.getCurrentUser();
    result.fold(
      (failure) => emit(Unauthenticated()),
      (user) {
        if (user != null) {
          emit(Authenticated(user: user));
        } else {
          emit(Unauthenticated());
        }
      },
    );
  }

  Future<void> login({
    required String studentIdOrEmail,
    required String password,
    bool rememberMe = true,
  }) async {
    emit(AuthLoading());

    final result = await loginWithCredentialsUseCase(
      LoginParams(
        studentIdOrEmail: studentIdOrEmail,
        password: password,
        rememberMe: rememberMe,
      ),
    );

    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (user) => emit(Authenticated(user: user)),
    );
  }

  Future<void> loginWithBiometrics() async {
    emit(AuthLoading());

    final result = await biometricLoginUseCase(const NoParams());

    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (user) => emit(Authenticated(user: user)),
    );
  }

  Future<void> logout() async {
    await authRepository.logout();
    emit(Unauthenticated());
  }
}
