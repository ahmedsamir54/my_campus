import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/profile_entities.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileDataEntity>> getStudentProfile();
  Future<Either<Failure, ProfileSettingsEntity>> toggleBiometrics(bool enabled);
  Future<Either<Failure, ProfileSettingsEntity>> toggleNotifications(bool enabled);
}
