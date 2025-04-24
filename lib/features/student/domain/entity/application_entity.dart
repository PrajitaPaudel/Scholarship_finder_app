class ApplicationEntity {
  final String courseId;
  final String userId;
  final String status; // "Submitted", "In Review", "Accepted", "Rejected"
  final DateTime submittedDate;

  ApplicationEntity({
    required this.courseId,
    required this.userId,
    required this.status,
    required this.submittedDate,
  });
}
