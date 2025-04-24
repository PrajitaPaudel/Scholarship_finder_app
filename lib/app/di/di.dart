import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:scholarshuip_finder_app/app/constants/api_endpoints.dart';
import 'package:scholarshuip_finder_app/core/network/hive_service.dart';
import 'package:scholarshuip_finder_app/features/auth/data/data_source/local_data_source/auth_local_datasource.dart';
import 'package:scholarshuip_finder_app/features/auth/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:scholarshuip_finder_app/features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
import 'package:scholarshuip_finder_app/features/auth/data/repository/auth_remote_repository/auth_remote_repository.dart';
import 'package:scholarshuip_finder_app/features/auth/domain/use_case/login_usecase.dart';
import 'package:scholarshuip_finder_app/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:scholarshuip_finder_app/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:scholarshuip_finder_app/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:scholarshuip_finder_app/features/course/data/data_source/remote_course_data_source/remote_course_data_source.dart';
import 'package:scholarshuip_finder_app/features/course/data/repository/remote_course_repository.dart';
import 'package:scholarshuip_finder_app/features/course/domain/usecase/update_course_usecase.dart';
import 'package:scholarshuip_finder_app/features/course/presentation/view_model/course_bloc.dart';
import 'package:scholarshuip_finder_app/features/home/data/data_source/instituted_remote_data_source.dart';
import 'package:scholarshuip_finder_app/features/home/domain/repository/remote_instituted_repository.dart';
import 'package:scholarshuip_finder_app/features/home/domain/use_case/add_instituted_usecase.dart';
import 'package:scholarshuip_finder_app/features/home/domain/use_case/delete_instituted_usecase.dart';
import 'package:scholarshuip_finder_app/features/home/domain/use_case/get_instituted_by_id_usecase.dart';
import 'package:scholarshuip_finder_app/features/home/domain/use_case/get_instituted_usecase.dart';
import 'package:scholarshuip_finder_app/features/home/domain/use_case/update_instituted_udecase.dart';
import 'package:scholarshuip_finder_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:scholarshuip_finder_app/features/home/presentation/view_model/scholor_provider_bloc.dart';
import 'package:scholarshuip_finder_app/features/onboarding/presentation/view_model/onboarding_bloc.dart';
import 'package:scholarshuip_finder_app/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:scholarshuip_finder_app/features/student/domain/usecase/delete_studentprofile_usecase.dart';
import 'package:scholarshuip_finder_app/features/student/domain/usecase/get_studentprofile_byid_usecase.dart';
import 'package:scholarshuip_finder_app/features/student/domain/usecase/update_student_profile_usecase.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../features/course/domain/usecase/add_course_usecase.dart';
import '../../features/course/domain/usecase/delete_course_usecase.dart';
import '../../features/course/domain/usecase/get_all_course_usecase.dart';
import '../../features/course/domain/usecase/get_course_by_id_usecase.dart';
import '../../features/course/domain/usecase/get_course_scholor_provider_usecase.dart';
import '../../features/home/domain/use_case/get_instituted_by_filter.dart';
import '../../features/student/data/data_source/student_remote_data_source.dart';
import '../../features/student/data/repository/remote_student_profile_repository.dart';
import '../../features/student/domain/usecase/create_student_profile_usecase.dart';
import '../../features/student/domain/usecase/student_document_usecase.dart';
import '../../features/student/domain/usecase/upload_profile_usecase.dart';
import '../../features/student/presentation/view_model/student_bloc.dart';
import '../shared_prefs/token_shared_prefs.dart';



final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _initCoreDependencies();
  await _initAuthDependencies();
  await _initHomeDependencies();
  await _scholarshipProviderDependencies();
  await _initOnboardingDependencies();
  await _courseDependencies();
  await _initStudentProfileDependencies();
}

