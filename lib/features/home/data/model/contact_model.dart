import '../dto/contact_dto.dart';

class ContactModel extends ContactDTO {
  ContactModel({required String officialEmail, required String phoneNumber})
      : super(officialEmail: officialEmail, phoneNumber: phoneNumber);

  // Convert JSON to Model
  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      officialEmail: json['officialEmail'],
      phoneNumber: json['phoneNumber'],
    );
  }

  // Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      'officialEmail': officialEmail,
      'phoneNumber': phoneNumber,
    };
  }
}
