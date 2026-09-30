import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/profile_entities.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_local_data_source.dart';
import '../datasources/profile_remote_data_source.dart';
import '../models/profile_models.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final ProfileLocalDataSource localDataSource;

  ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, ProfileDataEntity>> getStudentProfile() async {
    try {
      // 1. Fetch remote profile data
      final remoteProfile = await remoteDataSource.getStudentProfile();

      // 2. Overlay any locally stored settings toggles
      final biometrics = await localDataSource.getBiometricsEnabled();
      final notifications = await localDataSource.getNotificationsEnabled();

      final updatedSettings = remoteProfile.settings.copyWith(
        biometricsEnabled: biometrics,
        notificationsEnabled: notifications,
      );

      final mergedData = ProfileDataModel.fromEntity(
        remoteProfile.copyWith(settings: updatedSettings),
      );

      // 3. Cache merged profile locally
      await localDataSource.cacheProfile(mergedData);

      return Right(mergedData);
    } on ServerException catch (e) {
      // Offline fallback: serve from local cache
      try {
        final cached = await localDataSource.getCachedProfile();
        if (cached != null) {
          return Right(cached);
        }
      } catch (_) {}

      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileSettingsEntity>> toggleBiometrics(
      bool enabled) async {
    try {
      await localDataSource.setBiometricsEnabled(enabled);
      final notifications = await localDataSource.getNotificationsEnabled();

      final updated = ProfileSettingsEntity(
        biometricsEnabled: enabled,
        notificationsEnabled: notifications,
        darkMode: false,
        offlineIdAccess: true,
      );

      return Right(updated);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileSettingsEntity>> toggleNotifications(
      bool enabled) async {
    try {
      await localDataSource.setNotificationsEnabled(enabled);
      final biometrics = await localDataSource.getBiometricsEnabled();

      final updated = ProfileSettingsEntity(
        biometricsEnabled: biometrics,
        notificationsEnabled: enabled,
        darkMode: false,
        offlineIdAccess: true,
      );

      return Right(updated);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
