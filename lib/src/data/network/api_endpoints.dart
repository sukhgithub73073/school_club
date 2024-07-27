part of 'http_service.dart';

class ApisEndpoints {
  // https://schoolclub.co.in/laravel_app/public/uploads/student/1721982393_scaled_1000003585.jpg_stu.jpg

  static String pincodeUrl = "https://api.postalpincode.in/pincode/";
  static String versionCode = "/v1";
  static String domain = "http://schoolclub.in";
  static String baseUrl = "$domain/api$versionCode";
  static String imagesPathStudent =
      "$domain/laravel_app/public/uploads/student/";

  static String loginUrl = "$baseUrl/login";
  static String getCasteUrl = "$baseUrl/get-caste-sub-caste";
  static String getGroupUrl = "$baseUrl/get-class-group-data";
  static String getClassUrl = "$baseUrl/get-class-data";
  static String getDisabilityUrl = "$baseUrl/get-disability-type";
  static String getSerialNoUrl = "$baseUrl/get-sr-no/";
  static String createStudentUrl = "$baseUrl/create-student";
  static String createStaffUrl = "$baseUrl/create-staff";
  static String getStudentUrl = "$baseUrl/get-student-data";
  static String getStaffUrl = "$baseUrl/get-staff-data";
}
