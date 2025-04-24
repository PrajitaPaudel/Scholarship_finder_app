import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholarshuip_finder_app/app/di/di.dart';
import 'package:scholarshuip_finder_app/app/app.dart';
import 'package:scholarshuip_finder_app/features/student/presentation/view_model/student_bloc.dart';

import 'core/network/hive_service.dart';
import 'features/course/presentation/view_model/course_bloc.dart';
import 'features/home/presentation/view_model/home_cubit.dart';
import 'features/home/presentation/view_model/scholor_provider_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();

  // Initialize your dependencies
  await initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(),
        ),
        BlocProvider<ScholarshipProviderBloc>(create: (_) => getIt<ScholarshipProviderBloc>()),
        BlocProvider<CourseBloc>(create: (_) => getIt<CourseBloc>()),
        BlocProvider<StudentProfileBloc>(create: (_) => getIt<StudentProfileBloc>()),
      ],
      child: App(),
    ),
  );
}

