import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholarshuip_finder_app/app/di/di.dart';
import 'package:scholarshuip_finder_app/features/auth/presentation/view/login_view.dart';
import 'package:scholarshuip_finder_app/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:scholarshuip_finder_app/features/home/presentation/view_model/home_state.dart';

import '../../../../app/shared_prefs/token_shared_prefs.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initial());

  void onTabTapped(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  void logout(BuildContext context) async {
    emit(state.copyWith(isLoading: true));

    final tokenPrefs = getIt<TokenSharedPrefs>();
    final result = await tokenPrefs.removeToken();

    result.fold(
          (failure) {
        print("Failed to remove token: ${failure.message}");
        emit(state.copyWith(isLoading: false));
      },
          (success) {
        Future.delayed(const Duration(seconds: 2), () {
          if (context.mounted) {
            emit(state.copyWith(isLoading: false));
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                  value: getIt<LoginBloc>(),
                  child: LoginView(),
                ),
              ),
            );
          }
        });
      },
    );
  }



}
