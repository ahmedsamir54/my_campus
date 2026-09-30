import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/routine_entities.dart';
import '../../domain/repositories/routine_repository.dart';
import '../datasources/routine_local_data_source.dart';
import '../datasources/routine_remote_data_source.dart';
import '../models/routine_models.dart';

class RoutineRepositoryImpl implements RoutineRepository {
  final RoutineRemoteDataSource remoteDataSource;
  final RoutineLocalDataSource localDataSource;

  RoutineRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, WeeklyRoutineEntity>> getWeeklyRoutine() async {
    try {
      // 1. Fetch remote data (asset-based REST API simulation)
      final remoteRoutine = await remoteDataSource.getWeeklyRoutine();

      // 2. Cache locally
      await localDataSource.cacheWeeklyRoutine(remoteRoutine);

      // 3. Resolve selected day (last selected or default to today)
      final lastSelectedDay = await localDataSource.getLastSelectedDay();
      final resolvedRoutine = _applySelectedDay(remoteRoutine, lastSelectedDay);

      return Right(resolvedRoutine);
    } on ServerException catch (e) {
      // Offline fallback: serve from local storage cache
      try {
        final cachedRoutine = await localDataSource.getCachedWeeklyRoutine();
        if (cachedRoutine != null) {
          final lastSelectedDay = await localDataSource.getLastSelectedDay();
          final resolvedRoutine = _applySelectedDay(cachedRoutine, lastSelectedDay);
          return Right(resolvedRoutine);
        }
      } catch (_) {}

      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, WeeklyRoutineEntity>> selectDay(String dayName) async {
    try {
      await localDataSource.setLastSelectedDay(dayName);
      return await getWeeklyRoutine();
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  WeeklyRoutineEntity _applySelectedDay(WeeklyRoutineModel routine, String? targetDayName) {
    final targetName = targetDayName ?? (routine.days.firstWhere((d) => d.isToday, orElse: () => routine.days.first).dayName);

    final updatedDays = routine.days.map((day) {
      final isSelected = day.dayName == targetName;
      return day.copyWith(isSelected: isSelected);
    }).toList();

    final selectedDay = updatedDays.firstWhere(
      (d) => d.dayName == targetName,
      orElse: () => updatedDays.first,
    );

    return routine.copyWith(
      days: updatedDays,
      selectedDay: selectedDay,
    );
  }
}
