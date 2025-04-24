

import 'package:dartz/dartz.dart';
import 'package:scholarshuip_finder_app/app/usecase/usecase.dart';
import 'package:scholarshuip_finder_app/core/error/failure.dart';
import 'package:scholarshuip_finder_app/features/student/domain/entity/course_entity.dart';

import '../../data/repository/remote_course_repository.dart';

class GetCourseByIdUseCase implements UsecaseWithParams<CourseEntity, String>{
  final RemoteCourseRepository repository;

  GetCourseByIdUseCase(this.repository);

  @override
  Future<Either<Failure,  CourseEntity>> call(String userId)async {
    try {
      final result = await repository.getCourseById(userId);

      return result.fold(
            (failure) => Left(failure),
            (course) => Right(course),
      );
    }catch(e){
      return Left(ApiFailure(message: e.toString()));
    }
  }

}