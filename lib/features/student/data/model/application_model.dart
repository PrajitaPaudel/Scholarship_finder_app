

import '../dto/application_dto.dart';

class ApplicationModel extends ApplicationDTO {
  ApplicationModel({
    required super.courseId,
    required super.userId,
    required super.status,
    required super.submittedDate,
  });

  // Convert JSON to Model
  factory ApplicationModel.fromJson(Map<String, dynamic> json) {
    return ApplicationModel(
      courseId: json['course_id'],
      userId: json['userId'],
      status: json['Status'],
      submittedDate: DateTime.parse(json['SubmittedDate']),
    );
  }

  // Convert Model to JSON

  Map<String, dynamic> toJson() {
    return {
      'course_id': courseId,
      'userId': userId,
      'Status': status,
      'SubmittedDate': submittedDate.toIso8601String(),
    };
  }
}
