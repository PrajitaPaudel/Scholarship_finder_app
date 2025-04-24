class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
   static const String baseUrl = "http://10.0.2.2:5000/api/v1/";
 // static const String baseUrl = "https://granthive.onrender.com/api/v1/";

  // For iPhone
  //static const String baseUrl = "http://localhost:3000/api/v1/";

  // ====================== Auth Routes ======================
  static const String login = "auth/login";
  static const String register = "auth/register";

  static String uploadImage = "uploads/profile";


  static String getInstitute = "instituteprofile";
  static String getInstituteById = "instituteprofile/id/";
  static String getInstituteByFilter = " instituteprofile/filter";



  static String getAllCourse = "course";
  static String getCourseById = "course/id/";
  static String createCourse = "course/";   ///Institution", "Admin"
  static String getCourseByScholarshipProvide = "course/institute";

  static String updateCourse="course/";
  static String  deleteCourse="course/";  ///Institution", "Admin"



  static String  studentProfile='studentprofile/';
  static String  uploadProfile='upload/student/profilepicture';
  static String  uploadDocument='upload/student/document';


  static String  getStudentProfileByID='studentprofile/id/';
  static String  updateStudentProfile='studentprofile/id';
  static String  deleteStudentProfile='studentprofile/';



}
