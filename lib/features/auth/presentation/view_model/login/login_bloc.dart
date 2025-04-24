import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholarshuip_finder_app/core/common/snackbar/my_snackbar.dart';
import 'package:scholarshuip_finder_app/features/auth/domain/use_case/login_usecase.dart';
import 'package:scholarshuip_finder_app/features/home/presentation/view/home_view.dart';
import 'package:scholarshuip_finder_app/features/home/presentation/view_model/home_cubit.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;

  LoginBloc({required LoginUseCase loginUseCase})
      : _loginUseCase = loginUseCase,
        super(LoginState(isLoading: false, isSuccess: false)) {
    on<LoginUserEvent>(_onLoginStudent);
  }

  Future<void> _onLoginStudent(
      LoginUserEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isLoading: true));

    final result = await _loginUseCase(
      LoginParams(email: event.username, password: event.password),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        showMySnackBar(
          context: event.context,
          message: "Invalid Credentials",
          color: Colors.red,
        );
      },
      (token) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        event.context.read<HomeCubit>().onTabTapped(0);

        showMySnackBar(
          context: event.context,
          message: 'Logged in Successfully',
          color: Colors.green,
        );
        Future.delayed(const Duration(
            seconds: 1));
        Navigator.pushReplacement(
          event.context,
          MaterialPageRoute(
            builder: (context) => const HomeView(),
          ),
        );

      },
    );
  }
}
