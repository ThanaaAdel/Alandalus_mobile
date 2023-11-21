import 'dart:convert';
import 'package:alandalos/screens/splash_screen/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/routing/route.dart';
import '../../core/utils/app_constants.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../model/response/user_model.dart';

class SaveUserData {
  final SharedPreferences sharedPreferences;
  final DioClient dioClient;

  SaveUserData({required this.sharedPreferences, required this.dioClient});
  Future<void> saveUserData(UserModel userData) async {
    dioClient.updateHeader(userData.data?.id.toString() ??'' );
    String userSavedData = json.encode(userData);
    try {
      await sharedPreferences.setString(AppConstants.userData, userSavedData);
    } catch (e) {
      rethrow;
    }
  }
  Future<void> saveLang(String lang) async {
    try {
      await sharedPreferences.setString(AppConstants.lang, lang);
    } catch (e) {
      throw e;
    }
  }
  Future<void> saveUserToken(String userTOKEN) async {
    dioClient.updateHeader(userTOKEN);
    try {
      await sharedPreferences.setString(AppConstants.userTOKEN, userTOKEN);
    } catch (e) {
      throw e;
    }
  }
  Future<void> saveTitle(String title) async {
    try {
      await sharedPreferences.setString(AppConstants.title, title);
    } catch (e) {
      throw e;
    }
  }
  UserModel? getUserData()   {
    String?  userSavedData= sharedPreferences.getString(AppConstants.userData) ;
   if (userSavedData !=null) {
     Map<String, dynamic> userData = json.decode(userSavedData);
     UserModel userModel = UserModel.fromJson(userData);
     return userModel;
   }
  }
  String getUserToken() {
    return sharedPreferences.getString(AppConstants.userTOKEN) ?? "";
  }
  String getLang() {
    return sharedPreferences.getString(AppConstants.lang) ?? "ar";
  }
  String getBranchTitle() {
    return sharedPreferences.getString(AppConstants.title) ?? "";
  }
  bool isSaveBranchId() {
    return sharedPreferences.containsKey(AppConstants.branchId);
  }
  Future<bool> clearSharedData() async {
    await sharedPreferences.remove(AppConstants.userData);
    await sharedPreferences.remove(AppConstants.userTOKEN);
    await sharedPreferences.remove(AppConstants.title);
    pushAndRemoveUntil(const SplashScreen());

    return true;
  }
}
