import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/routine_entities.dart';
import '../repositories/routine_repository.dart';

class SelectRoutineDayUseCase implements UseCase<WeeklyRoutineEntity, String> {
  final RoutineRepository repository;

  SelectRoutineDayUseCase({required this.repository});

  @override
  Future<Either<Failure, WeeklyRoutineEntity>> call(String dayName) async {
    return await repository.selectDay(dayName);
  }
}
