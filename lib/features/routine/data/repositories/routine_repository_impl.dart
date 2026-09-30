import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/routine_entities.dart';
import '../../domain/repositories/routine_repository.dart';
import '../datasources/routine_local_data_source.dart';
import '../datasources/routine_remote_data_source.dart';

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

  WeeklyRoutineEntity _applySelectedDay(WeeklyRoutineEntity routine, String? targetDayName) {
    String targetName;
    if (targetDayName != null && targetDayName.isNotEmpty) {
      targetName = targetDayName;
    } else {
      RoutineDayEntity? todayDay;
      for (final d in routine.days) {
        if (d.isToday) {
          todayDay = d;
          break;
        }
      }
      targetName = (todayDay ?? (routine.days.isNotEmpty ? routine.days.first : null))?.dayName ?? 'Tue';
    }

    final updatedDays = routine.days.map((day) {
      final isSelected = day.dayName == targetName;
      return day.copyWith(isSelected: isSelected);
    }).toList();

    RoutineDayEntity? selectedDay;
    for (final d in updatedDays) {
      if (d.dayName == targetName) {
        selectedDay = d;
        break;
      }
    }
    selectedDay ??= updatedDays.isNotEmpty ? updatedDays.first : routine.selectedDay;

    return routine.copyWith(
      days: updatedDays,
      selectedDay: selectedDay,
    );
  }
}
