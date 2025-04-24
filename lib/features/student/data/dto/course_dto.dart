import '../../domain/entity/course_entity.dart';

class CourseDTO {
  final String id;
  final String userId;
  final String title;
  final String description;
  final String scholarshipType;
  final double? scholarshipAmount;
  final String? eligibilityCriteria;
  final String? deadline;

  CourseDTO(  {
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.scholarshipType,
    this.scholarshipAmount,
    this.eligibilityCriteria,
    this.deadline,
  });

  // Convert Entity to DTO
  factory CourseDTO.fromEntity(CourseEntity entity) {
    return CourseDTO(
      id: entity.id,
      userId: entity.userId,
      title: entity.title,
      description: entity.description,
      scholarshipType: entity.scholarshipType,
      scholarshipAmount: entity.scholarshipAmount,
      eligibilityCriteria: entity.eligibilityCriteria,
      deadline: entity.deadline,
    );
  }

  // Convert DTO to Entity
  CourseEntity toEntity() {
    return CourseEntity(
      id: id,
       userId:userId,
      title: title,
      description: description,
      scholarshipType: scholarshipType,
      scholarshipAmount: scholarshipAmount,
      eligibilityCriteria: eligibilityCriteria,
      deadline: deadline,
    );
  }


}
