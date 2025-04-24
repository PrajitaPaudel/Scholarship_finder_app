
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:scholarshuip_finder_app/core/error/failure.dart';
import 'package:scholarshuip_finder_app/features/student/data/data_source/student_data_source.dart';
import 'package:scholarshuip_finder_app/features/student/data/model/student_profile_model.dart';
import 'package:mime_type/mime_type.dart';
import '../../../../app/constants/api_endpoints.dart';
import '../../../../app/shared_prefs/token_shared_prefs.dart';
import 'package:http_parser/http_parser.dart';

class StudentProfileRemoteDataSource implements StudentProfileDataSource {
  final Dio _dio;
  final Logger _logger;
  final TokenSharedPrefs _tokenSharedPrefs;

  StudentProfileRemoteDataSource(this._logger, this._tokenSharedPrefs,
      this._dio);


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
  Future<Either<Failure, StudentProfileModel>> createStudentProfile(
      StudentProfileModel studentProfileModel) async {
    try {
      final tokenResult = await _getToken();
      return tokenResult.fold(
            (failure) => Left(failure),
            (token) async {
          final requestData = studentProfileModel.toJson();

          _logger.i('Sending student profile data: $requestData');
          _logger.i('Sending to: ${ApiEndpoints.studentProfile}');

          final response = await _dio.post(
            ApiEndpoints.studentProfile,
            data: requestData,
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
                'Content-Type': 'application/json',
                'Accept': 'application/json',
              },
              validateStatus: (status) => status != null && status < 500,
            ),
          );

          _logger.i('Response Data: ${response.data}');
          _logger.i('Response Status: ${response.statusCode}');

          if (response.statusCode == 200 || response.statusCode == 201) {
            return Right(StudentProfileModel.fromJson(response.data));
          } else {
            return Left(ApiFailure(
              message: 'Failed to create student profile: ${response.data}',
            ));
          }
        },
      );
    } catch (e, stackTrace) {
      _logger.e('Error during student profile creation: $e');
      return Left(ApiFailure(
        message: 'Failed to create student profile: ${e.toString()}',
      ));
    }
  }

  @override
  Future<Either<ApiFailure, String>> uploadProfilePicture(File image) async {
    try {
      final tokenResult = await _getToken();

      if (tokenResult.isLeft()) {
        return Left(tokenResult.fold(
              (failure) => ApiFailure(message: failure.toString()),
              (r) => throw UnimplementedError(),
        ));
      }

      final token = tokenResult.getOrElse(() => '');
      final filename = image.path.split('/').last;

      // Log file details
      final fileSize = await image.length();
      final fileExtension = filename.split('.').last.toLowerCase();
      print('File path: ${image.path}');
      print('File size: ${fileSize / 1024} KB');
      print('File extension: $fileExtension');

      // Validate file type
      final allowedExtensions = ['jpg', 'jpeg', 'png', 'gif'];
      if (!allowedExtensions.contains(fileExtension)) {
        return Left(ApiFailure(message: 'Invalid file type. Only JPEG, JPG, PNG, and GIF are allowed.'));
      }

      // Determine MIME type based on file extension
      final mimeType = mime(filename); // Uses the mime_type package
      final mediaType = mimeType != null ? MediaType.parse(mimeType) : null;

      // Create FormData
      FormData formData = FormData.fromMap({
        'profilePicture': await MultipartFile.fromFile(
          image.path,
          filename: filename,
          contentType: mediaType, // Set the correct MIME type
        ),
        'userId': '', // Add any required fields
        'token': token,    // Add any required fields
      });

      // Log FormData fields and files
      print('FormData fields: ${formData.fields}');
      print('FormData files: ${formData.files}');

      // Set headers
      final headers = {
        'Authorization': 'Bearer $token',
        'Accept': '*/*',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
        'User-Agent': 'PostmanRuntime/7.43.0',
      };

      print('Headers: $headers');

      // Send request
      final response = await _dio.post(
        ApiEndpoints.uploadProfile,
        data: formData,
        options: Options(
          headers: headers,
          validateStatus: (status) {
            return status! < 500; // Accept status codes less than 500
          },
        ),
      );

      print('Response status code: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        final message = response.data['message'] ?? 'Success';
        return Right(message);
      } else {
        return Left(ApiFailure(message: response.statusMessage ?? 'Unknown error'));
      }
    } catch (e) {
      print('Error uploading profile picture: $e');
      return Left(ApiFailure(message: 'Error uploading profile picture: $e'));
    }
  }

  @override
  Future<Either<Failure, String>> uploadStudentDocument(
      File document) async {
    try {
      final tokenResult = await _getToken();
      return tokenResult.fold(
            (failure) => Left(failure),
            (token) async {
          if (!await document.exists() || await document.length() == 0) {
            return Left(ApiFailure(message: 'Invalid document file.'));
          }

          final filename = document.path
              .split('/')
              .last;
          final formData = FormData.fromMap({
            'document': await MultipartFile.fromFile(
              document.path,
              filename: filename,
              contentType: MediaType(
                  'application', 'pdf'), // Explicitly setting MIME type for PDF
            ),
          });

          _logger.i('Uploading document: ${document.path}');
          _logger.i('Filename: $filename');
          _logger.i('File size: ${await document.length()} bytes');
          _logger.i('Sending to: ${ApiEndpoints.uploadDocument}');

          final response = await _dio.post(
            ApiEndpoints.uploadDocument,
            data: formData,
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
                'Accept': '*/*',
              },
              validateStatus: (status) => status != null && status < 500,
            ),
          );

          _logger.i('Response Data: ${response.data}');
          _logger.i('Response Status: ${response.statusCode}');

          if (response.statusCode == 200) {
            return Right(
                response.data['message'] ?? 'Document uploaded successfully');
          } else {
            return Left(ApiFailure(
              message: 'Failed to upload document: ${response.data}',
            ));
          }
        },
      );
    } catch (e) {
      _logger.e('Error during document upload: $e');
      return Left(ApiFailure(
        message: 'Failed to upload document: ${e.toString()}',
      ));
    }
  }

  @override
  Future<Either<Failure, void>> deleteStudentProfile(String userId) async {
    try {
      final tokenResult = await _getToken();

      return tokenResult.fold(
            (failure) => Left(failure),
            (token) async {
          final url = ApiEndpoints.deleteStudentProfile + userId;
          print('Delete URL: $url'); // Debugging: Print the URL
          print('User ID: $userId'); // Debugging: Print the userId

          final response = await _dio.delete(
            url,
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
                'Accept': '*/*',

              },
              validateStatus: (status) {
                return status! < 500; // Accept status codes less than 500
              },
            ),
          );

          print('Response status code: ${response.statusCode}');
          print('Response data: ${response.data}');

          if (response.statusCode == 200) {
            return Right(null); // Success
          } else {
            return Left(ApiFailure(message: 'Failed to delete profile: ${response.statusMessage}'));
          }
        },
      );
    } catch (e) {
      print('Error deleting profile: $e');
      return Left(ApiFailure(message: 'Error deleting profile: $e'));
    }
  }

  @override
  Future<Either<Failure, StudentProfileModel>> getStudentProfileById()async{
    try {
      final tokenResult = await _getToken();

      return tokenResult.fold(
            (failure) => Left(failure),
            (token) async {
          final response = await _dio.get(
            ApiEndpoints.getStudentProfileByID,
            options: Options(headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            }),
          );

          final Map<String, dynamic> studentData = response.data;
          final StudentProfileModel student = StudentProfileModel.fromJson(studentData);

          _logger.i('Course fetched successfully: ${student.studentName}');
          return Right(student);
        },
      );
    } catch (e, stacktrace) {
      _logger.e('Error during course retrieval: $e\n$stacktrace');
      return Left(ApiFailure(message: 'Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> updateStudentProfile(StudentProfileModel student)async {
    try {
      final tokenResult = await _getToken();
      return tokenResult.fold(
            (failure) => Left(failure),
            (token) async {
          final response = await _dio.put(
            ApiEndpoints.updateStudentProfile,
            data: student.toJson(),
            options: Options(headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            }),
          );

          if (response.statusCode == 200 || response.statusCode == 201) {
            _logger.i('Profile successfully updated: ${response.data}');
            return Right('Profile updated successfully');
          } else {
            return Left(ApiFailure(message: 'Failed to update Profile: ${response.statusMessage}'));
          }
        },
      );
    } catch (e) {
      _logger.e('Error during Profile update: $e');
      return Left(ApiFailure(message: 'Unexpected error: $e'));
    }

  }
}