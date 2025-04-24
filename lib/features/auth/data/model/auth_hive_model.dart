import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:scholarshuip_finder_app/app/constants/hive_table_constant.dart';
import 'package:scholarshuip_finder_app/features/auth/domain/entity/auth_entity.dart';
import 'package:uuid/uuid.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';


part 'auth_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.userTableId)
class AuthHiveModel extends Equatable {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String? password;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final String role;

  AuthHiveModel({
    String? id,
    required this.name,
    this.password,
    required this.email,
    required this.role,
  }) : id = id ?? const Uuid().v4();

  /// Initial Constructor (Default Empty Values)
  const AuthHiveModel.initial()
      : id = '',
        name = '',
        password = '',
        email = '',
        role = '';

  /// Convert from `AuthEntity` to `AuthHiveModel`
  factory AuthHiveModel.fromEntity(AuthEntity entity) {
    return AuthHiveModel(
      id: entity.id,
      name: entity.name,
      password: entity.password,
      email: entity.email,
      role: entity.role,
    );
  }

  /// Convert from `AuthHiveModel` to `AuthEntity`
  AuthEntity toEntity() {
    return AuthEntity(
      id: id,
      name: name,
      password: password,
      email: email,
      role: role,
    );
  }

  @override
  List<Object?> get props => [id, name, password, email, role];
}
