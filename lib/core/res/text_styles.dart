// import 'package:flutter/material.dart';
// import '../resources/app_colors.dart';
// import '../resources/font_manager.dart';
// import 'color.dart';
//
//
// class TextStyles {
//
//
//   TextStyle getTitleStyle({double fontSize = 13}) {
//     return TextStyle(
//         fontSize: fontSize,
//         fontWeight: FontWeight.w700,
//         fontFamily: FontConstants.fontFamily,
//         color: AppColors.gray);
//   }
//   TextStyle getDisplayMediumStyle({double fontSize = 24}) {
//     return TextStyle(
//         fontSize: fontSize,
//         fontWeight: FontWeight.w600,
//         fontFamily: FontConstants.fontFamily,
//         color: AppColors.gray);
//   }
//
//   TextStyle getRegularStyle({double fontSize = 14}) {
//     return TextStyle(
//         fontSize: fontSize,
//         fontWeight: FontWeight.w400,
//         fontFamily: FontConstants.fontFamily,
//         color: AppColors.gray);
//   }
//   TextStyle getDescriptionStyle({double fontSize = 12}) {
//     return TextStyle( fontSize: fontSize,
//         color: AppColors.gray,
//         fontWeight: FontWeight.w300,
//
//         fontFamily: FontConstants.fontFamily );
//   }
//
//
// }
//
// extension TextCustom on TextStyle {
//   ///use
//   TextStyle textColor() => (this).copyWith(color:color ?? AppColors.gray);
//   TextStyle textCustomColor(Color? color) => (this).copyWith(color:color ?? AppColors.gray);
//   TextStyle hintColor() => (this).copyWith(color: AppColors.gray);
//   TextStyle normalColor() => (this).copyWith(color: AppColors.primaryColor);
//   TextStyle activeColor() => (this).copyWith(color: AppColors.second);
//   TextStyle customColor(Color color) => (this).copyWith(color: color);
//   TextStyle colorWhite() => (this).copyWith(color: Colors.white);
//   TextStyle liteColor() => (this).copyWith(color: cardColor);
//   TextStyle activeLiteColor() => (this).copyWith(color: AppColors.second);
//   TextStyle errorStyle() => (this).copyWith(color: AppColors.error_color);
//   TextStyle hintStyle() => (this).copyWith(color: AppColors.second);
//
//   TextStyle textFamily({String? fontFamily} ) => (this).copyWith(fontFamily: fontFamily);
//   // TextStyle darkTextStyle() => (this).copyWith(color: textPrimaryDark);
//   // TextStyle boldActiveStyle() => (this).copyWith(fontWeight: FontWeight.bold,color: primaryColor);
//   TextStyle boldStyle() => (this).copyWith(fontWeight: FontWeight.bold);
//   TextStyle boldBlackStyle() => (this).copyWith(fontWeight: FontWeight.bold,color: Colors.black);
//   TextStyle boldLiteStyle() => (this).copyWith(fontWeight: FontWeight.w500);
//   TextStyle blackStyle() => (this).copyWith(color: Colors.black);
//   TextStyle underLineStyle() => (this).copyWith(decoration: TextDecoration.underline);
//   TextStyle ellipsisStyle({int line = 1}) => (this).copyWith( overflow: TextOverflow.ellipsis,);
//   TextStyle heightStyle({double height = 1}) => (this).copyWith( height: height);
//
//
//   TextStyle semiBoldStyle({double height = 1}) => (this).copyWith( fontWeight: FontWeight.w600,);
// ///use
//   TextStyle titleStyle({double fontSize = FontSize.s20}) => (this).copyWith(fontSize: fontSize, color:  Colors.black, fontWeight: FontWeight.w700, fontFamily: FontConstants.fontFamily );
//   TextStyle bodyStyle({double fontSize = FontSize.s14}) => (this).copyWith(fontSize: fontSize, color:  AppColors.black, fontWeight: FontWeight.w400, fontFamily: FontConstants.fontFamily );
//   TextStyle regularStyle({double fontSize = 14}) => (this).copyWith(fontSize: fontSize, color:  AppColors.black, fontWeight: FontWeight.w400, fontFamily: FontConstants.fontFamily );
//   TextStyle descriptionStyle({double fontSize = 12}) => (this).copyWith(fontSize: fontSize, color:  Colors.black, fontWeight: FontWeight.w300, fontFamily: FontConstants.fontFamily );
//
// }
//
//
//
// ///round a double
// extension Ex on double {
//   double toPrecision(int n) => double.parse(toStringAsFixed(n));
// }