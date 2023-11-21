import 'package:alandalos/utils/shared_preferences.dart';
import 'package:flutter/material.dart';

class ReviewsProvider extends ChangeNotifier {
  String? profileImage;

  ReviewsProvider() {
    getProfileData();
  }

  void getProfileData() async {
    profileImage = await SPUtill.getValue(SPUtill.keyProfileImage);
    notifyListeners();
  }
}
