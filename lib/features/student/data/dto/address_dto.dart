import '../../domain/entity/address_entity.dart';

class AddressDTO {
  final String city;
  final String country;

  AddressDTO({
    required this.city,
    required this.country,
  });

  // Convert Entity to DTO
  factory AddressDTO.fromEntity(AddressEntity entity) {
    return AddressDTO(
      city: entity.city,
      country: entity.country,
    );
  }

  // Convert DTO to Entity
  AddressEntity toEntity() {
    return AddressEntity(
      city: city,
      country: country,
    );
  }


}
