import 'package:equatable/equatable.dart';
import 'package:scholarshuip_finder_app/features/student/domain/usecase/create_student_profile_usecase.dart';
import 'dart:io';

import '../../domain/entity/student_profile_entity.dart';
import '../../domain/usecase/update_student_profile_usecase.dart';

abstract class StudentProfileEvent extends Equatable {
  const StudentProfileEvent();

  @override
  List<Object?> get props => [];
}

class CreateStudentProfileEvent extends StudentProfileEvent {
  final CreateStudentProfileParams params;

  const CreateStudentProfileEvent({required this.params});

  @override
  List<Object?> get props => [params];
}

class UploadProfilePictureEvent extends StudentProfileEvent {
  final File image;

  const UploadProfilePictureEvent({required this.image});

  @override
  List<Object?> get props => [image];
}

class UploadStudentDocumentEvent extends StudentProfileEvent {
  final File document;

  const UploadStudentDocumentEvent({required this.document});

  @override
  List<Object?> get props => [document];
}

class GetStudentProfileByIdEvent extends StudentProfileEvent{}

class UpdateStudentProfileEvent extends StudentProfileEvent {
  final UpdateStudentProfileParams params;

  const UpdateStudentProfileEvent({ required this.params});

  @override
  List<Object?> get props => [params];
}
class DeleteStudentProfileEvent extends StudentProfileEvent {
  final String id;


  const DeleteStudentProfileEvent(this.id);

  @override
  List<Object?> get props => [id,];
}