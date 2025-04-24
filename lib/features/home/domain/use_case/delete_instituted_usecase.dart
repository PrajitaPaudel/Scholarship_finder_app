

import 'package:dartz/dartz.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../repository/remote_instituted_repository.dart';


class DeleteScholarshipProviderUseCase implements UsecaseWithParams<void, String> {
  final InstitutedRepository repository;

  DeleteScholarshipProviderUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(String id) async {
    try {
      // Call repository method
      final result = await repository.deleteInstitute(id);

      return result.fold(
            (failure) => Left(failure),
            (_) => const Right(null),
      );
    } catch (error) {
      return Left(ApiFailure(message: error.toString()));
    }
  }
}
