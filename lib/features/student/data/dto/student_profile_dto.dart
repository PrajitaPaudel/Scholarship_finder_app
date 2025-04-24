import '../../domain/entity/student_profile_entity.dart';
import 'address_dto.dart';

class StudentProfileDTO {
  final String userId;
  final String studentName;
  final String email;
  final String phoneNumber;
  final DateTime dob;
  final String profilePicture;
  final AddressDTO address;
  final String? document;

  StudentProfileDTO({
    required this.userId,
    required this.studentName,
    required this.email,
    required this.phoneNumber,
    required this.dob,
    required this.profilePicture,
    required this.address,
    this.document,
  });

  // Convert Entity to DTO
  factory StudentProfileDTO.fromEntity(StudentProfileEntity entity) {
    return StudentProfileDTO(
      userId: entity.userId,
      studentName: entity.studentName,
      email: entity.email,
      phoneNumber: entity.phoneNumber,
      dob: entity.dob,
      profilePicture: entity.profilePicture,
      address: AddressDTO.fromEntity(entity.address),
      document: entity.document,
    );
  }

  // Convert DTO to Entity
  StudentProfileEntity toEntity() {
    return StudentProfileEntity(
      userId: userId,
      studentName: studentName,
      email: email,
      phoneNumber: phoneNumber,
      dob: dob,
      profilePicture: profilePicture,
      address: address.toEntity(),
      document: document,
    );
  }
}