

import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../model/student_profile_model.dart';

abstract class StudentProfileDataSource {
  Future<Either<Failure, StudentProfileModel>> createStudentProfile(
      StudentProfileModel studentProfileModel);

  Future<Either<Failure, String>> uploadProfilePicture(
      File image);

  Future<Either<Failure, String>> uploadStudentDocument(
      File document);

  Future<Either<Failure,StudentProfileModel>>getStudentProfileById();
  Future<Either<Failure, void>> updateStudentProfile(StudentProfileModel student);
  Future<Either<Failure, void>> deleteStudentProfile(String userId) ;
}