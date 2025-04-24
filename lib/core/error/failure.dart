import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message); // ✅ Use a normal constructor

  @override
  List<Object> get props => [message];
}

class LocalDatabaseFailure extends Failure {
  const LocalDatabaseFailure(super.message);
}

class ApiFailure extends Failure {
  final int? statusCode;
  const ApiFailure({this.statusCode, required String message}) : super(message);

  @override
  List<Object> get props => [message, statusCode ?? 0];
}

class SharedPrefsFailure extends Failure {
  const SharedPrefsFailure(super.message);
}
