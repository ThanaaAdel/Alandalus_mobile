
import 'package:alandalos/data/model/response/base/api_response.dart';
import 'package:dio/dio.dart';

import '../app_urls/app_url.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import 'SaveUserData.dart';

class DetailsRepo {
  final DioClient dioClient;
  final SaveUserData saveUserData;

  DetailsRepo({required this.dioClient, required this.saveUserData});


  Future<ApiResponse> reviewDetailsRepo(String reviewId, studentId) async {
    try {
      Response response = await dioClient.get(
          "${AppURL.kReviewDetailsURI}$reviewId?student_id=$studentId");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> examDetailsRepo(String examId, studentId) async {
    try {
      Response response = await dioClient.get(
          "${AppURL.kExamDetailsURI}$examId?student_id=$studentId");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> absenceDetailsRepo(String absenceId, studentId) async {
    try {
      Response response = await dioClient.get(
          "${AppURL.kAbsenceDetailsURI}$absenceId?student_id=$studentId");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}