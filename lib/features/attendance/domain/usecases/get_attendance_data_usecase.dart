import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/attendance_entities.dart';
import '../repositories/attendance_repository.dart';

class GetAttendanceDataUseCase implements UseCase<AttendanceDataEntity, NoParams> {
  final AttendanceRepository repository;

  GetAttendanceDataUseCase({required this.repository});

  @override
  Future<Either<Failure, AttendanceDataEntity>> call(NoParams params) async {
    return await repository.getAttendanceData();
  }
}
