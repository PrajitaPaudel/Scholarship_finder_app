import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:scholarshuip_finder_app/core/error/failure.dart';
import 'package:scholarshuip_finder_app/features/auth/domain/use_case/login_usecase.dart';
import 'package:scholarshuip_finder_app/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

class FakeLoginParams extends Fake implements LoginParams {}

void main() {
  late LoginBloc loginBloc;
  late MockLoginUseCase mockLoginUseCase;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    loginBloc = LoginBloc(loginUseCase: mockLoginUseCase);
    registerFallbackValue(FakeLoginParams());
  });

  tearDown(() {
    loginBloc.close();
  });

  test('initial state should be LoginState(isLoading: false, isSuccess: false)',
      () {
    expect(
        loginBloc.state, const LoginState(isLoading: false, isSuccess: false));
  });

  blocTest<LoginBloc, LoginState>(
    'emits [isLoading: true, isSuccess: false] then [isLoading: false, isSuccess: true] on successful login',
    build: () {
      when(() => mockLoginUseCase(any()))
          .thenAnswer((_) async => const Right('fake_token'));
      return loginBloc;
    },
    act: (bloc) => bloc.add(
      LoginUserEvent(
        context: MockBuildContext(),
        username: 'testuser',
        password: 'password',
        onSuccess: () {},
      ),
    ),
    expect: () => [
      const LoginState(isLoading: true, isSuccess: false),
      const LoginState(isLoading: false, isSuccess: true),
    ],
  );

  blocTest<LoginBloc, LoginState>(
    'emits [isLoading: true, isSuccess: false] then [isLoading: false, isSuccess: false] on login failure',
    build: () {
      when(() => mockLoginUseCase(any())).thenAnswer(
          (_) async => Left(ApiFailure(message: 'Invalid Credentials')));
      return loginBloc;
    },
    act: (bloc) => bloc.add(
      LoginUserEvent(
        context: MockBuildContext(),
        username: 'wronguser',
        password: 'wrongpass',
        onSuccess: () {},
      ),
    ),
    expect: () => [
      const LoginState(isLoading: true, isSuccess: false),
      const LoginState(isLoading: false, isSuccess: false),
    ],
  );
}

class MockBuildContext extends Mock implements BuildContext {}
