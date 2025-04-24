import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_model/scholor_provider_bloc.dart';
import '../../view_model/scholor_provider_event.dart';
import '../../view_model/scholor_provider_state.dart';
import '../scholor_provider_detailed_view.dart';
import '../widget/scholarship_card.dart';

class UniversitiesView extends StatefulWidget {
  const UniversitiesView({super.key});



  @override
  State<UniversitiesView> createState() => _UniversitiesViewState();
}



class _UniversitiesViewState extends State<UniversitiesView> {

  @override
  void initState() {
    super.initState();
    context.read<ScholarshipProviderBloc>().add(GetScholarshipProvidersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Popular Universities',
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: 500,
                height: 190, // Constrain height
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  padding: EdgeInsets.zero,
                  itemBuilder: (_, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: ScholarshipProviderCard(
                        name: "Oxford University",
                        location: "United Kingdom",
                        scholarshipCount: 25,
                        imagePath: 'assets/images/oxford.jpg',
                        elevation: 8,
                        borderRadius: 15,
                        overlayColor: Colors.black.withOpacity(0.5), onTap: () {  },
                      ),
                    );
                  },
                ),
              ),


              SizedBox(height: 30),
              Text(
                'All Universities',
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 16),
              BlocBuilder<ScholarshipProviderBloc, ScholarshipProviderState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.isError) {
                    return Center(child: Text(
                        state.errorMessage ?? "Error loading data"));
                  } else if (state.scholarshipProviders == null ||
                      state.scholarshipProviders!.isEmpty) {
                    return const Center(
                        child: Text("No scholarship providers found"));
                  } else {
                    return SizedBox(
                      height: MediaQuery.of(context).devicePixelRatio*400,
                      width: MediaQuery.of(context).devicePixelRatio*400,
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8.0),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Two cards in a row
                          crossAxisSpacing: 5, // Space between columns
                          mainAxisSpacing: 2, // Space between rows
                          childAspectRatio: 0.89, // Adjust aspect ratio as needed
                        ),
                        itemCount: state.scholarshipProviders!.length,
                        itemBuilder: (context, index) {
                          final provider = state.scholarshipProviders![index];

                          return ScholarshipProviderCard(
                            name: provider.name,
                            location: '${provider.location.city}, ${provider.location.country}',
                            scholarshipCount: 25,
                            imagePath: provider.coverPhoto ?? 'assets/images/unit1.jpg',
                            onTap: () {
                              print('userId:${provider.userId}');

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ScholarshipProviderDetailPage(providerId: provider.userId),
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


