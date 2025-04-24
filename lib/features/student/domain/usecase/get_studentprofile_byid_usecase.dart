

import 'package:dartz/dartz.dart';
import 'package:scholarshuip_finder_app/app/usecase/usecase.dart';
import 'package:scholarshuip_finder_app/core/error/failure.dart';
import 'package:scholarshuip_finder_app/features/student/data/repository/remote_student_profile_repository.dart';

class GetStudentProfileByIdUseCase implements UsecaseWithoutParams{
  final StudentProfileRemoteRepository repository;
  GetStudentProfileByIdUseCase(this.repository);
  @override
  Future<Either<Failure, dynamic>> call()async {
    try {
      final result = await repository.getStudentProfileById();

      return result.fold(
            (failure) => Left(failure),
            (course) => Right(course),
      );
    }catch(e){
      return Left(ApiFailure(message: e.toString()));
    }

  }

}