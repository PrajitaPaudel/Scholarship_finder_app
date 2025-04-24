import 'dart:io';

import 'package:dio/dio.dart';
import 'package:scholarshuip_finder_app/app/constants/api_endpoints.dart';
import 'package:scholarshuip_finder_app/features/auth/data/data_source/auth_data_source.dart';
import 'package:scholarshuip_finder_app/features/auth/domain/entity/auth_entity.dart';

import '../../../../../app/shared_prefs/token_shared_prefs.dart';


class AuthRemoteDataSource implements IAuthDataSource {
  final Dio _dio;
  final TokenSharedPrefs _tokenSharedPrefs;

  AuthRemoteDataSource(this._dio, this._tokenSharedPrefs);
  
  @override
  Future<void> registerUser(AuthEntity user) async {
    try {
      print("🚀 Sending API Request: ${user.name}, ${user.password}, ${user.email}");
      Response response = await _dio.post(
        ApiEndpoints.register,
        data: {
          "name": user.name,
         "email":user.email,
          "role": user.role,
          "password": user.password,
        },
      );
      print("✅ API Response: ${response.data}");

      if (response.statusCode == 200 || response.statusCode==201) {
        print(response.statusCode);
        print(response.statusCode);
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      print("❌ API Request Failed: ${e.toString()}");
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<AuthEntity> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<String> loginUser(String email, String password) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.login,
        data: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        final str = response.data['token'];
        await _tokenSharedPrefs.saveToken(str);
        return str;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap(
        {
          'profilePicture': await MultipartFile.fromFile(
            file.path,
            filename: fileName,
          ),
        },
      );

      Response response = await _dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
      );

      if (response.statusCode == 200) {
        // Extract the image name from the response
        final str = response.data['data'];

        return str;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}
