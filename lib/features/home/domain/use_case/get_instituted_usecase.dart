

import 'package:dartz/dartz.dart';
import 'package:scholarshuip_finder_app/app/usecase/usecase.dart';
import 'package:scholarshuip_finder_app/features/home/domain/repository/remote_instituted_repository.dart';

import '../../../../core/error/failure.dart';
import '../entity/scholarship_provider_entity.dart';


class GetScholarshipProviderUseCase implements UsecaseWithoutParams{
  final InstitutedRepository repository;

  GetScholarshipProviderUseCase(this.repository);

  @override
  Future<Either<Failure, List<ScholarshipProviderEntity>>> call() async {
    try {
      final result = await repository.getInstituted();

      return result.fold(
            (failure) => Left(failure),
            (scholarshipProviders) => Right(scholarshipProviders),
      );
    } catch (error) {
      return Left(ApiFailure(message: error.toString()));
    }
  }
}
