import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:scholarshuip_finder_app/features/home/presentation/view/bottom_view/account_view.dart';
import 'package:scholarshuip_finder_app/features/home/presentation/view/bottom_view/dashboard_view.dart';
import 'package:scholarshuip_finder_app/features/home/presentation/view/bottom_view/scholarship_view.dart';
import 'package:scholarshuip_finder_app/features/home/presentation/view/bottom_view/universities_view.dart';

import '../../../course/presentation/view/course_view.dart';
import '../../../student/presentation/view/add_student_profile.dart';
import '../../../student/presentation/view/display_student_profile.dart';

class HomeState extends Equatable {
  final int selectedIndex;
  final List<Widget> views;
  final bool isLoading;

  const HomeState({
    required this.selectedIndex,
    required this.views,
    this.isLoading = false,
  });

  // Initial state
  static HomeState initial() {
    return HomeState(
      selectedIndex: 0,
      views: [
        const Center(child: DashboardView()),
        const Center(child: UniversitiesView()),
        Center(child: CourseView()),
        const Center(child: DisplayStudentProfileView()),
      ],
      isLoading: false,
    );
  }

  HomeState copyWith({
    int? selectedIndex,
    List<Widget>? views,
    bool? isLoading,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, views, isLoading];
}

