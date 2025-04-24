import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:scholarshuip_finder_app/app/usecase/usecase.dart';
import 'package:scholarshuip_finder_app/core/error/failure.dart';
import 'package:scholarshuip_finder_app/features/auth/domain/entity/auth_entity.dart';
import 'package:scholarshuip_finder_app/features/auth/domain/repository/auth_repository.dart';

import '../../data/repository/auth_remote_repository/auth_remote_repository.dart';
class RegisterUserParams extends Equatable {
  final String name;
  final String email;
  final String role;
  final String password;


  const RegisterUserParams({
    required this.name,
    required this.email,
    required this.role,
    required this.password,

  });

  // Initial constructor
  const RegisterUserParams.initial()
      : name = '',
        email = '',
        role = '',
        password = '';


  @override
  List<Object?> get props => [name, email, role, password];
}

class RegisterUseCase implements UsecaseWithParams<void, RegisterUserParams> {
  final AuthRemoteRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    print("🛠️ UseCase received: ${params.name}, ${params.email}, ${params.role}");

    final authEntity = AuthEntity(
      id: null,
      email: params.email,
      role: params.role,
      password: params.password,
      name: params.name,
    );

    return repository.registerUser(authEntity);
  }
}
