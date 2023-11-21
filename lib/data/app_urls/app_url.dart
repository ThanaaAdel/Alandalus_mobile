class AppURL {
  static const String kBaseURL = "https://alandalosschool.com/api";
  ///Auth
 static const String kLoginURI = "/auth/login";
 static const String kLogoutURI = "/auth/logout?parent_id=";
 static const String kStudentsURI = "/student/children?parent_id=";
 static const String kGraduateURI = "/student/getGraduates?student_id=";
  static const String updateProfileURI = "/auth/update/profile";

 static const String kReviewURI = "/student/getReviews?student_id=";
 static const String kExamsURI = "/student/getExams?student_id=";
 static const String kAbsenceURI = "/student/getAbsences?student_id=";


 static const String kUpdateFCMTokenURI = "/auth/update_token?parent_id=";

 ///Items Details
 static const String kReviewDetailsURI = "/student/getReviewDetails/";
 static const String kExamDetailsURI = "/student/getExamsDetails/";
 static const String kAbsenceDetailsURI = "/student/getAbsencesDetails/";



///notification
  static const String kNotificationURI = "/student/getNotifications?student_id=";
  static const String kCountNotificationURI = "/student/count_notification?student_id=";
  static const String kReadNotificationURI = "/student/read_notification";





}
