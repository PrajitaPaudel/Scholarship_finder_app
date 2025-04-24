import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:scholarshuip_finder_app/features/onboarding/presentation/view_model/onboarding_event.dart';

void main() {
  group('OnboardingEvent', () {
    test('ChangePageEvent supports value equality', () {
      expect(
        const ChangePageEvent(1),
        const ChangePageEvent(1),
      );
    });

    test('ChangePageEvent props are correct', () {
      expect(
        const ChangePageEvent(1).props,
        [1],
      );
    });

    test('NavigateToLoginEvent supports value equality', () {
      final context = MockBuildContext();
      final destination = Container();

      expect(
        NavigateToLoginEvent(context: context, destination: destination),
        NavigateToLoginEvent(context: context, destination: destination),
      );
    });

    test('NavigateToLoginEvent props are correct', () {
      final context = MockBuildContext();
      final destination = Container();

      expect(
        NavigateToLoginEvent(context: context, destination: destination).props,
        [context, destination],
      );
    });
  });
}

class MockBuildContext extends Mock implements BuildContext {}
