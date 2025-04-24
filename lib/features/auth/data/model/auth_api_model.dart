import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';


part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel {
  @JsonKey(name: '_id')
  String? id;
  String name;
  String? password;
  String email;
  String role;

  AuthApiModel({
    this.id,
    required this.name,
    this.password,
    required this.email,
    required this.role,
  });

  /// Factory method for creating an instance from JSON
  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  /// Method for converting an instance to JSON
  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);
}
