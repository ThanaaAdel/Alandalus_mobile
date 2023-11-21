import 'package:alandalos/core/app_loader.dart';
import 'package:alandalos/core/extensions/num_extensions.dart';
import 'package:alandalos/core/routing/route.dart';
import 'package:alandalos/custom_widgets/custom_buttom.dart';
import 'package:alandalos/data/repository/SaveUserData.dart';
import 'package:alandalos/injection.dart';
import 'package:alandalos/screens/children/child_details/child_details.dart';
import 'package:alandalos/screens/children/children_provider.dart';
import 'package:alandalos/screens/children/update_profile/update_profile.dart';
import 'package:alandalos/screens/children/widget/logout_dialog.dart';
import 'package:alandalos/screens/componets/child_card.dart';
import 'package:alandalos/screens/componets/my_appbar.dart';
import 'package:alandalos/utils/res.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../notification/notification_provider.dart';

class ChildrenScreen extends StatefulWidget {
  const ChildrenScreen({Key? key}) : super(key: key);

  @override
  State<ChildrenScreen> createState() => _ChildrenScreenState();
}

class _ChildrenScreenState extends State<ChildrenScreen> {
  SaveUserData data = getIt();

  @override
  void initState() {
    super.initState();
    Provider.of<StudentsProvider>(context, listen: false).getStudentsList(context,data.getUserData()?.data?.id.toString()??'');
    Provider.of<StudentsProvider>(context, listen: false).refreshData();
    // Provider.of<NotificationProvider>(context, listen: false).refreshData();
  }
  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<StudentsProvider>().isLoading;
    return Consumer<StudentsProvider>(
      builder: (context, provider, _) {
        return RefreshIndicator(
          onRefresh: () async {
            provider.getStudentsList(context,data.getUserData()?.data?.id.toString()??'');
            provider.refreshData();
            Provider.of<NotificationProvider>(context, listen: false).refreshData();
          },
          child: Scaffold(resizeToAvoidBottomInset: false,
            backgroundColor: AppColors.bgColor,
            appBar: MyAppBar(
              title: tr("Children"),
              haveLeading: true,
                onLeadingTap:() {createAlertDialogLogout();},
              leadingIcon:Container(width: 50.w,height: 20.h,
                margin: EdgeInsets.only(top: 10.h,bottom: 10.h,right: 15.w),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r),color: Colors.red),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/logoutIcon.svg',
                    width: 20.w,
                    height: 20.h,
                     color:AppColors.bgColor,
                  ),
                ),
              ),
              // child: Consumer<NotificationProvider>(
              // builder: (context, countNotification, _) {
              //
              //   return  Stack(
              //   children: [
              //     Center(
              //       child: Container(padding: EdgeInsets.symmetric(horizontal: 30.w),
              //         child: InkWell(onTap: (){
              //           push( NotificationScreen(parentId:data.getUserData()?.data?.id.toString()??'' ,));
              //         },
              //           child:
              //           SvgPicture.asset(
              //             'assets/icons/ic_notification.svg',
              //             width: 30.w,
              //             height: 30.h,
              //             color:AppColors.colorPrimary,
              //           ),
              //         ),
              //       ),
              //     ),
              //     (countNotification.countNotification?.data?.counter==0)?const SizedBox():Positioned(top: 10.w,right: 24.w,
              //         child: Container(
              //           padding: EdgeInsets.all(2),
              //           margin: EdgeInsets.all(5.r),
              //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(100.r), border: Border.all(
              //   width: .8.w,
              //   color: AppColors.light_grey),color: AppColors.colorDeepRed),
              //           child: Center(child:Text(
              //   countNotification.countNotification?.data?.counter.toString()??'',
              //   style:TextStyle(
              //               color:Colors.black,
              //               fontSize: 10.sp,
              //               ),
              //         ) ,),)),
              //   ],
              // );
              // })
            ),
            body: Column(
              children: [
                Padding(
                  padding:  EdgeInsets.all(18.r),
                  child: CustomButton(
                    title: 'Edit account'.tr(),
                    clickButton: (){
                      push(UpdateProfile(parentId: data.getUserData()?.data?.id.toString()??''));
                    },
                  ),
                ),
            (provider.childrenModel?.data?.length!=0)?
                isLoading ? SizedBox(height: 500.h,child: const  Center(child: AppLoader())):Expanded(
                            child:ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  provider.childrenModel?.data?.length,
                              itemBuilder: (BuildContext context, int index) {
                                final data =
                                    provider.childrenModel?.data?[index];
                                return Padding(
                                    padding:  EdgeInsets.symmetric(
                                        horizontal: 16.0.h),
                                    child: InkWell(
                                      onTap: () => push(
                                          ChildDetails(student: data, studentId: data?.id.toString(),)
                                      ),
                                      child: ChildCard(student: data),
                                    ));
                              },
                            ),
                          )
                         :
                           Expanded(
                            child: Center(
                                child: Text(
                              tr("no_appointment_found"),
                              style: const TextStyle(
                                  color: Color(0x65555555),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500),
                            )),
                          )
                    ,
            const SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }
  void createAlertDialogLogout() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const LogoutDialog();
        });
  }
}
