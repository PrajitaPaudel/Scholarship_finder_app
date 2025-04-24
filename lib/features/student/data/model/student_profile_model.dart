


import '../dto/address_dto.dart';
import '../dto/student_profile_dto.dart';
import 'address_model.dart';

class StudentProfileModel extends StudentProfileDTO {
  StudentProfileModel({
    required String userId,
    required String studentName,
    required String email,
    required String phoneNumber,
    required DateTime dob,
    required String profilePicture,
    required AddressDTO address,
    String? document,
  }) : super(
    userId: userId,
    studentName: studentName,
    email: email,
    phoneNumber: phoneNumber,
    dob: dob,
    profilePicture: profilePicture,
    address: address,
    document: document,
  );

  // Convert JSON to Model
  factory StudentProfileModel.fromJson(Map<String, dynamic> json) {
    return StudentProfileModel(
      userId: json['UserId'],
      studentName: json['StudentName'],
      email: json['Email'],
      phoneNumber: json['PhoneNumber'],
      dob: DateTime.parse(json['Dob']),
      profilePicture: json['ProfilePicture'] ,
      address: AddressModel.fromJson(json['Address']),
      document: json['Document'],
    );
  }

  // Convert Model to JSON
  @override
  Map<String, dynamic> toJson() {
    return {
      'UserId': userId,
      'StudentName': studentName,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'Dob': dob.toIso8601String(),
      'ProfilePicture': profilePicture,
      'Address': (address as AddressModel).toJson(),
      'Document': document,
    };
  }
}
