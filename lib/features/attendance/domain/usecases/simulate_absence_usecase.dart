import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/attendance_entities.dart';
import '../repositories/attendance_repository.dart';

class SimulateAbsenceParams extends Equatable {
  final Map<String, int> hypotheticalSkips;

  const SimulateAbsenceParams({required this.hypotheticalSkips});

  @override
  List<Object?> get props => [hypotheticalSkips];
}

class SimulateAbsenceUseCase
    implements UseCase<AttendanceDataEntity, SimulateAbsenceParams> {
  final AttendanceRepository repository;

  SimulateAbsenceUseCase({required this.repository});

  @override
  Future<Either<Failure, AttendanceDataEntity>> call(
      SimulateAbsenceParams params) async {
    return await repository.simulateAbsence(
      hypotheticalSkips: params.hypotheticalSkips,
    );
  }
}
