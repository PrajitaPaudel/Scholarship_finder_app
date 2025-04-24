

import 'package:dartz/dartz.dart';

import 'package:scholarshuip_finder_app/core/error/failure.dart';
import 'package:scholarshuip_finder_app/features/home/data/data_source/data_source.dart';
import 'package:scholarshuip_finder_app/features/home/data/data_source/instituted_remote_data_source.dart';
import 'package:scholarshuip_finder_app/features/home/data/dto/scholarship_provider_dto.dart';

import 'package:scholarshuip_finder_app/features/home/domain/entity/scholarship_provider_entity.dart';

import '../../data/model/scholarship_provider_model.dart';
import 'instituted_repository.dart';

class InstitutedRepository implements IInstitutedRepository{
  final InstituteRemoteDataSource instituteDataSource;

  InstitutedRepository({required this.instituteDataSource});
  @override
  Future<Either<Failure, ScholarshipProviderEntity>> addInstitute(ScholarshipProviderEntity scholarshipProviderEntity) async {
   final schlorshipProviderDTO=ScholarshipProviderDTO.fromEntity(scholarshipProviderEntity);

   final schlorshipProviderModel=ScholarshipProviderModel
     (
     id:schlorshipProviderDTO.id ,
       userId: schlorshipProviderDTO.userId,
       name: schlorshipProviderDTO.name,
       profilePhoto: schlorshipProviderDTO.profilePhoto,
       contact: schlorshipProviderDTO.contact,
       location: schlorshipProviderDTO.location,
       university: schlorshipProviderDTO.university,
       description: schlorshipProviderDTO.description,
       course: schlorshipProviderDTO.course, );

   final result = await instituteDataSource.addInstitute(schlorshipProviderModel);
   return result.fold(
         (failure) => Left(failure),
         (schlorshipProviderModel) {
       // Convert Model to DTO
       final responseDTO = ScholarshipProviderDTO(
         id: schlorshipProviderModel.id,
           userId: schlorshipProviderModel.userId,
           name: schlorshipProviderDTO.name,
           profilePhoto: schlorshipProviderDTO.profilePhoto,
           contact: schlorshipProviderDTO.contact,
           location: schlorshipProviderDTO.location,
           university: schlorshipProviderDTO.university,
           description: schlorshipProviderDTO.description, course: schlorshipProviderDTO.course,
       );



       // Convert DTO back to Entity
       return Right(responseDTO.toEntity());
     },
   );
  }

  @override
  Future<Either<Failure, void>> deleteInstitute(String id) {
    // TODO: implement deleteBooking
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<ScholarshipProviderEntity>>> getInstituted() async {
    try {
      final result = await instituteDataSource.getInstitute();

      return result.fold(
            (failure) => Left(failure),
            (scholorships) {
          final scholorshipProviderEntities = scholorships.map((scholorship) => scholorship.toEntity())
              .toList();
          return Right(scholorshipProviderEntities);
        },
      );
    } catch (e) {
      return Left(ApiFailure(message: 'Error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> updateInstitute(ScholarshipProviderEntity scholarshipProviderEntity,String id) async{
    try{
    final schlorshipProviderDTO=ScholarshipProviderDTO.fromEntity(scholarshipProviderEntity);

    final schlorshipProviderModel=ScholarshipProviderModel
      (
        id:schlorshipProviderDTO.id ,
        userId: schlorshipProviderDTO.userId,
        name: schlorshipProviderDTO.name,
        profilePhoto: schlorshipProviderDTO.profilePhoto,
        contact: schlorshipProviderDTO.contact,
        location: schlorshipProviderDTO.location,
        university: schlorshipProviderDTO.university,
        description: schlorshipProviderDTO.description, course: schlorshipProviderDTO.course, );

    final result = await instituteDataSource.updateInstitute(schlorshipProviderModel,id);
    return result.fold(
          (failure) => Left(failure),
          (_) => const Right(null),
    );
  } catch (e) {
  return Left(ApiFailure(message: 'Error occurred: ${e.toString()}'));
  }
}

  @override
  Future<Either<Failure, List<ScholarshipProviderEntity>>> getInstitutedById(String userId)async{
    try {
      final result = await instituteDataSource.getInstituteById(userId);

      return result.fold(
            (failure) => Left(failure),
            (scholorships) {
          final scholorshipProviderEntities = scholorships.map((scholorship) => scholorship.toEntity())
              .toList();
          return Right(scholorshipProviderEntities);
        },
      );
    } catch (e) {
      return Left(ApiFailure(message: 'Error occurred: ${e.toString()}'));
    }
  }

  @override
  @override
  Future<List<ScholarshipProviderEntity>> getInstitutionsByFilter({
    required List<String> cities,
    required List<String> countries,
    required List<String> courses,
    required String searchQuery,
    required List<String> scholarshipTypes,
  }) async {
    try {
      final List<ScholarshipProviderModel> models = await instituteDataSource.getInstitutionsByFilter(
        cities: cities,
        countries: countries,
        courses: courses,
        searchQuery: searchQuery,
        scholarshipTypes: scholarshipTypes,
      );

      // Map Model to Entity
      return models.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to fetch institutions');
    }
  }

}