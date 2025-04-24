import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:scholarshuip_finder_app/features/onboarding/presentation/view_model/onboarding_bloc.dart';
import 'package:scholarshuip_finder_app/features/onboarding/presentation/view_model/onboarding_event.dart';
import 'package:scholarshuip_finder_app/features/onboarding/presentation/view_model/onboarding_state.dart';
import 'package:scholarshuip_finder_app/features/auth/presentation/view_model/login/login_bloc.dart';

class MockLoginBloc extends Mock implements LoginBloc {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  late OnboardingBloc onboardingBloc;
  late MockLoginBloc mockLoginBloc;
  late MockNavigatorObserver mockNavigatorObserver;

  setUp(() {
    mockLoginBloc = MockLoginBloc();
    onboardingBloc = OnboardingBloc(loginBloc: mockLoginBloc);
    mockNavigatorObserver = MockNavigatorObserver();

    registerFallbackValue(MaterialPageRoute(builder: (_) => Container()));
  });

  tearDown(() {
    onboardingBloc.close();
  });

  test('initial state is correct', () {
    expect(onboardingBloc.state, const OnboardingState(currentPage: 0));
  });

  test('emits new state when ChangePageEvent is added', () {
    final expectedStates = [
      const OnboardingState(currentPage: 1),
    ];

    expectLater(onboardingBloc.stream, emitsInOrder(expectedStates));

    onboardingBloc.add(ChangePageEvent(1));
  });

  testWidgets('navigates to login when NavigateToLoginEvent is added', (WidgetTester tester) async {
    final testKey = GlobalKey<NavigatorState>();

    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: testKey,
        navigatorObservers: [mockNavigatorObserver],
        home: Builder(
          builder: (context) {
            onboardingBloc.add(NavigateToLoginEvent(context: context, destination: Container()));
            return Container();
          },
        ),
      ),
    );

    await tester.pumpAndSettle();

    verify(() => mockNavigatorObserver.didPush(any(), any())).called(1);
  });
}
