


import '../dto/address_dto.dart';

class AddressModel extends AddressDTO {
  AddressModel({
    required String city,
    required String country,
  }) : super(
    city: city,
    country: country,
  );

  // Convert JSON to Model
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      city: json['City'],
      country: json['Country'],
    );
  }

  // Convert Model to JSON
  @override
  Map<String, dynamic> toJson() {
    return {
      'City': city,
      'Country': country,
    };
  }
}
