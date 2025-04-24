import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:scholarshuip_finder_app/core/error/failure.dart';
import 'package:scholarshuip_finder_app/features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
import 'package:scholarshuip_finder_app/features/auth/data/repository/auth_remote_repository/auth_remote_repository.dart';
import 'package:scholarshuip_finder_app/features/auth/domain/entity/auth_entity.dart';
import 'package:scholarshuip_finder_app/features/auth/domain/repository/auth_repository.dart';

class AuthRepositorySelector implements IAuthRepository {
  final AuthRemoteRepository _remoteRepository;
  final AuthLocalRepository _localRepository;

  AuthRepositorySelector(this._remoteRepository, this._localRepository);

  Future<bool> _isConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() async {
    if (await _isConnected()) {
      return _remoteRepository.getCurrentUser();
    } else {
      return _localRepository.getCurrentUser();
    }
  }

  @override
  Future<Either<Failure, String>> loginUser(
      String email, String password) async {
    if (await _isConnected()) {
      return _remoteRepository.loginUser(email, password);
    } else {
      return _localRepository.loginUser(email, password);
    }
  }

  @override
  Future<Either<Failure, void>> registerUser(AuthEntity user) async {
    if (await _isConnected()) {
      return _remoteRepository.registerUser(user);
    } else {
      return _localRepository.registerUser(user);
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    if (await _isConnected()) {
      return _remoteRepository.uploadProfilePicture(file);
    } else {
      return Left(LocalDatabaseFailure(
          "No internet connection. Please connect to the internet and try again"));
          
    }
  }
}
