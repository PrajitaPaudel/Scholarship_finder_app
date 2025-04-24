
import 'package:scholarshuip_finder_app/features/student/data/dto/address_dto.dart';
import 'package:scholarshuip_finder_app/features/student/domain/entity/course_entity.dart';

import '../../../student/data/dto/course_dto.dart';
import '../../domain/entity/scholarship_provider_entity.dart';
import 'contact_dto.dart';
import 'location_dto.dart';

class ScholarshipProviderDTO {
  final String id;
  final String userId;
  final String name;
  final String profilePhoto;
  final String? coverPhoto;
  final List<String>? galleryImages;
  final ContactDTO contact;
  final CourseDTO course;
  final LocationDTO location;

  final String university;
  final String description;

  ScholarshipProviderDTO(   {
   required this.id,
    required this.userId,
    required this.name,
    required this.profilePhoto,
    this.coverPhoto,
    this.galleryImages,
    required this.contact,
   required this.course,
    required this.location,
    required this.university,
    required this.description,
  });

  // Convert DTO to Entity
  ScholarshipProviderEntity toEntity() {
    return ScholarshipProviderEntity(
      id: id,
      userId: userId,
      name: name,
      profilePhoto: profilePhoto,
      coverPhoto: coverPhoto,
      galleryImages: galleryImages,
      course: course.toEntity(),
      contact: contact.toEntity(),
      location: location.toEntity(),
      university: university,
      description: description,
    );
  }

  // Create DTO from Entity
  factory ScholarshipProviderDTO.fromEntity(ScholarshipProviderEntity entity) {
    return ScholarshipProviderDTO(
      userId: entity.userId,
      name: entity.name,
      profilePhoto: entity.profilePhoto,
      coverPhoto: entity.coverPhoto,
      galleryImages: entity.galleryImages,
      course: CourseDTO.fromEntity(entity.course),
      contact: ContactDTO.fromEntity(entity.contact),
      location: LocationDTO.fromEntity(entity.location),
      university: entity.university,
      description: entity.description, id: entity.id,
    );
  }
}
