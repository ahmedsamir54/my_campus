import 'dart:math';
import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/attendance_entities.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../datasources/attendance_local_data_source.dart';
import '../datasources/attendance_remote_data_source.dart';
import '../models/attendance_models.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceRemoteDataSource remoteDataSource;
  final AttendanceLocalDataSource localDataSource;

  AttendanceRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, AttendanceDataEntity>> getAttendanceData() async {
    try {
      // 1. Fetch remote data (asset-based REST API simulation)
      final remoteData = await remoteDataSource.getAttendanceData();

      // 2. Cache locally
      await localDataSource.cacheAttendanceData(remoteData);

      // 3. Apply any existing cached simulations
      final simulations = await localDataSource.getCachedSimulations();
      if (simulations != null && simulations.isNotEmpty) {
        return Right(_applySimulations(remoteData, simulations));
      }

      return Right(remoteData);
    } on ServerException catch (e) {
      // Offline fallback: serve from local storage cache
      try {
        final cachedData = await localDataSource.getCachedAttendanceData();
        if (cachedData != null) {
          final simulations = await localDataSource.getCachedSimulations();
          if (simulations != null && simulations.isNotEmpty) {
            return Right(_applySimulations(cachedData, simulations));
          }
          return Right(cachedData);
        }
      } catch (_) {}

      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AttendanceDataEntity>> simulateAbsence({
    required Map<String, int> hypotheticalSkips,
  }) async {
    try {
      // 1. Save or clear simulation state
      final hasSkips = hypotheticalSkips.values.any((val) => val > 0);
      if (hasSkips) {
        await localDataSource.cacheSimulations(hypotheticalSkips);
      } else {
        await localDataSource.clearSimulations();
      }

      // 2. Retrieve base attendance data
      AttendanceDataModel? baseData =
          await localDataSource.getCachedAttendanceData();
      baseData ??= await remoteDataSource.getAttendanceData();

      // 3. Compute simulated projection
      final simulatedEntity = _applySimulations(baseData, hypotheticalSkips);
      return Right(simulatedEntity);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  AttendanceDataEntity _applySimulations(
    AttendanceDataEntity baseData,
    Map<String, int> hypotheticalSkips,
  ) {
    int totalAttended = 0;
    int totalConducted = 0;
    bool allCoursesEligible = true;

    final updatedCourses = baseData.courses.map((course) {
      final skips = hypotheticalSkips[course.courseId] ?? 0;
      final newAttended = course.attended;
      final newConducted = course.conducted + skips;
      final newPercentage = newConducted > 0
          ? double.parse(
              ((newAttended / newConducted) * 100.0).toStringAsFixed(1))
          : 100.0;

      String newStatus;
      if (newPercentage >= 85.0) {
        newStatus = 'Safe';
      } else if (newPercentage >= 75.0) {
        newStatus = 'Warning';
      } else {
        newStatus = 'At Risk';
      }

      if (newPercentage < 75.0) {
        allCoursesEligible = false;
      }

      // Max skips allowed to stay >= 75%:
      // (attended / (conducted + x)) >= 0.75 => x <= (attended / 0.75) - conducted
      final rawAllowed = ((newAttended / 0.75) - newConducted).floor();
      final newMaxSkips = max(0, rawAllowed);

      String newSafeSkipsText;
      if (newPercentage >= 85.0) {
        newSafeSkipsText = 'Can skip up to $newMaxSkips more classes safely';
      } else if (newPercentage >= 75.0) {
        newSafeSkipsText = newMaxSkips > 0
            ? 'Caution: Only $newMaxSkips safe skip remaining'
            : 'At 75% boundary! Zero skips allowed';
      } else {
        // Classes needed to restore 75%:
        // (attended + y) / (conducted + y) >= 0.75 => y >= (0.75*conducted - attended) / 0.25
        final needed =
            max(1, (((0.75 * newConducted) - newAttended) / 0.25).ceil());
        newSafeSkipsText =
            'Below 75%! Must attend next $needed classes to restore eligibility';
      }

      totalAttended += newAttended;
      totalConducted += newConducted;

      return course.copyWith(
        conducted: newConducted,
        percentage: newPercentage,
        status: newStatus,
        maxSkipsAllowed: newMaxSkips,
        safeSkipsText: newSafeSkipsText,
      );
    }).toList();

    final overallPercentage = totalConducted > 0
        ? double.parse(
            ((totalAttended / totalConducted) * 100.0).toStringAsFixed(1))
        : 100.0;

    final isEligible = allCoursesEligible && overallPercentage >= 75.0;

    final updatedSummary = baseData.summary.copyWith(
      overallPercentage: overallPercentage,
      totalAttended: totalAttended,
      totalConducted: totalConducted,
      isEligible: isEligible,
      statusBadgeText: isEligible
          ? (hypotheticalSkips.values.any((s) => s > 0)
              ? 'Simulated: Hall Ticket Safe'
              : 'Exam Hall Ticket Cleared')
          : 'Warning: Exam Disqualification Risk',
      statusSubtitle: isEligible
          ? 'All course attendances fulfill the university 75% examination threshold.'
          : 'Attendance has fallen below the mandatory 75% criterion in one or more courses.',
    );

    return AttendanceDataEntity(
      summary: updatedSummary,
      courses: updatedCourses,
    );
  }
}
