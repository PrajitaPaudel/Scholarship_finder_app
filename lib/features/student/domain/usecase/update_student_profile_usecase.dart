import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:scholarshuip_finder_app/app/usecase/usecase.dart';

import '../../../../core/error/failure.dart';
import '../../data/repository/remote_student_profile_repository.dart';
import '../entity/address_entity.dart';
import '../entity/student_profile_entity.dart';

class UpdateStudentProfileParams extends Equatable {
  final String userId;
  final String fullName;
  final String email;
  final String phoneNumber;
  final DateTime dateOfBirth;
  final String city;
  final String country;
  final String? profilePictureUrl;
  final String? documentUrl;

  const UpdateStudentProfileParams({
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
class UpdateStudentProfileUseCase implements UsecaseWithParams<void, UpdateStudentProfileParams> {
  final StudentProfileRemoteRepository repository;

  UpdateStudentProfileUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateStudentProfileParams params) async {
    try {
      // Convert params to Entity
      final studentProfileEntity = StudentProfileEntity(
        userId: params.userId,
        studentName: params.fullName,
        email: params.email,
        phoneNumber: params.phoneNumber,
        dob: params.dateOfBirth,
        address:AddressEntity(city: params.city, country: params.country),
        profilePicture:'',
        document: '',
      );

      // Call repository
      final result = await repository.updateStudentProfile(studentProfileEntity);

      return result.fold(
            (failure) => Left(failure),
            (_) => const Right(null),
      );
    } catch (error) {
      return Left(ApiFailure(message: error.toString()));
    }
  }
}