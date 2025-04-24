

import 'package:dartz/dartz.dart';
import 'package:scholarshuip_finder_app/features/student/data/model/course_model.dart';

import '../../../../core/error/failure.dart';

abstract  class  ICourseDataSource{
  Future<Either<Failure,CourseModel>> addCourse(CourseModel  courseModel);
  Future<Either<Failure,List<CourseModel>>>getAllCourse();
  Future<Either<Failure,List<CourseModel>>>getCourseScholorShipProvider();
  Future<Either<Failure,CourseModel>>getCourseById(String courseId);
  Future<Either<Failure, void>> updateCourse(CourseModel course,String id);
  Future<Either<Failure, void>> deleteCourse(String id) ;
}
