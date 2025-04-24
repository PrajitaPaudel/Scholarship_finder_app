
import 'package:dartz/dartz.dart';
import 'package:scholarshuip_finder_app/core/error/failure.dart';
import 'package:scholarshuip_finder_app/features/course/data/data_source/remote_course_data_source/remote_course_data_source.dart';
import 'package:scholarshuip_finder_app/features/course/domain/repository/course_repository.dart';
import 'package:scholarshuip_finder_app/features/student/data/model/course_model.dart';
import 'package:scholarshuip_finder_app/features/student/domain/entity/course_entity.dart';

class RemoteCourseRepository implements ICourseRepository{
  final CourseRemoteDataSource courseRemoteDataSource;

  RemoteCourseRepository(this.courseRemoteDataSource);

  @override
  Future<Either<Failure, void>> deleteCourse(String id) {
    // TODO: implement deleteCourse
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<CourseEntity>>> getCourse()async {
    try {
      final result = await courseRemoteDataSource.getAllCourse();

      return result.fold(
            (failure) => Left(failure),
            (courses) {
          final courseEntity = courses.map((course) => course.toEntity()).toList();
          return Right(courseEntity);
        },
      );
    } catch (e) {
      return Left(ApiFailure(message: 'Error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, CourseEntity>> getCourseById(String userId)async{
    try {
      final result = await courseRemoteDataSource.getCourseById(userId);

      return result.fold(
            (failure) => Left(failure),
            (courses) {
          final courseEntity = courses.toEntity();
          return Right(courseEntity);
        },
      );
    } catch (e) {
      return Left(ApiFailure(message: 'Error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<CourseEntity>>> getCourseScholorProvider() {
    // TODO: implement getCourseScholorProvider
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> updateCourse(CourseEntity courseEntity, String id) {
    // TODO: implement updateCourse
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, CourseEntity>> addCourse(CourseEntity courseEntity) {
    // TODO: implement addCourse
    throw UnimplementedError();
  }
  
}