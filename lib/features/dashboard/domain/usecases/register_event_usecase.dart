import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dashboard_entities.dart';
import '../repositories/dashboard_repository.dart';

class RegisterEventUseCase implements UseCase<DashboardDataEntity, String> {
  final DashboardRepository repository;

  RegisterEventUseCase({required this.repository});

  @override
  Future<Either<Failure, DashboardDataEntity>> call(String eventId) async {
    return await repository.registerEvent(eventId);
  }
}
