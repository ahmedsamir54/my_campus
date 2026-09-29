import 'package:dartz/dartz.dart';
import 'package:my_campus/core/error/failures.dart';
import '../entities/dashboard_entities.dart';

abstract class DashboardRepository {
  Future<Either<Failure, DashboardDataEntity>> getDashboardData();
}
