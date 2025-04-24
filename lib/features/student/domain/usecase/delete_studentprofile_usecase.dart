

import 'package:dartz/dartz.dart';
import 'package:scholarshuip_finder_app/app/usecase/usecase.dart';
import 'package:scholarshuip_finder_app/core/error/failure.dart';

import '../../data/repository/remote_student_profile_repository.dart';

class DeleteStudentProfileUseCase implements UsecaseWithParams<void,String >{
  final StudentProfileRemoteRepository repository;

  DeleteStudentProfileUseCase(this.repository);
  @override
  Future<Either<Failure, void>> call(String userId)async {
    try {
      // Call repository
      final result = await repository.deleteStudentProfile(userId);

      return result.fold(
            (failure) => Left(failure),
            (_) => const Right(null),
      );
    } catch (error) {
      return Left(ApiFailure(message: error.toString()));
    }
  }

}
