


import 'package:dartz/dartz.dart';
import 'package:scholarshuip_finder_app/features/home/data/model/scholarship_provider_model.dart';
import 'package:scholarshuip_finder_app/features/home/domain/entity/scholarship_provider_entity.dart';

import '../../../../core/error/failure.dart';

abstract class IInstitutedRepository {
  Future<Either<Failure, ScholarshipProviderEntity>> addInstitute(ScholarshipProviderEntity scholarshipProviderEntity);
  Future<Either<Failure, void>> deleteInstitute(String id) ;
  Future<Either<Failure, List<ScholarshipProviderEntity>>> getInstituted();
  Future<Either<Failure, List<ScholarshipProviderEntity>>> getInstitutedById(String userId);
  Future<Either<Failure, void>> updateInstitute(ScholarshipProviderEntity scholarshipProviderEntity,String id) ;


  Future<List<ScholarshipProviderEntity>> getInstitutionsByFilter({
  required List<String> cities,
  required List<String> countries,
  required List<String> courses,
  required String searchQuery,
  required List<String> scholarshipTypes,
  });


}

