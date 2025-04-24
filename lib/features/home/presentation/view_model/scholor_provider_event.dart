
import 'package:equatable/equatable.dart';

import '../../domain/entity/scholarship_provider_entity.dart';


abstract class ScholarshipProviderEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetScholarshipProvidersEvent extends ScholarshipProviderEvent {}

// 📌 Create a new scholarship provider
class AddScholarshipProviderEvent extends ScholarshipProviderEvent {
  final ScholarshipProviderEntity params;

  AddScholarshipProviderEvent({required this.params});

  @override
  List<Object?> get props => [params];
}

// 📌 Update an existing scholarship provider
class UpdateScholarshipProviderEvent extends ScholarshipProviderEvent {
  final String id;
  final ScholarshipProviderEntity scholarshipProvider;

  UpdateScholarshipProviderEvent({required this.id, required this.scholarshipProvider});

  @override
  List<Object?> get props => [id, scholarshipProvider];
}


// 📌 Delete a scholarship provider
class DeleteScholarshipProviderEvent extends ScholarshipProviderEvent {
  final String id;


  DeleteScholarshipProviderEvent(this.id);

  @override
  List<Object?> get props => [id,];
}

// 📌 Get all scholarship providers


// 📌 Get a specific scholarship provider by ID
class GetScholarshipProviderByIdEvent extends ScholarshipProviderEvent {
  final String id;

  GetScholarshipProviderByIdEvent(this.id);

  @override
  List<Object?> get props => [id];
}
class FetchScholarshipProvidersEvent extends ScholarshipProviderEvent {
  final List<String> cities;
  final List<String> countries;
  final List<String> courses;
  final String searchQuery;
  final List<String> scholarshipTypes;

  FetchScholarshipProvidersEvent({
    required this.cities,
    required this.countries,
    required this.courses,
    required this.searchQuery,
    required this.scholarshipTypes,
  });
}
