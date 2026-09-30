import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/routine_entities.dart';

abstract class RoutineRepository {
  Future<Either<Failure, WeeklyRoutineEntity>> getWeeklyRoutine();
  Future<Either<Failure, WeeklyRoutineEntity>> selectDay(String dayName);
}
