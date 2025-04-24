
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:scholarshuip_finder_app/app/widget/text/bigtext.dart';
import 'package:scholarshuip_finder_app/core/common/snackbar/my_snackbar.dart';
import 'package:scholarshuip_finder_app/features/student/domain/usecase/create_student_profile_usecase.dart';
import 'package:scholarshuip_finder_app/features/student/domain/usecase/update_student_profile_usecase.dart';
import 'package:scholarshuip_finder_app/features/student/presentation/view/widget/circle_file_picker_widget.dart';
import 'package:scholarshuip_finder_app/features/student/presentation/view/widget/circle_text_field.dart';
import 'package:scholarshuip_finder_app/features/student/presentation/view/widget/custom_round_image.dart';
import 'package:scholarshuip_finder_app/features/student/presentation/view/widget/custom_snakebar.dart';
import 'package:scholarshuip_finder_app/features/student/presentation/view/widget/date_of_birth_textfield_widget.dart';
import 'package:scholarshuip_finder_app/features/student/presentation/view/widget/profile_image_picker_widget.dart';


import '../../../../app/widget/Custom_button.dart';
import '../../../../app/widget/text/small_text.dart';
import '../../../home/presentation/view/home_view.dart';
import '../../domain/entity/student_profile_entity.dart';
import '../view_model/student_bloc.dart';
import '../view_model/student_event.dart';
import '../view_model/student_state.dart';
class UpdateStudentProfileView extends StatefulWidget {
  final StudentProfileEntity studentProfile;

  const UpdateStudentProfileView({super.key, required this.studentProfile});



  @override
  State<UpdateStudentProfileView> createState() => _UpdateStudentProfileViewState();
}


class _UpdateStudentProfileViewState extends State<UpdateStudentProfileView> {
  String? selectedFileName;
  File? selectedFile;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        selectedFileName = result.files.single.name;
        selectedFile = File(result.files.single.path!);
      });

      // Upload the document immediately
      context.read<StudentProfileBloc>().add(
        UploadStudentDocumentEvent(document: selectedFile!),
      );
    }
  }

  void _onCreateButtonPressed(BuildContext context) {
    final dateOfBirth = DateTime.parse(dobController.text);
    final studentProfileParams = UpdateStudentProfileParams(
      userId: '',
      fullName: fullNameController.text,
      email: emailController.text,
      phoneNumber: phoneNumberController.text,
      dateOfBirth: dateOfBirth,
      city: cityController.text,
      country: countryController.text,
      profilePictureUrl: context.read<StudentProfileBloc>().state.profilePictureUrl, // Use uploaded URL
      documentUrl:context.read<StudentProfileBloc>().state.documentUrl, // Use uploaded URL
    );

    context.read<StudentProfileBloc>().add(
      UpdateStudentProfileEvent(params: studentProfileParams),
    );
    CustomSnackbar.showSnackbar(context, "Profile update successful!", SnackbarType.success);
    _dispose();
  }

  void _dispose(){
    fullNameController.clear();
    emailController.clear();
    phoneNumberController.clear();
    dobController.clear();
    cityController.clear();
    countryController.clear();
  }
  @override
  void initState() {
    super.initState();
    // Populate text fields with existing student data
    fullNameController.text = widget.studentProfile.studentName ?? "";
    emailController.text = widget.studentProfile.email ?? "";
    phoneNumberController.text = widget.studentProfile.phoneNumber ?? "";
    dobController.text = widget.studentProfile.dob?.toString() ?? "";
    cityController.text = widget.studentProfile.address.city ?? "";
    countryController.text = widget.studentProfile.address.country ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final gap = SizedBox(height: 10);
    final size = SizedBox(height: 5);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Profile"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back arrow icon
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>HomeView (), // Replace with your screen
              ),
            );
          },
        ),
      ),

      body: SingleChildScrollView(


        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(child: ProfileImagePicker()),
              gap,

              BigText(
                padding: EdgeInsets.symmetric(horizontal: 10),
                text: 'Full Name',
                size: 16,
                color: Colors.grey,
              ),
              size,
              CircularTextField(
                controller: fullNameController,
                hintText: "Enter your Full Name",
                icon: Icons.person,
              ),
              gap,

              BigText(
                padding: EdgeInsets.symmetric(horizontal: 10),
                text: 'Email',
                size: 16,
                color: Colors.grey,
              ),
              size,
              CircularTextField(
                controller: emailController,
                hintText: "Enter your email",
                icon: Icons.email,
              ),
              gap,

              BigText(
                padding: EdgeInsets.symmetric(horizontal: 10),
                text: 'Phone Number',
                size: 16,
                color: Colors.grey,
              ),
              size,
              CircularTextField(
                controller: phoneNumberController,
                hintText: "Enter your Phone Number",
                icon: Icons.phone,
              ),
              gap,

              BigText(
                padding: EdgeInsets.symmetric(horizontal: 10),
                text: 'Date Of Birth',
                size: 16,
                color: Colors.grey,
              ),
              size,
              DateOfBirthField(controller: dobController),
              gap,

              BigText(
                padding: EdgeInsets.symmetric(horizontal: 10),
                text: 'City',
                size: 16,
                color: Colors.grey,
              ),
              size,
              CircularTextField(
                controller: cityController,
                hintText: "Enter your City",
                icon: Icons.location_on,
              ),
              gap,

              BigText(
                padding: EdgeInsets.symmetric(horizontal: 10),
                text: 'Country',
                size: 16,
                color: Colors.grey,
              ),
              size,
              CircularTextField(
                controller: countryController,
                hintText: "Enter your Country",
                icon: Icons.location_on,
              ),
              gap,

              BigText(
                padding: EdgeInsets.symmetric(horizontal: 10),
                text: 'Document',
                size: 16,
                color: Colors.grey,
              ),
              size,
              CircularFilePicker(
                fileName: selectedFileName,
                onPickFile: pickFile,
              ),
              gap,
              gap,

              // Create Profile Button
              BlocConsumer<StudentProfileBloc, StudentProfileState>(
                listener: (context, state) {
                  if (state.isSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Profile created successfully!')),
                    );
                  } else if (state.isError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errorMessage ?? 'An error occurred')),
                    );
                  }
                },
                builder: (context, state) {
                  if (state.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return CustomButton(
                    width: double.infinity,
                    onTap: () =>
                        _onCreateButtonPressed(context),
                    text: 'Update Profile',

                  );

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}