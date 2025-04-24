import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

import '../../view_model/student_bloc.dart';
import '../../view_model/student_event.dart';

class ProfileImagePicker extends StatefulWidget {
  const ProfileImagePicker({super.key});

  @override
  _ProfileImagePickerState createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });

      // Dispatch event to BLoC to update profile picture
      context.read<StudentProfileBloc>().add(
        UploadProfilePictureEvent(image: _selectedImage!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileState = context.watch<StudentProfileBloc>().state;

    return Center(
      child: Stack(
        children: [
          Container(
            height: 140,
            width: 140,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent.shade700, width: 5),
              color: Colors.grey,
              shape: BoxShape.circle,
              image: _selectedImage != null
                  ? DecorationImage(
                image: FileImage(_selectedImage!), // Display locally selected image
                fit: BoxFit.cover,
              )
                  : profileState.profilePictureUrl != null
                  ? DecorationImage(
                image: NetworkImage(profileState.profilePictureUrl!), // Display backend image
                fit: BoxFit.cover,
              )
                  : const DecorationImage(
                image: AssetImage('assets/images/profile.png'), // Default image
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: -1,
            right: 10,
            child: IconButton(
              onPressed: _pickImage, // Opens image picker
              icon: Icon(
                Iconsax.edit_2,
                size: 27,
                color: Colors.blue.shade900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}