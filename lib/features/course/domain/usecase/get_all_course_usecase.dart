
import 'package:dartz/dartz.dart';
import 'package:scholarshuip_finder_app/core/error/failure.dart';
import 'package:scholarshuip_finder_app/features/course/data/repository/remote_course_repository.dart';
import 'package:scholarshuip_finder_app/features/student/domain/entity/course_entity.dart';

import '../../../../app/usecase/usecase.dart';

class GeAllCourseUseCase implements UsecaseWithoutParams{

  final RemoteCourseRepository repository;
  GeAllCourseUseCase(this.repository);

  @override
  Future<Either<Failure, List<CourseEntity>>> call()async {
    try {
      final result = await repository.getCourse();

      return result.fold(
            (failure) => Left(failure),
            (course) => Right(course),
      );
    }catch(e){
      return Left(ApiFailure(message: e.toString()));
    }

  }
}