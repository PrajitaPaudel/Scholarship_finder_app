import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholarshuip_finder_app/app/di/di.dart';
import 'package:scholarshuip_finder_app/core/common/snackbar/my_snackbar.dart';
import 'package:scholarshuip_finder_app/features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
import 'package:scholarshuip_finder_app/features/auth/domain/use_case/login_usecase.dart';
import 'package:scholarshuip_finder_app/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:scholarshuip_finder_app/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:scholarshuip_finder_app/features/auth/presentation/view/login_view.dart';
import 'package:scholarshuip_finder_app/features/auth/presentation/view_model/login/login_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase _registerUseCase;
  final UploadImageUsecase _uploadImageUsecase;

  RegisterBloc({
    required RegisterUseCase registerUseCase,
    required UploadImageUsecase? uploadImageUsecase,
  })  : _registerUseCase = registerUseCase,
        _uploadImageUsecase = uploadImageUsecase ??
            UploadImageUsecase(getIt<AuthLocalRepository>()),
        super(RegisterState.initial()) {
    on<RegisterUser>(_onRegisterEvent);
    on<UploadImage>(_onLoadImage);
  }

  void _onRegisterEvent(
    RegisterUser event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    print("🔥 Register Event Triggered for: ${event.name}, ${event.name}");
    final result = await _registerUseCase.call(RegisterUserParams(

      password: event.password, name: event.name, email: event.email, role:event.role,
    ));

    result.fold(

      (l) {
        print("❌ Registration Failed");
    emit(state.copyWith(isLoading: false, isSuccess: false));
  },
      (r) {
        print("✅ Registration Successful!");
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
            context: event.context, message: "Registration Successful");
        // Navigate to login view after a short delay to ensure the snackbar is visible
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.push(
            event.context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (_) => LoginBloc(
                  loginUseCase: getIt<LoginUseCase>(),
                ),
                child: LoginView(),
              ),
            ),
          );
        });
      },
    );
  }

  void _onLoadImage(
    UploadImage event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _uploadImageUsecase.call(
      UploadImageParams(
        file: event.file,
      ),
    );

    result.fold(
      (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
      },
    );
  }
}
