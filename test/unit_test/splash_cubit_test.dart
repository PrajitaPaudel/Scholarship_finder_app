import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:scholarshuip_finder_app/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:scholarshuip_finder_app/features/onboarding/presentation/view_model/onboarding_bloc.dart';

class MockOnboardingBloc extends Mock implements OnboardingBloc {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  late SplashCubit splashCubit;
  late MockOnboardingBloc mockOnboardingBloc;
  late MockNavigatorObserver mockNavigatorObserver;

  setUp(() {
    mockOnboardingBloc = MockOnboardingBloc();
    splashCubit = SplashCubit(mockOnboardingBloc);
    mockNavigatorObserver = MockNavigatorObserver();
  });

  testWidgets('SplashCubit should navigate to OnboardingView after delay', (tester) async {
    final mockContext = MockBuildContext();

    await splashCubit.init(mockContext);

    // No need to check state, verify if navigation was triggered instead
    verify(() => mockNavigatorObserver.didPush(any(), any())).called(1);
  });
}

// Mock BuildContext to avoid errors in navigation tests
class MockBuildContext extends Mock implements BuildContext {}
