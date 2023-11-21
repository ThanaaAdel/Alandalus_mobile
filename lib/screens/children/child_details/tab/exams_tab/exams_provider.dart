import 'package:alandalos/utils/shared_preferences.dart';
import 'package:flutter/material.dart';

class ExamsProvider extends ChangeNotifier {
  String? profileImage;

  ExamsProvider() {
    getProfileData();
  }

  void getProfileData() async {
    profileImage = await SPUtill.getValue(SPUtill.keyProfileImage);
    notifyListeners();
  }
}
