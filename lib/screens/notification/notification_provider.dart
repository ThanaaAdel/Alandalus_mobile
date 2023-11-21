
import 'package:alandalos/data/model/response/base/api_response.dart';
import 'package:alandalos/data/model/response/count_notification.dart';
import 'package:alandalos/injection.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../core/api_checker.dart';
import '../../data/model/response/notificationModel.dart';
import '../../data/repository/notificationRepo.dart';
import '../children/children_provider.dart';
StudentsProvider hhh=getIt();
class NotificationProvider extends ChangeNotifier {
  final NotificationRepo notificationRepo;
  NotificationProvider({required this.notificationRepo});


  NotificationModel? _notificationModel;
  CountNotification? _countNotification;
  bool _isLoading = false;

  NotificationModel? get notificationModel => _notificationModel;
  CountNotification? get countNotification => _countNotification;
  bool get isLoading => _isLoading;



  Future<ApiResponse> getNotificationList(BuildContext context,String parentId) async {
    _isLoading=true;
    ApiResponse apiResponse = (await notificationRepo.getNotificationRepo(parentId));
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      _notificationModel = NotificationModel.fromJson(apiResponse.response?.data);
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    _isLoading=false;
    notifyListeners();
    return apiResponse;
  }
  Future<ApiResponse> getCountNotification(BuildContext context,String studentId) async {
    _isLoading=true;
    ApiResponse apiResponse = (await notificationRepo.getCountNotificationRepo(studentId));
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      _countNotification = CountNotification.fromJson(apiResponse.response?.data);
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    _isLoading=false;
    notifyListeners();
    return apiResponse;
  }
  Future<ApiResponse> readNotificationAPI(BuildContext context,String parentId) async {
    _isLoading=true;
    ApiResponse apiResponse = (await notificationRepo.readNotificationRepo(parentId));
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      Provider.of<StudentsProvider>(context, listen: false).refreshData();
      hhh.refreshData();
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    _isLoading=false;
    notifyListeners();
    return apiResponse;
  }


  getRoutSlag(context, String? name) {
    switch (name) {
      case 'feedback':
        return Fluttertoast.showToast(msg: 'feedback');
      // case 'daily-leave':
      //   return NavUtil.navigateScreen(context, const DailyLeave());
      default:
        return debugPrint('default');
    }
  }
  void refreshData(){
    notifyListeners();
  }
}
