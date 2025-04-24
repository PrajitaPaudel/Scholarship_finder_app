

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:scholarshuip_finder_app/core/error/failure.dart';
import 'package:scholarshuip_finder_app/features/course/data/data_source/course_data_source.dart';
import 'package:scholarshuip_finder_app/features/student/data/model/course_model.dart';

import '../../../../../app/constants/api_endpoints.dart';
import '../../../../../app/shared_prefs/token_shared_prefs.dart';

class CourseRemoteDataSource implements ICourseDataSource{
  final Dio _dio;
  final Logger _logger;
  final TokenSharedPrefs _tokenSharedPrefs;

  CourseRemoteDataSource( this._logger, this._tokenSharedPrefs, this._dio);


  Future<Either<Failure, String>> _getToken() async {
    final tokenResult = await _tokenSharedPrefs.getToken();
    return tokenResult.fold(
          (failure) {
        _logger.e("Failed to retrieve token: ${failure.message}");
        return Left(failure);
      },
          (token) {
        if (token.isEmpty) {
          _logger.e("No token found in SharedPreferences");
          return Left(SharedPrefsFailure("No token found"));
        }
        return Right(token);
      },
    );
  }
  @override
  Future<Either<Failure, CourseModel>> addCourse(CourseModel courseModel) {
    // TODO: implement addCourse
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteCourse(String id) {
    // TODO: implement deleteCourse
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<CourseModel>>> getAllCourse()async{
    try {
      final tokenResult = await _getToken();

      return tokenResult.fold(
            (failure) => Left(failure),
            (token) async {
          final response = await _dio.get(
            ApiEndpoints.getAllCourse,
            options: Options(headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            }),
          );

          if (response.statusCode == 200 && response.data != null) {
            _logger.i('Response received: ${response.data}');

            if (response.data is! List) {
              return Left(ApiFailure(message: 'Invalid response format'));
            }

            final List<dynamic> courseList = response.data;
            if (courseList.isEmpty) {
              return Left(ApiFailure(message: 'No data found'));
            }

            final List<CourseModel> courses = courseList
                .map((course) => CourseModel.fromJson(course))
                .toList();

            _logger.i('Courses fetched successfully: ${courses.length} items');
            return Right(courses);
          }
 else {
            return Left(ApiFailure(
                message: 'Failed to fetch booking: ${response.statusMessage ?? "Unknown error"}'));
          }
        },
      );
    } catch (e, stacktrace) {
      _logger.e('Error during booking retrieval: $e\n$stacktrace');
      return Left(ApiFailure(message: 'Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, CourseModel>> getCourseById(String courseId) async {
    try {
      final tokenResult = await _getToken();

      return tokenResult.fold(
            (failure) => Left(failure),
            (token) async {
          final response = await _dio.get(
            ApiEndpoints.getCourseById + courseId,
            options: Options(headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            }),
          );

          final Map<String, dynamic> courseData = response.data;
          final CourseModel course = CourseModel.fromJson(courseData);

          _logger.i('Course fetched successfully: ${course.title}');
          return Right(course);
        },
      );
    } catch (e, stacktrace) {
      _logger.e('Error during course retrieval: $e\n$stacktrace');
      return Left(ApiFailure(message: 'Unexpected error: $e'));
    }
  }


  @override
  Future<Either<Failure, List<CourseModel>>> getCourseScholorShipProvider()async {
    try {
      final tokenResult = await _getToken();

      return tokenResult.fold(
            (failure) => Left(failure),
            (token) async {
          final response = await _dio.get(
            ApiEndpoints.getAllCourse,
            options: Options(headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            }),
          );

          if (response.statusCode == 200 && response.data != null) {
            _logger.i('Response received: ${response.data}');

            if (response.data is! List) {
              return Left(ApiFailure(message: 'Invalid response format'));
            }

            final List<dynamic> courseList = response.data;
            if (courseList.isEmpty) {
              return Left(ApiFailure(message: 'No data found'));
            }

            final List<CourseModel> courses = courseList
                .map((course) => CourseModel.fromJson(course))
                .toList();

            _logger.i('Courses fetched successfully: ${courses.length} items');
            return Right(courses);
          }
          else {
            return Left(ApiFailure(
                message: 'Failed to fetch booking: ${response.statusMessage ?? "Unknown error"}'));
          }
        },
      );
    } catch (e, stacktrace) {
      _logger.e('Error during booking retrieval: $e\n$stacktrace');
      return Left(ApiFailure(message: 'Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> updateCourse(CourseModel course, String id) {
    // TODO: implement updateCourse
    throw UnimplementedError();
  }

}