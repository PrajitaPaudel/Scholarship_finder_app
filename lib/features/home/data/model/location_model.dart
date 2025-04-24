
import '../dto/location_dto.dart';

class LocationModel extends LocationDTO {
  LocationModel({required String city, required String country})
      : super(city: city, country: country);

  // Convert JSON to Model
  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      city: json['city'],
      country: json['country'],
    );
  }

  // Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'country': country,
    };
  }


}
