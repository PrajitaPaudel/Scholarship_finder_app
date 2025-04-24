import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/scholor_provider_bloc.dart';
import '../view_model/scholor_provider_event.dart';
import '../view_model/scholor_provider_state.dart';


class ScholarshipProviderSearchPage extends StatefulWidget {
  @override
  _ScholarshipProviderSearchPageState createState() =>
      _ScholarshipProviderSearchPageState();
}

class _ScholarshipProviderSearchPageState
    extends State<ScholarshipProviderSearchPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Scholarship Providers'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search TextField for the user to enter city, country, etc.
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Enter search criteria (City, Country, Course)',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // Trigger search event when the user taps on search icon
                    context.read<ScholarshipProviderBloc>().add(FetchScholarshipProvidersEvent(
                      cities: [searchController.text],
                      countries: [searchController.text],
                      courses: [searchController.text],
                      searchQuery: searchController.text,
                      scholarshipTypes: [], // Add any additional filters if needed
                    ));
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            // Displaying results using BlocBuilder
            BlocBuilder<ScholarshipProviderBloc, ScholarshipProviderState>(
              builder: (context, state) {
                // If data is loading
                if (state.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                // If there was an error
                if (state.isError) {
                  return Center(
                    child: Text(
                      state.errorMessage ?? 'An error occurred. Please try again.',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }

                // If the data is successfully fetched
                if (state.isSuccess && state.scholarshipProviders != null) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.scholarshipProviders!.length,
                      itemBuilder: (context, index) {
                        final scholarshipProvider = state.scholarshipProviders![index];
                        return ListTile(
                          title: Text(scholarshipProvider.name),
                          subtitle: Text(scholarshipProvider.description ?? 'No description available'),
                          onTap: () {
                            // Handle tap (for example, navigate to details page)
                          },
                        );
                      },
                    ),
                  );
                }

                // Default empty state if no results
                return Center(
                  child: Text('No scholarship providers available'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


