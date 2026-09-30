import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/attendance_entities.dart';

abstract class AttendanceRepository {
  Future<Either<Failure, AttendanceDataEntity>> getAttendanceData();
  Future<Either<Failure, AttendanceDataEntity>> simulateAbsence({
    required Map<String, int> hypotheticalSkips,
  });
}
