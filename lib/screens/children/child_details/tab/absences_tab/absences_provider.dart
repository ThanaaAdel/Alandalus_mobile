import 'package:alandalos/utils/shared_preferences.dart';
import 'package:flutter/material.dart';

class AbsencesProvider extends ChangeNotifier {
  String? profileImage;

  AbsencesProvider() {
    getProfileData();
  }

  void getProfileData() async {
    profileImage = await SPUtill.getValue(SPUtill.keyProfileImage);
    notifyListeners();
  }
}
