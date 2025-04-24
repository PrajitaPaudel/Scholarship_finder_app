import 'address_entity.dart';

class StudentProfileEntity {
  final String userId;
  final String studentName;
  final String email;
  final String phoneNumber;
  final DateTime dob;
  final String profilePicture;
  final AddressEntity address;
  final String? document;

  StudentProfileEntity({
    required this.userId,
    required this.studentName,
    required this.email,
    required this.phoneNumber,
    required this.dob,
    required this.profilePicture,
    required this.address,
    this.document,
  });
}
