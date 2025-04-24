
import 'package:dartz/dartz.dart';
import 'package:scholarshuip_finder_app/app/usecase/usecase.dart';
import 'package:scholarshuip_finder_app/core/error/failure.dart';
import 'package:scholarshuip_finder_app/features/student/domain/entity/course_entity.dart';

class UpdateCourseUseCase implements UsecaseWithParams <CourseEntity,String >{
  @override
  Future<Either<Failure, CourseEntity>> call(String id) {
    // TODO: implement call
    throw UnimplementedError();
  }

}