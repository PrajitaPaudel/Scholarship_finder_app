
 import 'package:dartz/dartz.dart';
import 'package:scholarshuip_finder_app/core/error/failure.dart';
import 'package:scholarshuip_finder_app/features/home/data/model/scholarship_provider_model.dart';

abstract class IInstituteDataSource{
  Future<Either<Failure,ScholarshipProviderModel>> addInstitute(ScholarshipProviderModel  scholarshipProviderModel);
  Future<Either<Failure,List<ScholarshipProviderModel>>>getInstitute();
  Future<Either<Failure,List<ScholarshipProviderModel>>>getInstituteById(String userId);
  Future<Either<Failure, void>> updateInstitute(ScholarshipProviderModel institute,String id);
  Future<Either<Failure, void>> deleteInstitute(String id) ;
  Future<List<ScholarshipProviderModel>> getInstitutionsByFilter({
    required List<String> cities,
    required List<String> countries,
    required List<String> courses,
    required String searchQuery,
    required List<String> scholarshipTypes,
  });

 }
