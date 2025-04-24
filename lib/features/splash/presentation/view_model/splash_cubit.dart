import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholarshuip_finder_app/features/onboarding/presentation/view/onboarding_view.dart';
import 'package:scholarshuip_finder_app/features/onboarding/presentation/view_model/onboarding_bloc.dart';

class SplashCubit extends Cubit<void> {
  final OnboardingBloc _onboardingBloc;

  SplashCubit(this._onboardingBloc) : super(null);

  Future<void> init(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3)); // Reduced delay to 3s for better UX
    if (!context.mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: _onboardingBloc,
          child: const OnboardingView(),
        ),
      ),
    );
  }
}
