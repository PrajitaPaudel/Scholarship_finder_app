

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholarshuip_finder_app/app/widget/circular_container.dart';
import 'package:scholarshuip_finder_app/app/widget/curved_widget.dart';
import 'package:scholarshuip_finder_app/app/widget/text/bigtext.dart';
import 'package:scholarshuip_finder_app/app/widget/text/small_text.dart';
import 'package:scholarshuip_finder_app/features/course/presentation/view_model/course_bloc.dart';
import 'package:scholarshuip_finder_app/features/course/presentation/view_model/course_event.dart';
import 'package:scholarshuip_finder_app/features/course/presentation/view_model/course_state.dart';

class CourseDetailedView extends StatefulWidget {
  final String courseId;
  const CourseDetailedView({super.key, required this.courseId});

  @override
  State<CourseDetailedView> createState() => _CourseDetailedViewState();
}

class _CourseDetailedViewState extends State<CourseDetailedView> {

  @override
  void initState() {
    super.initState();

    context.read<CourseBloc>().add(GetCourseIdEvent(widget.courseId));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Course Details"),

      ),
      body: BlocBuilder<CourseBloc, CourseState>(
        builder: (context, state) {
      if (state.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state.isError) {
        return Center(child: Text("Error: ${state.errorMessage}"));
      }
      if (state.courseEntity == null ) {
        return const Center(child: Text("No Scholarship Provider Found"));
      }

      final course = state.courseEntity;

      return
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            TCurvedWidget(
              child:Container(
                color: Colors.blueAccent,
                child: Stack(
                  children: [
                    Image.asset(
                        'assets/images/background.jpg',
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 118,
                        right: 80,
                        child: BigText(


                          text:course?.title??"",color: Colors.white,size: 30, ))
                  ],
                ),
              ) ,
            ),
            TCircularContainer(
              width: MediaQuery.of(context).devicePixelRatio*400,
              margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              radius: 29,
              padding: 20,
              backgroundColor: Colors.blue.shade400.withOpacity(0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(text: 'Description',color: Colors.blueGrey.shade700,),
                  SizedBox(height: 10,),
                  SmallText(text:course?.description??"" )
                ]
              ),
            ),

            TCircularContainer(
              width: MediaQuery.of(context).devicePixelRatio*400,
              margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              radius: 29,
              padding: 20,
              backgroundColor: Colors.blue.shade400.withOpacity(0.1),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: 'ScholorShipType',color: Colors.blueGrey.shade700,),
                    SizedBox(height: 10,),
                    SmallText(text:course?.scholarshipType??"" )
                  ]
              ),
            ),
            TCircularContainer(
              width: MediaQuery.of(context).devicePixelRatio*400,
              margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              radius: 29,
              padding: 20,
              backgroundColor: Colors.blue.shade400.withOpacity(0.1),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: 'ScholorShipAmount',color: Colors.blueGrey.shade700,),
                    SizedBox(height: 10,),
                    SmallText(text: "\$${course?.scholarshipAmount.toString() ?? ''}",textColor: Colors.green,size: 20,fontWeight: FontWeight.w800, )
                  ]
              ),
            ),
            TCircularContainer(
              width: MediaQuery.of(context).devicePixelRatio*400,
              margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              radius: 29,
              padding: 20,
              backgroundColor: Colors.blue.shade400.withOpacity(0.1),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: 'EligibilityCriteria',color: Colors.blueGrey.shade700,),
                    SizedBox(height: 10,),
                    SmallText(text: course?.eligibilityCriteria??"",)
                  ]
              ),
            ),
            TCircularContainer(
              width: MediaQuery.of(context).devicePixelRatio*400,
              margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              radius: 29,
              padding: 20,
              backgroundColor: Colors.blue.shade400.withOpacity(0.1),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: 'DeadLine',color: Colors.blueGrey.shade700,),
                    SizedBox(height: 10,),
                    SmallText(text: course?.deadline??"",fontWeight: FontWeight.bold,textColor:Colors.red,)
                  ]
              ),
            ),
            TCircularContainer(
              width: MediaQuery.of(context).devicePixelRatio*400,
              margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              radius: 29,
              padding: 20,
              backgroundColor: Colors.blue.shade400.withOpacity(0.1),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800.withOpacity(0.2), // Set background color
                  side: BorderSide(color: Colors.transparent), // Optional: Customize border color
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Optional: Adjust padding
                ),
                onPressed: () {},
                child: BigText(
                  text: 'Apply',
                  color: Colors.blueGrey.shade700,
                ),
              )

            ),

          ],
        ),
      );
        },
      ),
    );
  }
}
