import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_student_profile_usecase.dart';
import '../../domain/usecases/toggle_settings_usecases.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetStudentProfileUseCase getStudentProfileUseCase;
  final ToggleBiometricsUseCase toggleBiometricsUseCase;
  final ToggleNotificationsUseCase toggleNotificationsUseCase;

  ProfileCubit({
    required this.getStudentProfileUseCase,
    required this.toggleBiometricsUseCase,
    required this.toggleNotificationsUseCase,
  }) : super(ProfileInitial());

  Future<void> loadProfile() async {
    emit(ProfileLoading());
    final result = await getStudentProfileUseCase(const NoParams());
    result.fold(
      (failure) => emit(ProfileError(message: failure.message)),
      (data) => emit(ProfileLoaded(data: data)),
    );
  }

  void toggleIdViewMode() {
    if (state is! ProfileLoaded) return;
    final current = state as ProfileLoaded;
    emit(current.copyWith(showBarcode: !current.showBarcode));
  }

  Future<void> toggleBiometrics(bool enabled) async {
    if (state is! ProfileLoaded) return;
    final current = state as ProfileLoaded;

    final result = await toggleBiometricsUseCase(
      ToggleSettingParams(enabled: enabled),
    );

    result.fold(
      (failure) => null,
      (updatedSettings) {
        final updatedData = current.data.copyWith(settings: updatedSettings);
        emit(current.copyWith(data: updatedData));
      },
    );
  }

  Future<void> toggleNotifications(bool enabled) async {
    if (state is! ProfileLoaded) return;
    final current = state as ProfileLoaded;

    final result = await toggleNotificationsUseCase(
      ToggleSettingParams(enabled: enabled),
    );

    result.fold(
      (failure) => null,
      (updatedSettings) {
        final updatedData = current.data.copyWith(settings: updatedSettings);
        emit(current.copyWith(data: updatedData));
      },
    );
  }
}
