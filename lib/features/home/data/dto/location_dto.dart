import '../../domain/entity/location_entity.dart';

class LocationDTO {
  final String city;
  final String country;

  LocationDTO({required this.city, required this.country});

  // Convert DTO to Entity
  LocationEntity toEntity() {
    return LocationEntity(
      city: city,
      country: country,
    );
  }

  // Create DTO from Entity
  factory LocationDTO.fromEntity(LocationEntity entity) {
    return LocationDTO(
      city: entity.city,
      country: entity.country,
    );
  }
}
