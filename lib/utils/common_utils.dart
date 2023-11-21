import 'package:intl/intl.dart';

import 'app_const.dart';

class CommonUtils {
  static String loadImageUrl(String? imagePath) {
    if (imagePath != null) {
      if (imagePath.contains(AppConst.baseUrlLive)) {
        return imagePath;
      } else {
        return '${AppConst.baseUrlLive}$imagePath';
      }
    } else {
      return 'https://alandalosschool.com/assets/default/imgs/default-img.png';
    }
  }

  static String printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes";
  }

  static bool isRTL(String text) {
    return Bidi.detectRtlDirectionality(text);
  }
}
