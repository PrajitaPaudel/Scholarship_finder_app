import 'package:equatable/equatable.dart';

import 'package:equatable/equatable.dart';

import '../../domain/entity/student_profile_entity.dart';
class StudentProfileState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isError;
  final StudentProfileEntity? studentProfileEntity;
  final String? errorMessage;
  final String? profilePictureUrl;
  final String? documentUrl;

  const StudentProfileState( {
    required this.isLoading,
    required this.isSuccess,
    required this.isError,
    this.studentProfileEntity,
    this.errorMessage,
    this.profilePictureUrl,
    this.documentUrl,
  });

  const StudentProfileState.initial()
      : isLoading = false,
        isSuccess = false,
        isError = false,
        studentProfileEntity=null,
        errorMessage = null,
        profilePictureUrl = null,
        documentUrl = null;

  StudentProfileState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    String? errorMessage,
    StudentProfileEntity? studentProfileEntity,
    String? profilePictureUrl,
    String? documentUrl,
  }) {
    return StudentProfileState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
      studentProfileEntity: studentProfileEntity??this.studentProfileEntity,
      errorMessage: errorMessage ?? this.errorMessage,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      documentUrl: documentUrl ?? this.documentUrl,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isSuccess,
    isError,
    studentProfileEntity,
    errorMessage,
    profilePictureUrl,
    documentUrl,
  ];
}