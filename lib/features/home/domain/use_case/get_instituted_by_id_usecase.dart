

import 'package:dartz/dartz.dart';
import 'package:scholarshuip_finder_app/app/usecase/usecase.dart';

import '../../../../core/error/failure.dart';
import '../entity/scholarship_provider_entity.dart';
import '../repository/remote_instituted_repository.dart';

class GetScholarshipProviderByIdUseCase implements UsecaseWithParams<List<ScholarshipProviderEntity>, String> {
  final InstitutedRepository repository;

  GetScholarshipProviderByIdUseCase(this.repository);

  @override
  Future<Either<Failure, List<ScholarshipProviderEntity>>> call(String userId) async {
    try {
      final result = await repository.getInstitutedById(userId);

      return result.fold(
            (failure) => Left(failure),
            (scholarshipProviders) => Right(scholarshipProviders),
      );
    } catch (error) {
      return Left(ApiFailure(message: error.toString()));
    }
  }
}