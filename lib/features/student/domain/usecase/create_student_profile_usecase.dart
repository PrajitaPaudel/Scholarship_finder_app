import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:scholarshuip_finder_app/app/usecase/usecase.dart';
import 'package:scholarshuip_finder_app/features/student/domain/entity/address_entity.dart';

import '../../../../core/error/failure.dart';
import '../entity/student_profile_entity.dart';
import '../repository/student_profile_repository.dart';

class CreateStudentProfileParams extends Equatable {
  final String userId;
  final String fullName;
  final String email;
  final String phoneNumber;
  final DateTime dateOfBirth;
  final String city;
  final String country;
  final String? profilePictureUrl;
  final String? documentUrl;

  const CreateStudentProfileParams({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.city,
    required this.country,
    this.profilePictureUrl,
    this.documentUrl,
  });

  @override
  List<Object?> get props => [
    userId,
    fullName,
    email,
    phoneNumber,
    dateOfBirth,
    city,
    country,
    profilePictureUrl,
    documentUrl,
  ];
}



class CreateStudentProfileUseCase implements UsecaseWithParams<StudentProfileEntity, CreateStudentProfileParams> {
  final StudentProfileRepository repository;

  CreateStudentProfileUseCase(this.repository);

  @override
  Future<Either<Failure, StudentProfileEntity>> call(CreateStudentProfileParams params) async {
    // Convert params to entity
    final studentProfileEntity = StudentProfileEntity(
      userId: params.userId,
      studentName: params.fullName,
      email: params.email,
      phoneNumber: params.phoneNumber,
      dob: params.dateOfBirth,
      address:AddressEntity(city: params.city, country: params.country),
      profilePicture:'',
    );

    // Call the repository
    final result = await repository.createStudentProfile(studentProfileEntity);

    return result;
  }
}

