
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholarshuip_finder_app/app/widget/circular_container.dart';
import 'package:scholarshuip_finder_app/app/widget/text/bigtext.dart';
import 'package:scholarshuip_finder_app/app/widget/text/small_text.dart';
import 'package:scholarshuip_finder_app/features/home/presentation/view/bottom_view/universities_view.dart';
import 'package:scholarshuip_finder_app/features/home/presentation/view/home_view.dart';
import 'package:scholarshuip_finder_app/features/home/presentation/view_model/scholor_provider_event.dart';

import '../../../../app/widget/curved_widget.dart';
import '../../domain/entity/scholarship_provider_entity.dart';
import '../view_model/scholor_provider_bloc.dart';
import '../view_model/scholor_provider_state.dart';
import 'package:readmore/readmore.dart';


class ScholarshipProviderDetailPage extends StatefulWidget {
  final String providerId;

  const ScholarshipProviderDetailPage({super.key,  required this.providerId}) ;

  @override
  State<ScholarshipProviderDetailPage> createState() => _ScholarshipProviderDetailPageState();
}

class _ScholarshipProviderDetailPageState extends State<ScholarshipProviderDetailPage> {

  @override
  void initState() {
    super.initState();

    context.read<ScholarshipProviderBloc>().add(
        GetScholarshipProviderByIdEvent(widget.providerId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scholarship Provider Details"),
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

      body: BlocBuilder<ScholarshipProviderBloc, ScholarshipProviderState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.isError) {
            return Center(child: Text("Error: ${state.errorMessage}"));
          }
          if (state.scholarshipProviders == null ||
              state.scholarshipProviders!.isEmpty) {
            return const Center(child: Text("No Scholarship Provider Found"));
          }

          final scholarshipProvider = state.scholarshipProviders!.first;

          return SingleChildScrollView(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile and Cover Photo
                _buildProfileSection(scholarshipProvider),


                Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(text: "${scholarshipProvider
                            .name},${scholarshipProvider.university}",
                          fontWeight: FontWeight.bold,
                          size: 24,),
                        SizedBox(height: 20,),
                        TCircularContainer(

                          width: MediaQuery
                              .of(context)
                              .devicePixelRatio * 400,
                          padding: 20,
                          radius: 29,
                          backgroundColor: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade900.withOpacity(0.1),
                              // Soft shadow
                              blurRadius: 10,
                              // Increases the blur effect
                              spreadRadius: 2,
                              // Spreads shadow smoothly
                              offset: Offset(3, 3), // Controls shadow direction
                            ),
                          ],

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: "Contact"),
                              SizedBox(height: 10,),
                              SmallText(
                                  text: "Email: ${scholarshipProvider.contact
                                      .officialEmail}"),
                              SmallText(
                                  text: "Phone: ${scholarshipProvider.contact
                                      .phoneNumber}"),
                            ],
                          ),
                        ),
                        TCircularContainer(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          width: MediaQuery
                              .of(context)
                              .devicePixelRatio * 400,
                          padding: 20,
                          radius: 29,
                          backgroundColor: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade900.withOpacity(0.1),
                              // Soft shadow
                              blurRadius: 10,
                              // Increases the blur effect
                              spreadRadius: 2,
                              // Spreads shadow smoothly
                              offset: Offset(3, 3), // Controls shadow direction
                            ),
                          ],

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: "Location"),
                              SizedBox(height: 10,),
                              Row(

                                children: [
                                  SmallText(
                                      text: "Location: ${scholarshipProvider
                                          .location.city}"),
                                  SizedBox(width: 40,),
                                  SmallText(
                                      text: "Country: ${scholarshipProvider
                                          .location.country}")
                                ],
                              ),

                            ],
                          ),
                        ),

                        TCircularContainer(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          width: MediaQuery
                              .of(context)
                              .devicePixelRatio * 400,
                          padding: 20,
                          radius: 29,
                          backgroundColor: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade900.withOpacity(0.1),
                              // Soft shadow
                              blurRadius: 10,
                              // Increases the blur effect
                              spreadRadius: 2,
                              // Spreads shadow smoothly
                              offset: Offset(3, 3), // Controls shadow direction
                            ),
                          ],

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: "Description",
                                  fontWeight: FontWeight.w800),
                              SizedBox(height: 10,),
                              ReadMoreText(
                                scholarshipProvider.description,
                                trimLines: 4,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: "Show more",
                                trimExpandedText: "less",
                                moreStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.blue,
                                ),
                                lessStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.red,
                                ),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.justify,
                              )


                            ],
                          ),
                        ),
                        TCircularContainer(

                          width: MediaQuery
                              .of(context)
                              .devicePixelRatio * 400,
                          padding: 20,
                          radius: 29,
                          backgroundColor: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade900.withOpacity(0.1),
                              // Soft shadow
                              blurRadius: 10,
                              // Increases the blur effect
                              spreadRadius: 2,
                              // Spreads shadow smoothly
                              offset: Offset(3, 3), // Controls shadow direction
                            ),
                          ],

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: "🎓 Scholarship Courses"),
                              SizedBox(height: 10,),
                              SmallText(
                                  text: "${scholarshipProvider.university}"),


                            ],
                          ),
                        ),


                      ],
                    )
                ),


              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileSection(ScholarshipProviderEntity provider) {
    return Column(
      children: [

        TCurvedWidget(

          child: Container(
              height: 250,
              child: Image.asset('assets/images/sdt1.jpg',
                fit: BoxFit.cover,
              )),
        ),


      ],
    );
  }
}


