import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../app_urls/app_url.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/body/LoginBody.dart';
import '../model/response/base/api_response.dart';
import 'SaveUserData.dart';

class NotificationRepo {
  final DioClient dioClient;
  final SaveUserData saveUserData;
  NotificationRepo({required this.dioClient, required this.saveUserData});

  Future<ApiResponse> getNotificationRepo(String parentId) async {
    try {
      Response response = await dioClient.get(
          "${AppURL.kNotificationURI}$parentId");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> getCountNotificationRepo(String parentId) async {
    try {
      Response response = await dioClient.get("${AppURL.kCountNotificationURI}$parentId");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> readNotificationRepo(String parentId) async {
    try {
      Response response = await dioClient.post(AppURL.kReadNotificationURI,data: FormData.fromMap(
        {"student_id":parentId}
      ));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
