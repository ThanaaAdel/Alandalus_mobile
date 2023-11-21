import 'package:alandalos/screens/auth/login/login_screen.dart';
import 'package:alandalos/screens/children/children_screen.dart';
import 'package:alandalos/utils/shared_preferences.dart';
import 'package:flutter/foundation.dart';

import '../../../utils/nav_utail.dart';

class SplashProvider extends ChangeNotifier {
  initFunction(context) async {
    var token = await SPUtill.getValue(SPUtill.keyAuthToken);
    var userId = await SPUtill.getIntValue(SPUtill.keyUserId);
    if (kDebugMode) {
      /// development purpose only
      print("Bearer token: $token");
      print("User Id: $userId");
    }
    if (userId == null) {
      NavUtil.replaceScreen(context, const LoginScreen());
    } else {
      NavUtil.replaceScreen(context, const ChildrenScreen());
    }

    notifyListeners();
  }

}
