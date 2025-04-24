

import 'package:dartz/dartz.dart';
import 'package:scholarshuip_finder_app/app/usecase/usecase.dart';
import 'package:scholarshuip_finder_app/features/home/domain/repository/remote_instituted_repository.dart';
import 'package:scholarshuip_finder_app/features/student/domain/entity/course_entity.dart';

import '../../../../core/error/failure.dart';

import 'package:equatable/equatable.dart';

import '../entity/contact_entity.dart';
import '../entity/location_entity.dart';
import '../entity/scholarship_provider_entity.dart';

class UpdateScholarshipProviderParams extends Equatable {
  final String id;
  final String name;
  final String profilePhoto;
  final String? coverPhoto;
  final List<String>? galleryImages;
  final String university;
  final String description;

  const UpdateScholarshipProviderParams({
    required this.id,
    required this.name,
    required this.profilePhoto,
    this.coverPhoto,
    this.galleryImages,
    required this.university,
    required this.description,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    profilePhoto,
    coverPhoto,
    galleryImages,
    university,
    description,
  ];
}

class UpdateScholarshipProviderUseCase implements UsecaseWithParams<void, UpdateScholarshipProviderParams> {
  final InstitutedRepository repository;

  UpdateScholarshipProviderUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateScholarshipProviderParams params) async {
    try {
      final scholarshipProviderEntity = ScholarshipProviderEntity(
        id: params.id,
        name: params.name,
        profilePhoto: params.profilePhoto,
        coverPhoto: params.coverPhoto,
        galleryImages: params.galleryImages,
        university: params.university,
        description: params.description,
        userId: params.id,
        contact: ContactEntity(phoneNumber: '', officialEmail: ''),
        location: LocationEntity(city: '', country: ''),
        course: CourseEntity(title: '', description: '', scholarshipType: '', userId: '', id: ''),
      );

      final result = await repository.updateInstitute(scholarshipProviderEntity, params.id);

      return result.fold(
            (failure) => Left(failure),
            (_) => const Right(null),
      );
    } catch (error) {
      return Left(ApiFailure(message: error.toString()));
    }
  }
}


