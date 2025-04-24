import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholarshuip_finder_app/features/auth/presentation/view_model/login/login_bloc.dart';

import '../../../../course/presentation/view/course_detailed_view.dart';
import '../../../../course/presentation/view_model/course_bloc.dart';
import '../../../../course/presentation/view_model/course_event.dart';
import '../../../../course/presentation/view_model/course_state.dart';
import '../../view_model/scholor_provider_bloc.dart';
import '../../view_model/scholor_provider_event.dart';
import '../../view_model/scholor_provider_state.dart';
import '../scholor_provider_detailed_view.dart';
import '../search_page.dart';
import '../widget/feature_card.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  void initState() {
    super.initState();
    context.read<CourseBloc>().add(GetAllCourseEvent());
    context.read<ScholarshipProviderBloc>().add(GetScholarshipProvidersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Welcome Section
              Padding(
                padding: const EdgeInsets.only(bottom:2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Welcome, John Doe',
                        style: Theme.of(context).textTheme.bodyLarge),
                    IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: () {
                        // Navigate to settings
                      },
                    ),
                  ],
                ),
              ),
              Text(
                'Most Popular Courses',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 20,),
              // Featured Scholarships Carousel
        BlocBuilder<CourseBloc, CourseState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.isError) {
              return Center(child: Text(state.errorMessage ?? "Error loading data"));
            } else if (state.course == null || state.course!.isEmpty) {
              return const Center(child: Text("No scholarship providers found"));
            } else {
              return SizedBox(
                height: 250, // Adjust height to fit card size
                child: ListView.builder(
                  scrollDirection: Axis.horizontal, // Enables horizontal scrolling
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  itemCount: 4, // Display all items
                  itemBuilder: (context, index) {
                    final provider = state.course![index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0), // Space between cards
                      child: FeaturedCard(
                        title: provider.title,
                        description: provider.description,
                        imagePath: 'assets/images/uni1.jpg',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CourseDetailedView(courseId: provider.id),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),


              const SizedBox(height: 20),
              // Quick Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _quickActionButton(context, 'Search', Icons.search,(){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScholarshipProviderSearchPage(),
                      ),
                    );
                  }),
                  _quickActionButton(context, 'Applied ', Icons.check_circle,(){},),
                  _quickActionButton(context, 'Saved ', Icons.favorite,(){}),
                ],
              ),
              const SizedBox(height: 20),
              // Notifications Section
              Card(
                elevation: 4,
                child: ListTile(
                  leading: Icon(Icons.notifications_active),
                  title: Text('New Scholarship Opportunity'),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    // Navigate to scholarship details
                  },
                ),
              ),
              const SizedBox(height: 20),
              // Most Popular Scholarships Grid
              Text(
                'Most Popular Scholarships',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 10),
        BlocBuilder<ScholarshipProviderBloc, ScholarshipProviderState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.isError) {
              return Center(child: Text(state.errorMessage ?? "Error loading data"));
            } else if (state.scholarshipProviders == null || state.scholarshipProviders!.isEmpty) {
              return const Center(child: Text("No scholarship providers found"));
            } else {
              return SizedBox(
                height: MediaQuery.of(context).devicePixelRatio * 200,
                width: MediaQuery.of(context).devicePixelRatio * 400,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Two cards per row
                    crossAxisSpacing: 5, // Space between columns
                    mainAxisSpacing: 2, // Space between rows
                    childAspectRatio: 0.70, // Adjust aspect ratio as needed
                  ),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    final provider = state.scholarshipProviders![index];

                    return GestureDetector(
                      onTap: () {
                        print('userId:${provider.userId}');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScholarshipProviderDetailPage(providerId: provider.userId),
                          ),
                        );
                      },
                      child: _popularScholarshipCard(
                        provider.name,
                        '${2500} students applied', // Using scholarship count if available
                         'assets/images/sdt1.jpg',
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),

        ],
          ),
        ),
      ),
    );
  }

  Widget _quickActionButton(BuildContext context, String title, IconData icon , VoidCallback onTap) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon),
      label: Text(title),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _popularScholarshipCard(String title, String stats, String imagePath) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              stats,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
