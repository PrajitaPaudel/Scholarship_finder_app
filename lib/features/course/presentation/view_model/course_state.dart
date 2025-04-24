
import 'package:equatable/equatable.dart';
import 'package:scholarshuip_finder_app/features/student/domain/entity/course_entity.dart';

class CourseState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isError;
  final CourseEntity? courseEntity;
  final List<CourseEntity>? course;
  final String? errorMessage;
  const CourseState({
 required this.isLoading,
    required this.isSuccess,
    required this.isError,
  this.courseEntity,
  this.course,
    required  this.errorMessage});


  const CourseState.initial()
      : isLoading = false,
        isSuccess = false,
        isError = false,
        courseEntity = null,
        course = null,
        errorMessage = null;

  CourseState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    CourseEntity? courseEntity,
    List<CourseEntity>? course,
    String? errorMessage,
  }) {
    return CourseState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      courseEntity: courseEntity ?? this.courseEntity,
      course: course ?? this.course,
      errorMessage: errorMessage,
      isError: isError ?? this.isError,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isSuccess,
    courseEntity,
    course,
    errorMessage,
    isError,
  ];
}
