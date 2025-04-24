  import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:scholarshuip_finder_app/core/error/failure.dart';
import 'package:scholarshuip_finder_app/features/home/data/data_source/data_source.dart';
import 'package:scholarshuip_finder_app/features/home/data/model/scholarship_provider_model.dart';
  import 'package:logger/logger.dart';

import '../../../../app/constants/api_endpoints.dart';
import '../../../../app/shared_prefs/token_shared_prefs.dart';
class InstituteRemoteDataSource implements IInstituteDataSource {
  final Dio _dio;
  final Logger _logger;
  final TokenSharedPrefs _tokenSharedPrefs;

  InstituteRemoteDataSource(this._logger, this._tokenSharedPrefs, this._dio);


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
  Future<Either<Failure, ScholarshipProviderModel>> addInstitute(
      ScholarshipProviderModel scholarshipProviderModel) async{
    try {
      final tokenResult = await _getToken();
      return tokenResult.fold(
            (failure) => Left(failure),
            (token) async {
          final response = await _dio.post(
            ApiEndpoints.getInstitute,
            data: scholarshipProviderModel.toJson(),
            options: Options(headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            }),
          );

          if (response.statusCode == 200 || response.statusCode == 201) {
            _logger.i('ScholarShip successfully created: ${response.data}');
            return Right(ScholarshipProviderModel.fromJson(response.data['data']));
          } else {
            return Left(ApiFailure(message: 'ScholarShip creation failed: ${response.statusMessage}'));
          }
        },
      );
    } catch (e) {
      _logger.e('Error during ScholarShip creation: $e');
      return Left(ApiFailure(message: 'Failed to create ScholarShip: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteInstitute(String id) async{
    try {
      final tokenResult = await _getToken();
      return tokenResult.fold(
            (failure) => Left(failure),
            (token) async {
          final response = await _dio.delete(
            ApiEndpoints.getInstitute + id,
            options: Options(headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            }),
          );

          if (response.statusCode == 200) {
            _logger.i('ScholarShip successfully deleted: $id');
            return const Right(null); // Returning void for success
          } else {
            return Left(ApiFailure(message: 'Failed to delete ScholarShip: ${response.statusMessage}'));
          }
        },
      );
    } catch (e) {
      _logger.e('Error during ScholarShip deletion: $e');
      return Left(ApiFailure(message: 'Unexpected error: $e'));
    }
  }
  @override
  Future<Either<Failure, List<ScholarshipProviderModel>>> getInstitute() async {
    try {
      final tokenResult = await _getToken();

      return tokenResult.fold(
            (failure) => Left(failure),
            (token) async {
          final response = await _dio.get(
            ApiEndpoints.getInstitute,
            options: Options(headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            }),
          );

          // ✅ Check if response status is 200 and data is not null
          if (response.statusCode == 200 && response.data != null) {
            _logger.i('Response received: ${response.data}');

            // ✅ Ensure response.data is a Map<String, dynamic>
            if (response.data is! Map<String, dynamic>) {
              return Left(ApiFailure(message: 'Invalid response format'));
            }

            // ✅ Extract and validate "data" key
            final List<dynamic>? bookingList = response.data['data'];
            if (bookingList == null || bookingList.isEmpty) {
              return Left(ApiFailure(message: 'No data found'));
            }

            // ✅ Parse JSON into ScholarshipProviderModel list
            final List<ScholarshipProviderModel> bookings = bookingList
                .map((institute) => ScholarshipProviderModel.fromJson(institute))
                .toList();

            _logger.i('Bookings fetched successfully: ${bookings.length} items');
            return Right(bookings);
          } else {
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
  Future<Either<Failure, void>> updateInstitute(ScholarshipProviderModel institute, String id)async{
    try {
      final tokenResult = await _getToken();
      return tokenResult.fold(
            (failure) => Left(failure),
            (token) async {
          final response = await _dio.put(
            ApiEndpoints.getInstitute+id,
            data: institute.toJson(),
            options: Options(headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            }),
          );

          if (response.statusCode == 200 || response.statusCode == 201) {
            _logger.i('Booking successfully updated: ${response.data}');
            return Right('ScholorShip updated successfully');
          } else {
            return Left(ApiFailure(message: 'Failed to update booking: ${response.statusMessage}'));
          }
        },
      );
    } catch (e) {
      _logger.e('Error during booking update: $e');
      return Left(ApiFailure(message: 'Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, List<ScholarshipProviderModel>>> getInstituteById(String userId)async{
    try {
      final tokenResult = await _getToken();
      return tokenResult.fold(
            (failure) => Left(failure)
        , (token) async {
        final response = await _dio.get(
          ApiEndpoints.getInstituteById+userId,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          }),
        );
        if (response.statusCode == 200) {
          print(response.data);
          _logger.i('Booking fetched successfully: ${response.data}');

          // Check if `data` is a List or a single object
          final dynamic data = response.data['data'];

          if (data is List) {
            // If it's a list, parse as usual
            final List<ScholarshipProviderModel> bookings = data
                .map((institute) => ScholarshipProviderModel.fromJson(institute))
                .toList();
            _logger.i('Bookings fetched successfully: ${response.data}');
            return Right(bookings);
          } else if (data is Map<String, dynamic>) {
            // If it's a single object, wrap it in a list
            final ScholarshipProviderModel singleBooking =
            ScholarshipProviderModel.fromJson(data);
            _logger.i('Single booking fetched successfully: ${response.data}');
            return Right([singleBooking]); // Return as a list
          } else {
            return Left(ApiFailure(message: 'Unexpected data format'));
          }
        }
        else {
          return Left(ApiFailure(message: 'Failed to fetch booking: ${response.statusMessage}'));
        }
      },
      );

    } catch (e) {
      _logger.e('Error during booking retrieval: $e');
      return Left(ApiFailure(message: 'Unexpected error: $e'));
    }
  }

  @override
  Future<List<ScholarshipProviderModel>> getInstitutionsByFilter({required List<String> cities, required List<String> countries, required List<String> courses, required String searchQuery, required List<String> scholarshipTypes})async{
    try {
      final response = await _dio.get(
        ApiEndpoints.getInstituteByFilter,
        queryParameters: {
          'city': cities.join(','),
          'country': countries.join(','),
          'course': courses.join(','),
          'search': searchQuery,
          'scholarship_type': scholarshipTypes.join(','),
        },
      );

      if (response.statusCode == 200) {
        final data = response.data as List;
        return data.map((json) => ScholarshipProviderModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load institutions');
      }
    } catch (e) {
      throw Exception('Error fetching institutions: $e');
    }
  }
  }

