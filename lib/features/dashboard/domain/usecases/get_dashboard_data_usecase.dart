import 'package:dartz/dartz.dart';
import 'package:my_campus/core/error/failures.dart';
import 'package:my_campus/core/usecases/usecase.dart';
import '../entities/dashboard_entities.dart';
import '../repositories/dashboard_repository.dart';

class GetDashboardDataUseCase implements UseCase<DashboardDataEntity, NoParams> {
  final DashboardRepository repository;

  GetDashboardDataUseCase({required this.repository});

  @override
  Future<Either<Failure, DashboardDataEntity>> call(NoParams params) async {
    return await repository.getDashboardData();
  }
}
