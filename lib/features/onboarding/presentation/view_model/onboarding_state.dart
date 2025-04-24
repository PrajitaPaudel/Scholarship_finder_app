import 'package:equatable/equatable.dart';

class OnboardingState extends Equatable {
  final int currentPage;
  final bool navigateToLogin;

  const OnboardingState({
    required this.currentPage,
    this.navigateToLogin = false,
  });

  OnboardingState copyWith({
    int? currentPage,
    bool? navigateToLogin,
  }) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      navigateToLogin: navigateToLogin ?? this.navigateToLogin,
    );
  }

  @override
  List<Object?> get props => [currentPage, navigateToLogin];
}
