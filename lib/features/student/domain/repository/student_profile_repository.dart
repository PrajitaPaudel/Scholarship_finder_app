
import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/student_profile_entity.dart';

abstract  class StudentProfileRepository{

  Future<Either<Failure, StudentProfileEntity>> createStudentProfile(
      StudentProfileEntity studentProfileEntity);
  Future<Either<Failure, String>> uploadProfilePicture( File image);
  Future<Either<Failure, String>> uploadStudentDocument( File document);
  Future<Either<Failure,StudentProfileEntity>>getStudentProfileById();
  Future<Either<Failure, void>> updateStudentProfile(StudentProfileEntity studentProfileEntity) ;
  Future<Either<Failure, void>> deleteStudentProfile(String userId) ;
}