_initCoreDependencies() async {
  getIt.registerLazySingleton<Dio>(
        () => Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl)),

  );
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);
  getIt.registerLazySingleton<TokenSharedPrefs>(
          () => TokenSharedPrefs(getIt<SharedPreferences>()));

  getIt.registerLazySingleton<Logger>(() => Logger());

  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

 _initAuthDependencies() {
  getIt.registerLazySingleton<AuthLocalDataSource>(
        () => AuthLocalDataSource(getIt<HiveService>()),
  );

  getIt.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSource(getIt<Dio>(),getIt<TokenSharedPrefs>()),
  );

  getIt.registerLazySingleton<AuthLocalRepository>(
        () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );

  getIt.registerLazySingleton<AuthRemoteRepository>(
        () => AuthRemoteRepository(getIt<AuthRemoteDataSource>()),
  );

  getIt.registerLazySingleton<RegisterUseCase>(
        () => RegisterUseCase(getIt<AuthRemoteRepository>()),
  );

  getIt.registerLazySingleton<LoginUseCase>(
        () => LoginUseCase(getIt<AuthRemoteRepository>()),
  );

  getIt.registerFactory<RegisterBloc>(
        () => RegisterBloc(
      registerUseCase: getIt(),
      uploadImageUsecase: getIt(),
    ),
  );

  getIt.registerFactory<LoginBloc>(
        () => LoginBloc(
      loginUseCase: getIt<LoginUseCase>(),
    ),
  );
}

 _initHomeDependencies() {
  getIt.registerFactory<HomeCubit>(() => HomeCubit());
}

 _initOnboardingDependencies() {
  getIt.registerFactory<OnboardingBloc>(
        () => OnboardingBloc(loginBloc: getIt<LoginBloc>()),
  );

  getIt.registerFactory<SplashCubit>(
        () => SplashCubit(getIt<OnboardingBloc>()),
  );
}

