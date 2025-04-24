import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'dart:io';

import 'package:scholarshuip_finder_app/app/usecase/usecase.dart';


import '../../../../core/error/failure.dart';
import '../../data/repository/remote_student_profile_repository.dart';
import '../repository/student_profile_repository.dart';

class UploadProfilePictureParams extends Equatable {
  final File image;

  const UploadProfilePictureParams({
    required this.image,
  });

  @override
  List<Object?> get props => [image];
}




class UploadProfilePictureUseCase implements UsecaseWithParams<String, UploadProfilePictureParams> {
  final StudentProfileRemoteRepository repository;

  UploadProfilePictureUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(UploadProfilePictureParams params) async {
    // Call the repository to upload the profile picture
    final result = await repository.uploadProfilePicture( params.image);

    return result;
  }
}