


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholarshuip_finder_app/app/widget/Custom_button.dart';
import 'package:scholarshuip_finder_app/app/widget/curved_widget.dart';
import 'package:scholarshuip_finder_app/features/course/presentation/view_model/course_bloc.dart';
import 'package:scholarshuip_finder_app/features/course/presentation/view_model/course_event.dart';
import 'package:scholarshuip_finder_app/features/course/presentation/view_model/course_state.dart';
import 'package:scholarshuip_finder_app/features/student/presentation/view_model/student_bloc.dart';
import 'package:scholarshuip_finder_app/features/student/presentation/view_model/student_state.dart';
import 'package:intl/intl.dart';

import '../../../../app/widget/circular_container.dart';
import '../../../../app/widget/text/bigtext.dart';
import '../../../../app/widget/text/small_text.dart';
import '../../../home/presentation/view_model/home_cubit.dart';
import '../../../home/presentation/view_model/home_state.dart';
import '../view_model/student_event.dart';
import 'add_student_profile.dart';
import 'update_student_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DisplayStudentProfileView extends StatefulWidget {
  const DisplayStudentProfileView({super.key});

  @override
  State<DisplayStudentProfileView> createState() => _DisplayStudentProfileViewState();
}

class _DisplayStudentProfileViewState extends State<DisplayStudentProfileView> {
  @override
  void initState() {
    super.initState();
    context.read<StudentProfileBloc>().add(GetStudentProfileByIdEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<StudentProfileBloc, StudentProfileState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.isError) {
            return Center(child: Text("Error: ${state.errorMessage}"));
          }
          if (state.studentProfileEntity == null) {
            return const Center(child: Text("No Student Profile Found"));
          }

          final student = state.studentProfileEntity;

          return SingleChildScrollView(
            child: Column(
              children: [
                // Header Section with Image and Action Buttons
                SizedBox(
                  child: TCurvedWidget(
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/images/profile4.jpg',
                          fit: BoxFit.cover,
                          height: 250,
                          width: double.infinity,
                        ),
                        Positioned(
                          right: 18,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddStudentProfileView(),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.add, size: 35, color: Colors.white),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpdateStudentProfileView(studentProfile: student!),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.edit_rounded, size: 35, color: Colors.white),
                              ),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Confirm Deletion'),
                                      content: const Text('Are you sure you want to delete this profile?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            context.read<StudentProfileBloc>().add(DeleteStudentProfileEvent(student?.userId ?? ''));
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Delete', style: TextStyle(color: Colors.red)),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                icon: Icon(Icons.delete, color: Colors.red.withOpacity(0.8), size: 35),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            
                // Profile Details Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      TCircularContainer(
                        margin: const EdgeInsets.symmetric(vertical: 0),
                        padding: 20,
                        radius: 20,
                        backgroundColor: Colors.grey.shade50,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 10,
                            spreadRadius: 1,
                            offset: const Offset(3, 3),
                          ),
                        ],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Details',
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
            
                            _buildDetailRow('Name:', student?.studentName ?? ""),
                            _buildDetailRow('Phone:', student?.phoneNumber ?? ""),
                            _buildDetailRow('Email:', student?.email ?? ""),
                            _buildDetailRow('City:', student?.address.city ?? ""),
                            _buildDetailRow('Country:', student?.address.country ?? ""),
                            _buildDetailRow(
                              'Date of Birth:',
                              student?.dob != null
                                  ? DateFormat('yyyy-MM-dd').format(student!.dob!)
                                  : "",
                            ),
                          ],
                        ),
                      ),
                      BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          return TCircularContainer(
                            onTap: () {

                              if (!state.isLoading) {
                                context.read<HomeCubit>().logout(context);
                              }
                            },
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            padding: 20,
                            radius: 20,
                            backgroundColor: Colors.grey.shade50,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 10,
                                spreadRadius: 1,
                                offset: const Offset(3, 3),
                              ),
                            ],
                            child: state.isLoading
                                ? Center(child: CircularProgressIndicator())
                                : Row(
                              children: [
                                IconButton(
                                  onPressed: () {

                                    if (!state.isLoading) {
                                      context.read<HomeCubit>().logout(context);
                                    }
                                  },
                                  icon: Icon(Icons.logout),
                                ),
                                SmallText(
                                  text: 'Logout',
                                  size: 18,
                                  textColor: Colors.grey.shade800,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          );
                        },
                      ),



                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Helper method to build a detail row
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              value.isNotEmpty
                  ? "${value[0].toUpperCase()}${value.substring(1)}"
                  : "",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w400,
              ),
            )

          ),
        ],
      ),
    );
  }
}




