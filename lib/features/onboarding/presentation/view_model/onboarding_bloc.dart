import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholarshuip_finder_app/features/auth/presentation/view_model/login/login_bloc.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final LoginBloc _loginBloc;

  OnboardingBloc({
    required LoginBloc loginBloc,
  })  : _loginBloc = loginBloc,
        super(const OnboardingState(currentPage: 0)) {
    on<ChangePageEvent>((event, emit) {
      emit(state.copyWith(currentPage: event.page));
    });

    on<NavigateToLoginEvent>((event, emit) {
      Navigator.push(
        event.context,
        MaterialPageRoute(
          builder: (context) => 
            BlocProvider.value(
              value: _loginBloc,
              child: event.destination,

          ),
        ),
      );
    });
  }
}
