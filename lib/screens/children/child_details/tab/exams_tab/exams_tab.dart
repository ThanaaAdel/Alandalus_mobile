import 'package:alandalos/core/app_loader.dart';
import 'package:alandalos/core/extensions/num_extensions.dart';
import 'package:alandalos/core/helper/no_data.dart';
import 'package:alandalos/custom_widgets/custom_build_profile_details.dart';
import 'package:alandalos/screens/children/child_details/tab/detailsItems/details_item.dart';
// import 'package:alandalos/data/model/response_personal.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../../../utils/res.dart';
import '../../../../../core/resources/locale_keys.g.dart';
import '../../../../../core/routing/route.dart';
import '../../../../../utils/nav_utail.dart';
import '../../../../componets/my_appbar.dart';
import '../../../../notification/notification_provider.dart';
import '../../../../notification/notification_screen.dart';
import '../../child_details_provider.dart';
import '../absences_tab/absences_provider.dart';

class ExamsTab extends StatefulWidget {
  final String? studentId;

  const ExamsTab({Key? key, this.studentId}) : super(key: key);

  @override
  State<ExamsTab> createState() => _ExamsTabState();
}

class _ExamsTabState extends State<ExamsTab> {
  @override
  void initState() {
    super.initState();
    Provider.of<ChildDetailsProvider>(context, listen: false).getExamsList(context, widget.studentId.toString());
    Provider.of<NotificationProvider>(context, listen: false).getCountNotification(context, widget.studentId??'');
  }
  @override
  Widget build(BuildContext context) {
    final loading =context.watch<ChildDetailsProvider>().isLoading;

    return ChangeNotifierProvider(
      create: (context) => AbsencesProvider(),
      child: Consumer<ChildDetailsProvider>(builder: (context, provider, _) {
        return Scaffold(
          appBar:  MyAppBar(haveLeading: true,
            title: LocaleKeys.exams.tr(),
            child: Consumer<NotificationProvider>(
                builder: (context, countNotification, _) {
                  return Stack(
                    children: [
                      Center(
                        child: Container(
                          padding:
                          EdgeInsets.symmetric(horizontal: 30.w),
                          child: InkWell(
                            onTap: () {
                              push(NotificationScreen(
                                parentId:
                                widget.studentId??'',
                              ));
                            },
                            child: SvgPicture.asset(
                              'assets/icons/ic_notification.svg',
                              width: 30.w,
                              height: 30.h,
                              color: AppColors.colorPrimary,
                            ),
                          ),
                        ),
                      ),
                      (countNotification
                          .countNotification?.data?.counter ==
                          0)
                          ? const SizedBox()
                          : Positioned(
                          top: 5.w,
                          right: 24.w,
                          child: Container(
                            padding:  EdgeInsets.all(2.r),
                            margin: EdgeInsets.all(5.r),
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(100.r),
                                border: Border.all(
                                    width: .8.w,
                                    color: AppColors.light_grey),
                                color: AppColors.colorDeepRed),
                            child: Center(
                              child: Text(
                                countNotification
                                    .countNotification
                                    ?.data
                                    ?.counter
                                    .toString() ??
                                    '',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ),
                          )),
                    ],
                  );
                }),
          ),
          backgroundColor: AppColors.bgColor,
          body: loading? const Center(child: AppLoader(),): (provider.examsModel?.data?.length==0)?Center(child: NoDataScreen(title: LocaleKeys.noTests.tr(),)):
            ListView.builder(
                padding: EdgeInsets.all(8.r),
                shrinkWrap: true,
                itemCount:provider.examsModel?.data?.length, //from API
                itemBuilder: (context, index) {
                  return
                    InkWell(onTap: (){
                      NavUtil.navigateScreen(
                          context,DetailsItems(witchScreen: 'exam', itemId: provider.examsModel?.data?[index].id.toString(), studentId: widget.studentId));
                    },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 8.h),
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 16.h),
                        decoration: BoxDecoration(
                          color:
                          // (provider.reviewsModel?.data?[index].type == 'negative')
                          //      Colors.red.shade50,
                          //     :
                          AppColors.colorPrimaryLight,

                          borderRadius:
                          BorderRadius.all(Radius.circular(12.r)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(width:MediaQuery.of(context).size.width*.69,
                                  child: Row(
                                    children: [
                                      Text(LocaleKeys.Subject.tr(),style: TextStyle(fontWeight: FontWeight.bold)),
                                      Expanded(
                                        child: Text(provider.examsModel?.data?[index].category?.title??'',
                                            style: TextStyle(fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis,fontSize: 12.sp)),
                                      ),
                                    ],
                                  ),
                                ),
                                // SizedBox(height: 5.h,),
                                // Row(
                                //   children: [
                                //     Text(
                                //       LocaleKeys.clause.tr(),
                                //       style: const TextStyle(
                                //           fontWeight: FontWeight.bold),
                                //     ),
                                //     Text(
                                //      ' : ( ${provider.examsModel?.data?[index].title} )',
                                //       style: const TextStyle(
                                //           fontWeight: FontWeight.bold,),
                                //     ),
                                //   ],
                                // ),
                                SizedBox(height: 10.h,),
                                Row(
                                  children: [
                                    Text(
                                      LocaleKeys.totalMarks.tr(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      " : ( ${provider.examsModel?.data?[index].degreeOfExam} )",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 5.h,),

                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 6.h, top: 6.h),
                                  child:  Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(LocaleKeys.studentGrade.tr(),style: const TextStyle(
                                              fontWeight: FontWeight.bold),),
                                          Text(' : ( ${provider.examsModel?.data?[index].degreeOfStudent} )',style: const TextStyle(
                  fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                      SizedBox(height: 5.h,),

                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                SizedBox(width:MediaQuery.of(context).size.width*.69,
                                  child: Row(
                                    children: [
                                      Text(
                                        LocaleKeys.teacherName.tr(),
                                        style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                        child: Text(
                                          provider.examsModel?.data?[index].teacher?.name??'',
                                          style:  TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                }),
        );
      }),
    );
  }
}
