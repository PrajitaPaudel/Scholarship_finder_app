import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:scholarshuip_finder_app/core/error/failure.dart';
import 'package:scholarshuip_finder_app/features/auth/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:scholarshuip_finder_app/features/auth/domain/entity/auth_entity.dart';
import 'package:scholarshuip_finder_app/features/auth/domain/repository/auth_repository.dart';

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRemoteRepository(this.authRemoteDataSource);

  @override
  Future<Either<Failure, void>> registerUser(AuthEntity user) async {
    print("📢 Repository received: ${user.name}, ${user.name}, ${user.name}");
    try {
      await authRemoteDataSource.registerUser(user);
      return Right(null);
    } catch (e) {
      print("❌ Repository Error: ${e.toString()}");
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> loginUser(
      String email, String password) async {
    try {
      final token = await authRemoteDataSource.loginUser(email, password);

      return Right(token);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    try {
      final imageName = await authRemoteDataSource.uploadProfilePicture(file);
      return Right(imageName);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
