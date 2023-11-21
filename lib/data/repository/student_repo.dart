import 'package:dio/dio.dart';
import '../app_urls/app_url.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/response/base/api_response.dart';
import 'SaveUserData.dart';

class StudentRepo {
  final DioClient dioClient;
  final SaveUserData saveUserData;
  StudentRepo({required this.dioClient, required this.saveUserData});

  Future<ApiResponse> studentsRepo(String parentId) async {
    try {
      Response response = await dioClient.get( "${AppURL.kStudentsURI}$parentId");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> graduateRepo(String studentId,month) async {
    try {
      Response response = await dioClient.get( "${AppURL.kGraduateURI}$studentId&month=$month");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> reviewRepo(String studentId) async {
    try {
      Response response = await dioClient.get( "${AppURL.kReviewURI}$studentId");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> examsRepo(String studentId) async {
    try {
      Response response = await dioClient.get( "${AppURL.kExamsURI}$studentId");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> absenceRepo(String studentId) async {
    try {
      Response response = await dioClient.get( "${AppURL.kAbsenceURI}$studentId");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}
