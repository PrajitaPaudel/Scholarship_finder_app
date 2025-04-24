import '../dto/course_dto.dart';

class CourseModel extends CourseDTO {
  CourseModel({
    required String id,
    required String userId,
    required String title,
    required String description,
    required String scholarshipType,
    double? scholarshipAmount,
    String? eligibilityCriteria,
    String? deadline,
  }) : super(
    id: id,
    userId: userId,
    title: title,
    description: description,
    scholarshipType: scholarshipType,
    scholarshipAmount: scholarshipAmount,
    eligibilityCriteria: eligibilityCriteria,
    deadline: deadline,
  );

  // Convert JSON to Model
  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['_id']??'',
      userId: json['userId']??'',
      title: json['title']??'',
      description: json['description']??'',
      scholarshipType: json['scholarshipType']??"",
      scholarshipAmount: (json['scholarshipAmount'] as num?)?.toDouble()??0,
      eligibilityCriteria: json['eligibility_criteria']??"",
      deadline: json['deadline']??"",
    );
  }

  // Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'scholarshipType': scholarshipType,
      'scholarshipAmount': scholarshipAmount,
      'eligibility_criteria': eligibilityCriteria,
      'deadline': deadline,
    };
  }
}
