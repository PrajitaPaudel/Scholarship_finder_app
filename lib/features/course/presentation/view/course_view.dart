

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholarshuip_finder_app/features/course/presentation/view_model/course_bloc.dart';
import 'package:scholarshuip_finder_app/features/course/presentation/view_model/course_event.dart';
import 'package:scholarshuip_finder_app/features/course/presentation/view_model/course_state.dart';

import '../../../../app/widget/text/bigtext.dart';
import '../../../home/presentation/view/widget/feature_card.dart';
import 'course_detailed_view.dart';

class CourseView extends StatefulWidget {
  const CourseView({super.key});

  @override
  State<CourseView> createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
  @override
  void initState() {
    super.initState();
    context.read<CourseBloc>().add(GetAllCourseEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
 body: SingleChildScrollView(
   child: Padding(
     padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 10),
     child: Column(
       children: [
         BigText(text: 'Courses',),
         BlocBuilder<CourseBloc, CourseState>(
           builder: (context, state) {
             if (state.isLoading) {
               return const Center(child: CircularProgressIndicator());
             } else if (state.isError) {
               return Center(child: Text(
                   state.errorMessage ?? "Error loading data"));
             } else if (state.course == null ||
                 state.course!.isEmpty) {
               return const Center(
                   child: Text("No scholarship providers found"));
             } else {
               return SizedBox(
                 height: MediaQuery.of(context).devicePixelRatio*450,
                 width: MediaQuery.of(context).devicePixelRatio*440,
                 child: GridView.builder(
                   physics: NeverScrollableScrollPhysics(),
                   shrinkWrap: true,
                   padding: const EdgeInsets.all(8.0),
                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                     crossAxisCount: 2, // Two cards in a row
                     crossAxisSpacing: 5, // Space between columns
                     mainAxisSpacing: 2, // Space between rows
                     childAspectRatio: 0.8, // Adjust aspect ratio as needed
                   ),
                   itemCount: state.course!.length,
                   itemBuilder: (context, index) {
                     final provider = state.course![index];
     
                     return  FeaturedCard(
                       title: provider.title,
                       description: provider.description,
                       imagePath: 'assets/images/uni1.jpg',
                       onTap: (){
                         Navigator.push(
                           context,
                           MaterialPageRoute(
                             builder: (context) =>  CourseDetailedView(courseId: provider.id),
                           ),

                         );

                       },
                     );
                   },
                 ),
               );
     
             }
           },
         )
     
       ],
     ),
   ),
 ),

    );
  }
}
