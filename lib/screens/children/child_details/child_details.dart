import 'package:alandalos/core/extensions/num_extensions.dart';
import 'package:alandalos/core/resources/locale_keys.g.dart';
import 'package:alandalos/screens/children/child_details/tab/absences_tab/absences_tab.dart';
import 'package:alandalos/screens/children/child_details/tab/exams_tab/exams_tab.dart';
import 'package:alandalos/screens/children/child_details/tab/reviews_tab/reviews_tab.dart';
import 'package:alandalos/screens/children/child_details/tab/student_data_Screen/student_data_screen.dart';
import 'package:alandalos/screens/componets/my_appbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../utils/common_utils.dart';
import '../../../../utils/res.dart';
import '../../../core/resources/app_assets.dart';
import '../../../core/resources/values_manager.dart';
import '../../../core/routing/route.dart';
import '../../../core/svg_icon.dart';
import '../../../data/model/response/childrenModel.dart';
import '../../../data/repository/SaveUserData.dart';
import '../../../injection.dart';
import '../../notification/notification_provider.dart';
import '../../notification/notification_screen.dart';
import 'child_details_provider.dart';

class ChildDetails extends StatefulWidget {
  final int? tabIndex;
  final String? studentId;
  final ChildrenData? student;

  const ChildDetails(
      {Key? key, this.tabIndex, this.student, required this.studentId})
      : super(key: key);

  @override
  State<ChildDetails> createState() => _ChildDetailsState();
}

class _ChildDetailsState extends State<ChildDetails> {
  SaveUserData data = getIt();
  @override
  void initState() {
    super.initState();
    Provider.of<ChildDetailsProvider>(context, listen: false)
        .getReviewList(context, widget.studentId ?? '');
    Provider.of<NotificationProvider>(context, listen: false)
        .getCountNotification(
            context, data.getUserData()?.data?.id.toString() ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChildDetailsProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          appBar: MyAppBar(haveLeading: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient:  LinearGradient(colors: <Color>[
                  AppColors.colorPrimaryGradient,
                  AppColors.colorPrimary
                ]),
              ),),
            titleColor: AppColors.bgColor,
            title:  widget.student?.name ?? "",
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
                                widget.student?.id.toString() ??
                                    '',
                              ));
                            },
                            child: SvgPicture.asset(
                              'assets/icons/ic_notification.svg',
                              width: 30.w,
                              height: 30.h,
                              color: AppColors.bgColor,
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
                }),),
          backgroundColor: AppColors.bgColor,
          body: Column(
            children: [
              Container(width: double.infinity,height: 200.h,
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(22.r),bottomRight: Radius.circular(22.r)),
                  gradient: const LinearGradient(colors: <Color>[
                    AppColors.colorPrimaryGradient,
                    AppColors.colorPrimary
                  ]),
                ),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Colors.white, width: 1.w),
                        borderRadius:
                            BorderRadius.all(Radius.circular(11.r))),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.all(Radius.circular(10.r)),
                      child: CachedNetworkImage(
                        width: 100.w,
                        height: 100.h,
                        fit: BoxFit.cover,
                        imageUrl: CommonUtils.loadImageUrl(
                            widget.student?.image),
                        placeholder: (context, url) => Center(
                          child: Image.asset(
                              "assets/images/placeholder_image.png"),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h,),
              Expanded(
                    child: GridView(padding: EdgeInsets.all(16.r),shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      //childAspectRatio: 1.5,
                      crossAxisSpacing: 8.h,
                      mainAxisSpacing: 8.h,
                    ),
                  children: <Widget>[
                         InkWell(onTap:(){push( ReviewsTab(studentId: widget.studentId));},
                           child: Card(
                        // margin: EdgeInsets.only(
                        //     bottom: kScreenPaddingNormal.h,
                        //     top: kScreenPaddingNormal.h),

                        elevation: 3,

                        color: AppColors.bgColor,
                        shadowColor: AppColors.colorPrimaryLight,
                        shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r)),

                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/review.png',
                                width: 100.w,
                                height: 100.h,
                              ),
                              SizedBox(height: 12.h),
                             Text(
                                     LocaleKeys.reviews.tr(),
                                     style: TextStyle(
                                         fontFamily:
                                             DefaultTextStyle.of(context).style.fontFamily,
                                         fontWeight: FontWeight.bold),
                                   ),
                            ],
                        ),
                      ),
                         ),
                    InkWell(onTap: (){push(ExamsTab(studentId: widget.studentId,));},
                      child: Card(
                          // margin: EdgeInsets.only(
                          //     bottom: kScreenPaddingNormal.h,
                          //     top: kScreenPaddingNormal.h),

                          elevation: 3,

                          color: AppColors.bgColor,
                          shadowColor: AppColors.colorPrimaryLight,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r)),

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/exam.png',
                                width: 100.w,
                                height: 100.h,
                              ),
                              SizedBox(height: 12.h),
                        Text(
                                LocaleKeys.exams.tr(),
                                style: TextStyle(
                                    fontFamily:
                                        DefaultTextStyle.of(context).style.fontFamily,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                    ),
                    InkWell(onTap: (){
                      push(AbsencesTab(studentId:widget.studentId),);
                    },
                      child: Card(
                          // margin: EdgeInsets.only(
                          //     bottom: kScreenPaddingNormal.h,
                          //     top: kScreenPaddingNormal.h),

                          elevation: 3,
                          color: AppColors.bgColor,
                          shadowColor: AppColors.colorPrimaryLight,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r)),

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/students.png',
                                width: 100.w,
                                height: 100.h,
                              ),
                              SizedBox(height: 12.h),
                        Text(
                                LocaleKeys.absences.tr(),
                                style: TextStyle(
                                    fontFamily:
                                        DefaultTextStyle.of(context).style.fontFamily,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                    ),
                    InkWell(onTap: (){
                      push( StudentDataScreen(studentId: widget.studentId.toString(),));
                    },
                      child: Card(
                          // margin: EdgeInsets.only(
                          //     bottom: kScreenPaddingNormal.h,
                          //     top: kScreenPaddingNormal.h),
                          elevation: 3,
                          color: AppColors.bgColor,
                          shadowColor: AppColors.colorPrimaryLight,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r)),

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/immigration.png',
                                width: 100.w,
                                height: 100.h,
                              ),
                              SizedBox(height: 12.h),
                        Text(
                                LocaleKeys.studentGrades.tr(),
                                style: TextStyle(
                                    fontFamily:
                                        DefaultTextStyle.of(context).style.fontFamily,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                    )]),
                  ),
                ],
          )
        );
      },
    );
  }
}
