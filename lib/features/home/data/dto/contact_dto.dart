import '../../domain/entity/contact_entity.dart';

class ContactDTO {
  final String officialEmail;
  final String phoneNumber;

  ContactDTO({required this.officialEmail, required this.phoneNumber});

  // Convert DTO to Entity
  ContactEntity toEntity() {
    return ContactEntity(
      officialEmail: officialEmail,
      phoneNumber: phoneNumber,
    );
  }

  // Create DTO from Entity
  factory ContactDTO.fromEntity(ContactEntity entity) {
    return ContactDTO(
      officialEmail: entity.officialEmail,
      phoneNumber: entity.phoneNumber,
    );
  }
}
