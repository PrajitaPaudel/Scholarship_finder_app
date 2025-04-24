import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:scholarshuip_finder_app/features/student/data/dto/address_dto.dart';
import 'package:scholarshuip_finder_app/features/student/data/model/address_model.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entity/student_profile_entity.dart';
import '../../domain/repository/student_profile_repository.dart';
import '../data_source/student_remote_data_source.dart';
import '../dto/student_profile_dto.dart';
import '../model/student_profile_model.dart';


class StudentProfileRemoteRepository implements StudentProfileRepository {
  final StudentProfileRemoteDataSource remoteDataSource;

  StudentProfileRemoteRepository({required this.remoteDataSource});

  @override
  Future<Either<Failure, StudentProfileEntity>> createStudentProfile(
      StudentProfileEntity studentProfileEntity) async {
    try {
      // Convert Entity to DTO
      final studentProfileDTO = StudentProfileDTO.fromEntity(studentProfileEntity);

      // Convert DTO to Model
      final studentProfileModel = StudentProfileModel(
        userId: studentProfileDTO.userId,
        studentName:studentProfileDTO.studentName ,
        dob: studentProfileDTO.dob,
        profilePicture: studentProfileDTO.profilePicture,
        address:AddressModel(city: studentProfileDTO.address.city, country: studentProfileDTO.address.country),
        email:studentProfileDTO.email ,
        phoneNumber:studentProfileDTO.phoneNumber ,
      );

      // Call remote data source
      final result = await remoteDataSource.createStudentProfile(studentProfileModel);

      // Convert Model back to DTO and then to Entity
      return result.fold(
            (failure) => Left(failure),
            (studentProfileModel) {
          // Convert Model to DTO
          final responseDTO = StudentProfileDTO(
            userId: studentProfileModel.userId,
            studentName:studentProfileModel.studentName ,
            dob: studentProfileModel.dob,
            profilePicture: studentProfileModel.profilePicture,
            address:studentProfileModel.address,
            email:studentProfileModel.email ,
            phoneNumber:studentProfileModel.phoneNumber ,
          );

          // Convert DTO back to Entity
          return Right(responseDTO.toEntity());
        },
      );
    } catch (e) {
      return Left(ApiFailure(message: 'Failed to create student profile: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture( File image) async {
    try {
      // Call remote data source
      final result = await remoteDataSource.uploadProfilePicture( image);

      // Return the result directly (no DTO/Entity conversion needed for simple strings)
      return result.fold(
            (failure) => Left(failure),
            (imageUrl) => Right(imageUrl),
      );
    } catch (e) {
      return Left(ApiFailure(message: 'Failed to upload profile picture: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, String>> uploadStudentDocument( File document) async {
    try {
      // Call remote data source
      final result = await remoteDataSource.uploadStudentDocument(document);

      // Return the result directly (no DTO/Entity conversion needed for simple strings)
      return result.fold(
            (failure) => Left(failure),
            (documentUrl) => Right(documentUrl),
      );
    } catch (e) {
      return Left(ApiFailure(message: 'Failed to upload student document: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteStudentProfile(String userId)async {
    try {
      final result = await remoteDataSource.deleteStudentProfile(userId);
      return result.fold(
            (failure) => Left(failure),
            (_) => const Right(null), // Return void instead of String
      );
    } catch (e) {
      return Left(ApiFailure(message: 'Error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, StudentProfileEntity>> getStudentProfileById()async{
    try {
      final result = await remoteDataSource.getStudentProfileById();

      return result.fold(
            (failure) => Left(failure),
            (student) {
          final studentEntity = student.toEntity();
          return Right(studentEntity);
        },
      );
    } catch (e) {
      return Left(ApiFailure(message: 'Error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> updateStudentProfile(StudentProfileEntity studentProfileEntity)async {
    try {
      // Convert Entity to DTO
      final studentProfileDTO = StudentProfileDTO.fromEntity(studentProfileEntity);

      // Convert DTO to Model
      final studentProfileModel = StudentProfileModel(
        userId: studentProfileDTO.userId,
        studentName:studentProfileDTO.studentName ,
        dob: studentProfileDTO.dob,
        profilePicture: studentProfileDTO.profilePicture,
        address:AddressModel(city: studentProfileDTO.address.city, country: studentProfileDTO.address.country),
        email:studentProfileDTO.email ,
        phoneNumber:studentProfileDTO.phoneNumber ,
      );
      // Call remote data source
      final result = await remoteDataSource.updateStudentProfile(studentProfileModel  );

      // Return void for success
      return result.fold(
            (failure) => Left(failure),
            (_) => const Right(null),
      );
    } catch (e) {
      return Left(ApiFailure(message: 'Error occurred: ${e.toString()}'));
    }

  }
}