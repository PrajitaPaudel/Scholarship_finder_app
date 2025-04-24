import 'package:bloc/bloc.dart';
import 'package:scholarshuip_finder_app/features/home/presentation/view_model/scholor_provider_event.dart';
import 'package:scholarshuip_finder_app/features/student/domain/usecase/get_studentprofile_byid_usecase.dart';
import 'package:scholarshuip_finder_app/features/student/presentation/view_model/student_event.dart';
import 'package:scholarshuip_finder_app/features/student/presentation/view_model/student_state.dart';

import '../../domain/usecase/create_student_profile_usecase.dart';
import '../../domain/usecase/delete_studentprofile_usecase.dart';
import '../../domain/usecase/student_document_usecase.dart';
import '../../domain/usecase/update_student_profile_usecase.dart';
import '../../domain/usecase/upload_profile_usecase.dart';
import '../view/widget/custom_snakebar.dart';
class StudentProfileBloc extends Bloc<StudentProfileEvent, StudentProfileState> {
  final CreateStudentProfileUseCase createStudentProfileUseCase;
  final UploadProfilePictureUseCase uploadProfilePictureUseCase;
  final UploadStudentDocumentUseCase uploadStudentDocumentUseCase;
  final UpdateStudentProfileUseCase updateStudentProfileUseCase;
  final DeleteStudentProfileUseCase deleteStudentProfileUseCase;
  final GetStudentProfileByIdUseCase getStudentProfileByIdUseCase;
  StudentProfileBloc( {
    required this.createStudentProfileUseCase,
    required this.uploadProfilePictureUseCase,
    required this.uploadStudentDocumentUseCase,
    required this.updateStudentProfileUseCase,
    required this.deleteStudentProfileUseCase,
    required this.getStudentProfileByIdUseCase,
  }) : super(const StudentProfileState.initial()) {
    on<CreateStudentProfileEvent>(_onCreateStudentProfile);
    on<UploadProfilePictureEvent>(_onUploadProfilePicture);
    on<UploadStudentDocumentEvent>(_onUploadStudentDocument);
    on<UpdateStudentProfileEvent>(_onUpdateCourse);
    on<DeleteStudentProfileEvent>(_onDeleteStudentProfile);
    on<GetStudentProfileByIdEvent>(_onGetStudentProfile);
  }

  Future<void> _onCreateStudentProfile(
      CreateStudentProfileEvent event,
      Emitter<StudentProfileState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, isSuccess: false, errorMessage: null));

    try {
      final result = await createStudentProfileUseCase(event.params);

      result.fold(
            (failure) {
          emit(state.copyWith(isLoading: false, isError: true, errorMessage: failure.toString()));
        },
            (studentProfile) {
          emit(state.copyWith(isLoading: false, isSuccess: true));


            },
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, isError: true, errorMessage: e.toString()));
    }
  }

  Future<void> _onUploadProfilePicture(
      UploadProfilePictureEvent event,
      Emitter<StudentProfileState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, isSuccess: false, errorMessage: null));

    try {
      final result = await uploadProfilePictureUseCase(UploadProfilePictureParams(image: event.image));

      result.fold(
            (failure) {
          emit(state.copyWith(isLoading: false, isError: true, errorMessage: failure.toString()));
        },
            (imageUrl) {

          emit(state.copyWith(isLoading: false, profilePictureUrl: imageUrl));
        },
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, isError: true, errorMessage: e.toString()));
    }
  }

  Future<void> _onUploadStudentDocument(
      UploadStudentDocumentEvent event,
      Emitter<StudentProfileState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, isSuccess: false, errorMessage: null));

    try {
      final result = await uploadStudentDocumentUseCase(UploadStudentDocumentParams(document: event.document));

      result.fold(
            (failure) {
          emit(state.copyWith(isLoading: false, isError: true, errorMessage: failure.toString()));
          print(failure.toString());
        },
            (documentUrl) {
          emit(state.copyWith(isLoading: false, documentUrl: documentUrl));
        },
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, isError: true, errorMessage: e.toString()));
    }
  }


  Future<void> _onUpdateCourse(
      UpdateStudentProfileEvent event,
      Emitter<StudentProfileState> emit,
      ) async {
    emit(state.copyWith(isLoading: true));
    final result = await updateStudentProfileUseCase( event.params);

    result.fold(
          (failure) => emit(state.copyWith(isLoading: false, isError: true, errorMessage: failure.message)),
          (_) => emit(state.copyWith(isLoading: false, isSuccess: true)),
    );
  }
  Future<void> _onDeleteStudentProfile(
      DeleteStudentProfileEvent event,
      Emitter<StudentProfileState> emit,
      ) async {
    emit(state.copyWith(isLoading: true));
    final result = await deleteStudentProfileUseCase(event.id);

    result.fold(
          (failure) => emit(state.copyWith(isLoading: false, isError: true, errorMessage: failure.message)),
          (_) => emit(state.copyWith(isLoading: false, isSuccess: true)),
    );
  }
  Future<void> _onGetStudentProfile(
      GetStudentProfileByIdEvent event,
      Emitter<StudentProfileState> emit,
      ) async {
    emit(state.copyWith(isLoading: true));
    final result = await getStudentProfileByIdUseCase();

    result.fold(
          (failure) => emit(state.copyWith(isLoading: false, isError: true, errorMessage: failure.message)),
          (student) => emit(state.copyWith(isLoading: false, isSuccess: true, studentProfileEntity: student)),
    );
  }
}