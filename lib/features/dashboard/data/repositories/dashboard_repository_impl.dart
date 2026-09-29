import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/dashboard_entities.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/dashboard_local_data_source.dart';
import '../datasources/dashboard_remote_data_source.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;
  final DashboardLocalDataSource localDataSource;

  DashboardRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, DashboardDataEntity>> getDashboardData() async {
    try {
      // 1. Fetch remote data (asset-based REST API simulation)
      final remoteData = await remoteDataSource.getDashboardData();

      // 2. Cache the raw payload locally
      await localDataSource.cacheDashboardData(remoteData);

      // 3. Apply local persistent mutation flags (e.g., event registration)
      final isRegistered = await localDataSource.isEventRegistered(remoteData.featuredEvent.id);
      final resolvedData = remoteData.copyWith(
        featuredEvent: remoteData.featuredEvent.copyWith(
          isRegistered: isRegistered,
          buttonLabel: isRegistered ? 'Registered ✓' : remoteData.featuredEvent.buttonLabel,
        ),
      );

      return Right(resolvedData);
    } on ServerException catch (e) {
      // Offline fallback: attempt to serve from local storage cache
      try {
        final cachedData = await localDataSource.getCachedDashboardData();
        if (cachedData != null) {
          final isRegistered = await localDataSource.isEventRegistered(cachedData.featuredEvent.id);
          return Right(
            cachedData.copyWith(
              featuredEvent: cachedData.featuredEvent.copyWith(
                isRegistered: isRegistered,
                buttonLabel: isRegistered ? 'Registered ✓' : cachedData.featuredEvent.buttonLabel,
              ),
            ),
          );
        }
      } catch (_) {}

      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, DashboardDataEntity>> registerEvent(String eventId) async {
    try {
      // 1. Persist mutation locally
      await localDataSource.setEventRegistered(eventId, true);

      // 2. Return the updated dashboard entity with the new state applied
      return await getDashboardData();
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
