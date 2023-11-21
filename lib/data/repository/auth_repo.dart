import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../firebase_notification/notification_services.dart';
import '../app_urls/app_url.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/body/LoginBody.dart';
import '../model/body/updateProfileBody.dart';
import '../model/response/base/api_response.dart';
import 'SaveUserData.dart';

class AuthRepo {
  final DioClient dioClient;
  final SaveUserData saveUserData;
  AuthRepo({required this.dioClient, required this.saveUserData});

  Future<ApiResponse> loginRepo(LoginBody loginBody) async {
    try {
      Response response = await dioClient.post(
        AppURL.kLoginURI,
        data: loginBody.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

Future<ApiResponse> logoutRepo(String parentId) async {
  try {
    NotificationServices notificationServices = NotificationServices();
    String token = await notificationServices.getDeviceToken();
    TargetPlatform deviceType = getDeviceType();
    Response response = await dioClient.post(
      '${AppURL.kLogoutURI}$parentId&type=${deviceType.name.toLowerCase()}&token=$token',
    );
    return ApiResponse.withSuccess(response);
  } catch (e) {
    return ApiResponse.withError(ApiErrorHandler.getMessage(e));
  }
}
  Future<ApiResponse> updateProfileRepo(UpdateProfileBody updateProfileBody) async {
    try {
      Response response = await dioClient.post(AppURL.updateProfileURI,data:FormData.fromMap({
        "name": updateProfileBody.name,
        "password": updateProfileBody.password,
        "email": updateProfileBody.email,
        "parent_id": updateProfileBody.parentId,
      }) );

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> updateFCMToken({required String fcmToken,parentId,}) async {
    try {
      TargetPlatform deviceType = getDeviceType();/// for software_type
      Response response = await dioClient.post('${AppURL.kUpdateFCMTokenURI}${saveUserData.getUserData()?.data?.id}&type=${deviceType.name.toLowerCase()}&token=$fcmToken',);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
TargetPlatform getDeviceType() {/// for software_type
  return defaultTargetPlatform;
}
}
