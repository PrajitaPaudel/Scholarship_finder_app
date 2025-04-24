
import '../../../student/data/model/address_model.dart';
import '../../../student/data/model/course_model.dart';
import '../dto/scholarship_provider_dto.dart';
import 'contact_model.dart';
import 'location_model.dart';

class ScholarshipProviderModel extends ScholarshipProviderDTO {


  ScholarshipProviderModel({
      required super.id,
    required super.userId,
    required super.name,
    required super.profilePhoto,
    super.coverPhoto,
    super.galleryImages,
    required super.contact,
    required super.location,
    required super.university,
    required super.description,
    required super.course,
  });

  // Convert JSON to Model
  factory ScholarshipProviderModel.fromJson(Map<String, dynamic> json) {
    return ScholarshipProviderModel(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      name: json['name'] ?? '',
      profilePhoto: json['profilePhoto'] ?? '',
      coverPhoto: json['coverPhoto'] ?? '',
      galleryImages: (json['galleryImages'] != null && json['galleryImages'] is List)
          ? List<String>.from(json['galleryImages'])
          : [],

      contact: json['contact'] != null && json['contact'] is Map<String, dynamic>
          ? ContactModel.fromJson(json['contact'])
          : ContactModel(officialEmail: '', phoneNumber: ''), // Default values

      location: json['location'] != null && json['location'] is Map<String, dynamic>
          ? LocationModel.fromJson(json['location'])
          : LocationModel(city: '', country: ''), // Default values

      university: json['university'] ?? '',
      description: json['description'] ?? '',

      course: json['course'] != null && json['course'] is Map<String, dynamic>
          ? CourseModel.fromJson(json['course'])
          : CourseModel(userId: '', title: '', description: '', scholarshipType: '', id: ''),

    );
  }



  // Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'name': name,
      'profilePhoto': profilePhoto,
      'coverPhoto': coverPhoto,
      'galleryImages': galleryImages,
      'contact': (contact as ContactModel).toJson(),
      'location': (location as LocationModel).toJson(),
      'university': university,
      'description': description,
    };
  }
}
