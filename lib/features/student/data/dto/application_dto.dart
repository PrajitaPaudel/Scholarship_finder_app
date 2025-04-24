import '../../domain/entity/application_entity.dart';

class ApplicationDTO {
  final String courseId;
  final String userId;
  final String status;
  final DateTime submittedDate;

  ApplicationDTO({
    required this.courseId,
    required this.userId,
    required this.status,
    required this.submittedDate,
  });

  // Convert Entity to DTO
  factory ApplicationDTO.fromEntity(ApplicationEntity entity) {
    return ApplicationDTO(
      courseId: entity.courseId,
      userId: entity.userId,
      status: entity.status,
      submittedDate: entity.submittedDate,
    );
  }

  // Convert DTO to Entity
  ApplicationEntity toEntity() {
    return ApplicationEntity(
      courseId: courseId,
      userId: userId,
      status: status,
      submittedDate: submittedDate,
    );
  }


}
