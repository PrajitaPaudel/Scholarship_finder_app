import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'dart:io';

import 'package:scholarshuip_finder_app/app/usecase/usecase.dart';


import '../../../../core/error/failure.dart';
import '../../data/repository/remote_student_profile_repository.dart';
import '../repository/student_profile_repository.dart';

class UploadStudentDocumentParams extends Equatable {
  final File document;

  const UploadStudentDocumentParams({
    required this.document,
  });

  @override
  List<Object?> get props => [ document];
}

class UploadStudentDocumentUseCase implements UsecaseWithParams<String, UploadStudentDocumentParams> {
  final StudentProfileRemoteRepository repository;

  UploadStudentDocumentUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(UploadStudentDocumentParams params) async {
    // Call the repository to upload the document
    final result = await repository.uploadStudentDocument(params.document);

    return result;
  }
}