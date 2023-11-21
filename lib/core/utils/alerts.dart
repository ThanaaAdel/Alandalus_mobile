import 'package:flutter/material.dart';

import '../resources/app_colors.dart';

enum AlertsType{error,success,info}

class Alerts {
  static Color _getColor(AlertsType alertsType) {
    switch (alertsType) {
      case AlertsType.error:
        return AppColors.error_color;
      case AlertsType.success:
        return Colors.green;
      case AlertsType.info:
        return Colors.grey;
    }
  }

}
