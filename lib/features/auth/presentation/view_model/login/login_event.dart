part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginUserEvent extends LoginEvent {
  final BuildContext context;
  final String username;
  final String password;
  final VoidCallback onSuccess;

  const LoginUserEvent({
    required this.context,
    required this.username,
    required this.password,
    required this.onSuccess,
  });

  @override
  List<Object?> get props => [username, password];
}
