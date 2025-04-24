import 'package:scholarshuip_finder_app/features/student/domain/entity/address_entity.dart';
import 'package:scholarshuip_finder_app/features/student/domain/entity/course_entity.dart';

import 'contact_entity.dart';
import 'location_entity.dart';

class ScholarshipProviderEntity {
  final String id;
  final String userId;
  final String name;
  final String profilePhoto;
  final String? coverPhoto;
  final List<String>? galleryImages;
  final CourseEntity course;
  final ContactEntity contact;
  final LocationEntity location;
  final String university;
  final String description;

  ScholarshipProviderEntity(  {
    required this.id,
    required this.userId,
    required this.name,
    required this.profilePhoto,
    this.coverPhoto,
    this.galleryImages,
   required this.course,
    required this.contact,
    required this.location,
    required this.university,
    required this.description,
  });
}
