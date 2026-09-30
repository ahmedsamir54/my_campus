import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/routine_entities.dart';
import '../repositories/routine_repository.dart';

class GetWeeklyRoutineUseCase implements UseCase<WeeklyRoutineEntity, NoParams> {
  final RoutineRepository repository;

  GetWeeklyRoutineUseCase({required this.repository});

  @override
  Future<Either<Failure, WeeklyRoutineEntity>> call(NoParams params) async {
    return await repository.getWeeklyRoutine();
  }
}
