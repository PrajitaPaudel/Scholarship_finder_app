



import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/scholarship_provider_entity.dart';
import '../repository/remote_instituted_repository.dart';

class GetInstitutionsByFilterUseCase {
  final InstitutedRepository repository;

  GetInstitutionsByFilterUseCase(this.repository);

  Future<Either<Failure, List<ScholarshipProviderEntity>>> call({
    required List<String> cities,
    required List<String> countries,
    required List<String> courses,
    required String searchQuery,
    required List<String> scholarshipTypes,
  }) async {
    try {
      // Fetching the scholarship providers by filter from the repository
      final result = await repository.getInstitutionsByFilter(
        cities: cities,
        countries: countries,
        courses: courses,
        searchQuery: searchQuery,
        scholarshipTypes: scholarshipTypes,
      );

      // If the result is not null or empty, wrap it in Either.right (success case)
      return Right(result); // Success case, return the result wrapped in Right

    } catch (error) {
      // If any error occurs, wrap it in Either.left (failure case)
      return Left(ApiFailure(message: error.toString())); // Failure case, wrap the error message in Failure
    }
  }
}
