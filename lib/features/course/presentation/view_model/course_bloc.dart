import 'package:bloc/bloc.dart';
import '../../domain/usecase/add_course_usecase.dart';
import '../../domain/usecase/delete_course_usecase.dart';
import '../../domain/usecase/get_all_course_usecase.dart';
import '../../domain/usecase/get_course_by_id_usecase.dart';
import '../../domain/usecase/get_course_scholor_provider_usecase.dart';
import '../../domain/usecase/update_course_usecase.dart';
import 'course_event.dart';
import 'course_state.dart';




class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final AddCourseUseCase addCourseUseCase;
  final GeAllCourseUseCase getAllCoursesUseCase;
  final UpdateCourseUseCase updateCourseUseCase;
  final DeleteCourseUseCase deleteCourseUseCase;
  final GetCourseByIdUseCase getCourseByIdUseCase;
  final ScholorProviderCourseUseCase scholorProviderCourseUseCase;

  CourseBloc( {
    required this.addCourseUseCase,
    required this.getAllCoursesUseCase,
    required this.updateCourseUseCase,
   required this.deleteCourseUseCase,
    required this.getCourseByIdUseCase,
   required  this.scholorProviderCourseUseCase,
  }) : super(const CourseState.initial()) {
    on<AddCourseEvent>(_onAddCourse);
    on<GetAllCourseEvent>(_onGetAllCourses);
    on<UpdateCourseEvent>(_onUpdateCourse);
    on<DeleteCourseEvent>(_onDeleteCourse);
    on<GetCourseIdEvent>(_onGetCourseById);
    on<GetCourseScholorProviderEvent>(_onGetCourseScholorProvider);
  }

  Future<void> _onAddCourse(
      AddCourseEvent event,
      Emitter<CourseState> emit,
      ) async {
    emit(state.copyWith(isLoading: true));
    // final result = await addCourseUseCase(event.params);
    //
    // result.fold(
    //       (failure) => emit(state.copyWith(isLoading: false, isError: true, errorMessage: failure.message)),
    //       (course) => emit(state.copyWith(isLoading: false, isSuccess: true, courseEntity: course)),
    // );
  }

  Future<void> _onGetAllCourses(
      GetAllCourseEvent event,
      Emitter<CourseState> emit,
      ) async {
    emit(state.copyWith(isLoading: true));
    final result = await getAllCoursesUseCase();

    result.fold(
          (failure) => emit(state.copyWith(isLoading: false, isError: true, errorMessage: failure.message)),
          (courses) => emit(state.copyWith(isLoading: false, isSuccess: true, course: courses)),
    );
  }
  Future<void> _onGetCourseScholorProvider(
      GetCourseScholorProviderEvent event,
      Emitter<CourseState> emit,
      ) async {
    emit(state.copyWith(isLoading: true));
    final result = await scholorProviderCourseUseCase();

    result.fold(
          (failure) => emit(state.copyWith(isLoading: false, isError: true, errorMessage: failure.message)),
          (courses) => emit(state.copyWith(isLoading: false, isSuccess: true, course: courses)),
    );
  }


  Future<void> _onGetCourseById(
      GetCourseIdEvent event,
      Emitter<CourseState> emit,
      ) async {
    emit(state.copyWith(isLoading: true));
    final result = await getCourseByIdUseCase(event.id);

    result.fold(
          (failure) => emit(state.copyWith(isLoading: false, isError: true, errorMessage: failure.message)),
          (course) => emit(state.copyWith(isLoading: false, isSuccess: true, courseEntity: course)),
    );
  }

  Future<void> _onUpdateCourse(
      UpdateCourseEvent event,
      Emitter<CourseState> emit,
      ) async {
    emit(state.copyWith(isLoading: true));
    // final result = await updateCourseUseCase(event.id, event.courseEntity);
    //
    // result.fold(
    //       (failure) => emit(state.copyWith(isLoading: false, isError: true, errorMessage: failure.message)),
    //       (_) => emit(state.copyWith(isLoading: false, isSuccess: true)),
    // );
  }

  Future<void> _onDeleteCourse(
      DeleteCourseEvent event,
      Emitter<CourseState> emit,
      ) async {
    emit(state.copyWith(isLoading: true));
    final result = await deleteCourseUseCase(event.id);

    result.fold(
          (failure) => emit(state.copyWith(isLoading: false, isError: true, errorMessage: failure.message)),
          (_) => emit(state.copyWith(isLoading: false, isSuccess: true)),
    );
  }
}



