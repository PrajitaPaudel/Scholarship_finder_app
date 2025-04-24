
 import 'package:dartz/dartz.dart';
import 'package:scholarshuip_finder_app/features/student/domain/entity/course_entity.dart';

import '../../../../core/error/failure.dart';

abstract  class ICourseRepository{
  Future<Either<Failure, CourseEntity>> addCourse(CourseEntity courseEntity);

   Future<Either<Failure, List<CourseEntity>>> getCourse();
  Future<Either<Failure, List<CourseEntity>>> getCourseScholorProvider();
  Future<Either<Failure,CourseEntity>>getCourseById(String userId);
  Future<Either<Failure, void>> updateCourse(CourseEntity courseEntity,String id) ;
  Future<Either<Failure, void>> deleteCourse(String id) ;

}