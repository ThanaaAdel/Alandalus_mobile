import 'package:alandalos/core/extensions/num_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/resources/app_colors.dart';
import '../../../../core/resources/locale_keys.g.dart';
import '../../../data/repository/SaveUserData.dart';
import '../../../injection.dart';
import '../../auth/login/auth_provider.dart';
class LogoutDialog extends StatefulWidget {
  const LogoutDialog({
    super.key,
  });

  @override
  State<LogoutDialog> createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<LogoutDialog> {
  SaveUserData data = getIt();
  @override
  Widget build(BuildContext context) {
    final loading = !context.watch<AuthProvider>().isLogoutLoading;
    return AlertDialog(
      content: Text(
       LocaleKeys.youLogout.tr(),
        style: const  TextStyle(
            fontWeight: FontWeight.bold,color: AppColors.colorDeepRed),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
          child:
          loading ?
          GestureDetector(
                  onTap: () {
                    Provider.of<AuthProvider>(context, listen: false).logout(context, data.getUserData()?.data?.id.toString()??'');
                  },
                  child: Text(
                    LocaleKeys.confirm.tr(),
                    style: const TextStyle(
    fontWeight: FontWeight.bold,color: AppColors.colorDeepRed),),
                  )
              :SizedBox(
                  height: 24.h,
                  width: 24.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 3,color: AppColors.colorDeepRed,
                  )),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Text(
                LocaleKeys.cancel.tr(),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,color: AppColors.colorPrimary),
              )),
        ),
      ],
    );
  }
}
