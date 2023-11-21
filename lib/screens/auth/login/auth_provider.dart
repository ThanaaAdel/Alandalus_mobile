import 'dart:async';
import 'package:alandalos/screens/auth/login/login_screen.dart';
import 'package:alandalos/screens/children/children_screen.dart';
import 'package:alandalos/screens/splash_screen/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../core/api_checker.dart';
import '../../../../data/model/body/LoginBody.dart';
import '../../../../data/model/response/base/api_response.dart';
import '../../../../data/repository/SaveUserData.dart';
import '../../../../data/repository/auth_repo.dart';
import '../../../core/resources/locale_keys.g.dart';
import '../../../core/routing/route.dart';
import '../../../core/utils/showToast.dart';
import '../../../data/model/body/updateProfileBody.dart';
import '../../../data/model/response/logoutModel.dart';
import '../../../data/model/response/user_model.dart';
import '../../../firebase_notification/notification_services.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepo authRepo;
  final SaveUserData saveUserData;

  AuthProvider({required this.saveUserData, required this.authRepo});

  ///variables
  bool _isLoading = false;
  bool _isLogoutLoading = false;
  bool passwordVisible = true;
  String? _validationMSG;
  UserModel? _userModel;
  LogoutModel? _logoutModel;
  LoginProvider() {
    passwordVisible = false;
  }
  passwordVisibility() {
    passwordVisible = !passwordVisible;
    notifyListeners();
  }
  ///getters
  bool get isLoading => _isLoading;
  bool get isLogoutLoading => _isLogoutLoading;
  String? get validationMSG => _validationMSG;
  LogoutModel? get logoutModel => _logoutModel;


  ///setters

  UserModel? get userModel => _userModel;

  set validationMsg(String msg) {
    _validationMSG = msg;
    notifyListeners();
  }


  ///calling APIs Functions
  Future<ApiResponse> login({required String email,required String password, required BuildContext context}) async {
    _isLoading = true;
    notifyListeners();
    final LoginBody _body = LoginBody(email: email, password: password);
    ApiResponse responseModel = await authRepo.loginRepo(_body);
    if (responseModel.response != null &&
        responseModel.response?.statusCode == 200) {
      _isLoading = false;
      _userModel = UserModel.fromJson(responseModel.response?.data);

      if (_userModel != null && _userModel?.status == 200) {
        if (_userModel?.data?.id != null) {
          saveUserData.saveUserData(_userModel!);
          // saveUserData.saveUserToken(_userModel?.data?.token ?? '');
          print('kkkkkkkkkkk${saveUserData.getUserData()?.data?.id}');
          print('kkkkkkkkkkk${_userModel?.message}');

          updateFCMToken();
        }
        ToastUtils.showToast(LocaleKeys.loggedInSuccessfully.tr());
        pushAndRemoveUntil(const ChildrenScreen());
      } else if (_userModel?.status == 400) {
        ToastUtils.showToast(_userModel?.message.toString()??'');
      }else if (_userModel?.status == 403) {
        ToastUtils.showToast(_userModel?.message.toString()??'');
        // push(Register(phoneCode: _phoneCode, phone: phone));
      }
      else if (_userModel?.status == 401) {
        ToastUtils.showToast(LocaleKeys.createAccountLogin.tr());
        // push(Register(phoneCode: _phoneCode, phone: phone));
      }
    } else {
      _isLoading = false;
      ApiChecker.checkApi(context, responseModel);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }

  Future<ApiResponse> logout(BuildContext context,String parentId) async {
    _isLogoutLoading = true;
    notifyListeners();
    ApiResponse responseModel = await authRepo.logoutRepo(parentId);
    if (responseModel.response != null &&
        responseModel.response?.statusCode == 200) {
      _isLogoutLoading = false;
      _logoutModel = LogoutModel.fromJson(responseModel.response?.data);
      if (_logoutModel?.status == 200) {
        await saveUserData.clearSharedData().then((value) => pushAndRemoveUntil(const LoginScreen()));
      } else {
        ToastUtils.showToast(_logoutModel?.message.toString()??'');
      }
    } else {
      _isLogoutLoading = false;
      ApiChecker.checkApi(context, responseModel);
    }
    _isLogoutLoading = false;
    notifyListeners();
    return responseModel;
  }

  Future<ApiResponse> updateProfileApi (BuildContext context,UpdateProfileBody updateProfileBody) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse responseModel = await authRepo.updateProfileRepo(updateProfileBody);
    if (responseModel.response != null && responseModel.response?.statusCode == 200) {
      _isLoading = false;
      _userModel = UserModel.fromJson(responseModel.response?.data);
      if(_userModel!=null && _userModel?.status==200) {
        saveUserData.saveUserData(_userModel!);
        updateFCMToken();
        Navigator.pop(context);
      }    else{ToastUtils.showToast('${_userModel?.message}');}
      notifyListeners();
    } else {
      _isLoading = false;
      ApiChecker.checkApi(context, responseModel);
    }
    notifyListeners();
    return responseModel;
  }


  Future<void> updateFCMToken() async {
    print("kkkkkkffffk");
    NotificationServices notificationServices = NotificationServices();

    String? fcmToken = await  notificationServices.getDeviceToken();
    if (fcmToken == null) {return;}
    await authRepo.updateFCMToken(fcmToken: fcmToken);
    notifyListeners();
  }
}
