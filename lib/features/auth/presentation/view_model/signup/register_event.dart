part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

class UploadImage extends RegisterEvent {
  final File file;

  const UploadImage({
    required this.file,
  });

  @override
  List<Object?> get props => [file];
}

class RegisterUser extends RegisterEvent {
  final BuildContext context;
  final String name;
  final String email;
  final String role;
  final String password;
  final String? image;

  const RegisterUser({
    required this.context,
    required this.name,
    required this.email,
    required this.role,
    required this.password,
    this.image,
  });

  @override
  List<Object?> get props => [context, name, email, role, password, image];
}

