import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/profile_entities.dart';
import '../repositories/profile_repository.dart';

class ToggleSettingParams extends Equatable {
  final bool enabled;

  const ToggleSettingParams({required this.enabled});

  @override
  List<Object?> get props => [enabled];
}

class ToggleBiometricsUseCase
    implements UseCase<ProfileSettingsEntity, ToggleSettingParams> {
  final ProfileRepository repository;

  ToggleBiometricsUseCase({required this.repository});

  @override
  Future<Either<Failure, ProfileSettingsEntity>> call(
      ToggleSettingParams params) async {
    return await repository.toggleBiometrics(params.enabled);
  }
}

class ToggleNotificationsUseCase
    implements UseCase<ProfileSettingsEntity, ToggleSettingParams> {
  final ProfileRepository repository;

  ToggleNotificationsUseCase({required this.repository});

  @override
  Future<Either<Failure, ProfileSettingsEntity>> call(
      ToggleSettingParams params) async {
    return await repository.toggleNotifications(params.enabled);
  }
}