_scholarshipProviderDependencies(){

  try {
    // Data Sources
    getIt
        .registerLazySingleton<InstituteRemoteDataSource>(() => InstituteRemoteDataSource(
        getIt<Logger>(),
      getIt<TokenSharedPrefs>(),
      getIt<Dio>(),
    ));

    // Repositories
    getIt.registerLazySingleton<InstitutedRepository>(() =>
        InstitutedRepository(  instituteDataSource:  getIt<InstituteRemoteDataSource>()));

    // Use Cases
    getIt.registerLazySingleton<AddScholarshipProviderUseCase>(() => AddScholarshipProviderUseCase(
      getIt<InstitutedRepository>(),
    ));

    getIt.registerLazySingleton<GetScholarshipProviderUseCase>(() => GetScholarshipProviderUseCase(
      getIt<InstitutedRepository>(),
    ));
    getIt.registerLazySingleton<GetScholarshipProviderByIdUseCase>(() => GetScholarshipProviderByIdUseCase(
      getIt<InstitutedRepository>(),
    ));
    getIt.registerLazySingleton<UpdateScholarshipProviderUseCase>(() => UpdateScholarshipProviderUseCase(
      getIt<InstitutedRepository>(),
    ));
    getIt.registerLazySingleton<DeleteScholarshipProviderUseCase>(() => DeleteScholarshipProviderUseCase(
      getIt<InstitutedRepository>(),
    ));
    getIt.registerLazySingleton<GetInstitutionsByFilterUseCase>(() => GetInstitutionsByFilterUseCase(
      getIt<InstitutedRepository>(),
    ));

    // Blocs
    getIt.registerFactory<ScholarshipProviderBloc>(() => ScholarshipProviderBloc(

      addScholarshipProviderUseCase: getIt<AddScholarshipProviderUseCase>(),
      getScholarshipProvidersUseCase: getIt<GetScholarshipProviderUseCase>(),
      updateScholarshipProviderUseCase: getIt<UpdateScholarshipProviderUseCase>(),
      deleteScholarshipProviderUseCase: getIt<DeleteScholarshipProviderUseCase>(),
      getScholarshipProviderByIdUseCase: getIt<GetScholarshipProviderByIdUseCase>(),
      getInstitutionsByFilterUseCase: getIt<GetInstitutionsByFilterUseCase>(),
    ));


  } catch (e) {
    print('Error initializing auth dependencies: $e');
    rethrow;
  }

}

 _courseDependencies() {

  try {
    // Data Sources
    getIt
        .registerLazySingleton<CourseRemoteDataSource>(() => CourseRemoteDataSource(
      getIt<Logger>(),
      getIt<TokenSharedPrefs>(),
      getIt<Dio>(),
    ));

    // Repositories
    getIt.registerLazySingleton<RemoteCourseRepository>(() =>
        RemoteCourseRepository(    getIt<CourseRemoteDataSource>()));

    // Use Cases
    getIt.registerLazySingleton<AddCourseUseCase>(() => AddCourseUseCase());

    getIt.registerLazySingleton<DeleteCourseUseCase>(() => DeleteCourseUseCase(
    ));
    getIt.registerLazySingleton<GeAllCourseUseCase>(() => GeAllCourseUseCase(
      getIt<RemoteCourseRepository>(),
    ));
    getIt.registerLazySingleton<GetCourseByIdUseCase>(() => GetCourseByIdUseCase(
      getIt<RemoteCourseRepository>(),
    ));
    getIt.registerLazySingleton<ScholorProviderCourseUseCase>(() => ScholorProviderCourseUseCase(
    ));
    getIt.registerLazySingleton<UpdateCourseUseCase>(() => UpdateCourseUseCase(
    ));


    // Blocs
    getIt.registerFactory<CourseBloc>(() => CourseBloc(

      addCourseUseCase: getIt<AddCourseUseCase>(),
      getAllCoursesUseCase: getIt<GeAllCourseUseCase>(),
      updateCourseUseCase: getIt<UpdateCourseUseCase>(),
      deleteCourseUseCase: getIt<DeleteCourseUseCase>(),
      getCourseByIdUseCase: getIt<GetCourseByIdUseCase>(),
      scholorProviderCourseUseCase: getIt<ScholorProviderCourseUseCase>(),
    ));


  } catch (e) {
    print('Error initializing auth dependencies: $e');
    rethrow;
  }

}


 _initStudentProfileDependencies() {
  try {
    // Data Sources
    getIt.registerLazySingleton<StudentProfileRemoteDataSource>(
          () => StudentProfileRemoteDataSource(
            getIt<Logger>(),
            getIt<TokenSharedPrefs>(),
            getIt<Dio>(),
      ),
    );

    // Repositories
    getIt.registerLazySingleton<StudentProfileRemoteRepository>(
          () => StudentProfileRemoteRepository(
          remoteDataSource: getIt<StudentProfileRemoteDataSource>(),
      ),
    );

    // Use Cases
    getIt.registerLazySingleton<CreateStudentProfileUseCase>(
          () => CreateStudentProfileUseCase(
        getIt<StudentProfileRemoteRepository>(),
      ),
    );

    getIt.registerLazySingleton<UploadProfilePictureUseCase>(
          () => UploadProfilePictureUseCase(
        getIt<StudentProfileRemoteRepository>(),
      ),
    );

    getIt.registerLazySingleton<UploadStudentDocumentUseCase>(
          () => UploadStudentDocumentUseCase(
        getIt<StudentProfileRemoteRepository>(),
      ),
    );
    getIt.registerLazySingleton<GetStudentProfileByIdUseCase>(
          () => GetStudentProfileByIdUseCase(
        getIt<StudentProfileRemoteRepository>(),
      ),
    );
    getIt.registerLazySingleton<UpdateStudentProfileUseCase>(
          () => UpdateStudentProfileUseCase(
        getIt<StudentProfileRemoteRepository>(),
      ),
    );
    getIt.registerLazySingleton<DeleteStudentProfileUseCase>(
          () => DeleteStudentProfileUseCase(
        getIt<StudentProfileRemoteRepository>(),
      ),
    );


    // Blocs
    getIt.registerFactory<StudentProfileBloc>(
          () => StudentProfileBloc(
        createStudentProfileUseCase: getIt<CreateStudentProfileUseCase>(),
        uploadProfilePictureUseCase: getIt<UploadProfilePictureUseCase>(),
        uploadStudentDocumentUseCase: getIt<UploadStudentDocumentUseCase>(),
            updateStudentProfileUseCase: getIt<UpdateStudentProfileUseCase>(),
            deleteStudentProfileUseCase: getIt<DeleteStudentProfileUseCase>(),
            getStudentProfileByIdUseCase:getIt<GetStudentProfileByIdUseCase>(),
      ),
    );
  } catch (e) {
    print('Error initializing student profile dependencies: $e');
    rethrow;
  }
}
