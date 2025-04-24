

import 'package:equatable/equatable.dart';

import '../../domain/entity/scholarship_provider_entity.dart';

class ScholarshipProviderState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isError;
  final ScholarshipProviderEntity? scholarshipProvider;
  final List<ScholarshipProviderEntity>? scholarshipProviders;
  final String? errorMessage;

  const ScholarshipProviderState({
    required this.isLoading,
    required this.isSuccess,
    this.scholarshipProvider,
    this.scholarshipProviders,
    required this.isError,
    this.errorMessage,
  });

  const ScholarshipProviderState.initial()
      : isLoading = false,
        isSuccess = false,
        isError = false,
        scholarshipProvider = null,
        scholarshipProviders = null,
        errorMessage = null;

  ScholarshipProviderState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    ScholarshipProviderEntity? scholarshipProvider,
    List<ScholarshipProviderEntity>? scholarshipProviders,
    String? errorMessage,
  }) {
    return ScholarshipProviderState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      scholarshipProvider: scholarshipProvider ?? this.scholarshipProvider,
      scholarshipProviders: scholarshipProviders ?? this.scholarshipProviders,
      errorMessage: errorMessage,
      isError: isError ?? this.isError,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isSuccess,
    scholarshipProvider,
    scholarshipProviders,
    errorMessage,
    isError,
  ];
}
