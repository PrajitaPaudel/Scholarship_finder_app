
import 'package:equatable/equatable.dart';
import 'package:scholarshuip_finder_app/features/student/domain/entity/course_entity.dart';

abstract class CourseEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddCourseEvent extends CourseEvent {
  final CourseEntity params;

  AddCourseEvent({required this.params});

  @override
  List<Object?> get props => [params];
}

class UpdateCourseEvent extends CourseEvent {
  final String id;
  final CourseEntity courseEntity;

  UpdateCourseEvent({required this.id, required this.courseEntity});

  @override
  List<Object?> get props => [id, courseEntity];
}


class DeleteCourseEvent extends CourseEvent {
  final String id;


  DeleteCourseEvent(this.id);

  @override
  List<Object?> get props => [id,];
}
 class GetAllCourseEvent extends CourseEvent{}

class GetCourseScholorProviderEvent extends CourseEvent{}

class GetCourseIdEvent extends CourseEvent {
  final String id;

  GetCourseIdEvent(this.id);

  @override
  List<Object?> get props => [id];
}
