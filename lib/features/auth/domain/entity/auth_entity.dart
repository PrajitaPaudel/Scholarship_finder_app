import 'package:equatable/equatable.dart';



class AuthEntity extends Equatable {
  final String? id;
  final String name;
  final String? password;
  final String email;
  final String role;

  const AuthEntity({
    this.id,
    required this.name,
    this.password,
    required this.email,
    required this.role,
  });

  @override
  List<Object?> get props => [id, name, password, email, role];
}

