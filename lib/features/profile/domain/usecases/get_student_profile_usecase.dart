import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/profile_entities.dart';
import '../repositories/profile_repository.dart';

class GetStudentProfileUseCase implements UseCase<ProfileDataEntity, NoParams> {
  final ProfileRepository repository;

  GetStudentProfileUseCase({required this.repository});

  @override
  Future<Either<Failure, ProfileDataEntity>> call(NoParams params) async {
    return await repository.getStudentProfile();
  }
}
