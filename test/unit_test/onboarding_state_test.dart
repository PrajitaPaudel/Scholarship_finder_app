import 'package:flutter_test/flutter_test.dart';
import 'package:scholarshuip_finder_app/features/onboarding/presentation/view_model/onboarding_state.dart';

void main() {
  group('OnboardingState', () {
    test('supports value equality', () {
      expect(
        const OnboardingState(currentPage: 0),
        const OnboardingState(currentPage: 0),
      );
    });

    test('props are correct', () {
      expect(
        const OnboardingState(currentPage: 0).props,
        [0, false],
      );
    });

    test('copyWith returns a new instance with updated values', () {
      const state = OnboardingState(currentPage: 0);

      expect(
        state.copyWith(currentPage: 1),
        const OnboardingState(currentPage: 1),
      );

      expect(
        state.copyWith(navigateToLogin: true),
        const OnboardingState(currentPage: 0, navigateToLogin: true),
      );

      expect(
        state.copyWith(currentPage: 1, navigateToLogin: true),
        const OnboardingState(currentPage: 1, navigateToLogin: true),
      );
    });

    test('copyWith returns the same instance if no parameters are provided', () {
      const state = OnboardingState(currentPage: 0);

      expect(
        state.copyWith(),
        state,
      );
    });
  });
}