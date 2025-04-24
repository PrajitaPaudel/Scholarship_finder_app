class CourseEntity {
  final String id;
  final String userId;
  final String title;
  final String description;
  final String scholarshipType; // Can be "Flat" or "Percentage"
  final double? scholarshipAmount;
  final String? eligibilityCriteria;
  final String? deadline;

  CourseEntity({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.scholarshipType,
    this.scholarshipAmount,
    this.eligibilityCriteria,
    this.deadline,
  });


}