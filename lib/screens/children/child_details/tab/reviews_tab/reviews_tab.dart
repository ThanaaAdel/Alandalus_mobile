import 'package:alandalos/core/app_loader.dart';
import 'package:alandalos/core/extensions/num_extensions.dart';
import 'package:alandalos/core/helper/no_data.dart';
import 'package:alandalos/core/resources/locale_keys.g.dart';
import 'package:alandalos/core/routing/route.dart';
import 'package:alandalos/screens/children/child_details/tab/detailsItems/details_item.dart';
import 'package:alandalos/screens/componets/my_appbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../../../utils/res.dart';
import '../../../../../utils/nav_utail.dart';
import '../../../../notification/notification_provider.dart';
import '../../../../notification/notification_screen.dart';
import '../../child_details_provider.dart';

class ReviewsTab extends StatefulWidget {
  final String? studentId;

  const ReviewsTab({Key? key, required this.studentId}) : super(key: key);

  @override
  State<ReviewsTab> createState() => _ReviewsTabState();
}

class _ReviewsTabState extends State<ReviewsTab> {
  @override
  void initState() {
    super.initState();
    Provider.of<ChildDetailsProvider>(context, listen: false).getReviewList(context, widget.studentId??'');
    Provider.of<NotificationProvider>(context, listen: false).getCountNotification(context, widget.studentId??'');
}
  @override
  Widget build(BuildContext context) {
    final loading =context.watch<ChildDetailsProvider>().isLoading;
    return  Consumer<ChildDetailsProvider>(builder: (context, provider, _) {
        return Scaffold(
          appBar:  MyAppBar(haveLeading: true,
          title: LocaleKeys.reviews.tr(),
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
          body: loading ? const Center(child:  AppLoader()):(provider.reviewsModel?.data?.length==0)?NoDataScreen():
          ListView.builder(
            padding: EdgeInsets.all(8.r),
               shrinkWrap: true,
               itemCount: provider.reviewsModel?.data?.length, //from API
               itemBuilder: (context, index) {
                 return
                   InkWell(onTap: (){
                     push( DetailsItems(witchScreen: 'review', itemId:  provider.reviewsModel?.data?[index].id.toString(), studentId: widget.studentId,));
                   },
                     child: Container(
                     margin: EdgeInsets.symmetric(
                         horizontal: 16.w, vertical: 8.h),
                     padding: EdgeInsets.symmetric(
                         horizontal: 16.w, vertical: 16.h),
                     decoration: BoxDecoration(
                       color:
                       (provider.reviewsModel?.data?[index].type == 'negative')
                               ? Colors.red.shade50
                               :
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
                          Row(
                           children: [
                             Text(
                               LocaleKeys.studentCase.tr(),
                               style: TextStyle(
                                   fontWeight: FontWeight.bold),
                             ),
                             Text(
                               provider.reviewsModel?.data?[index].type=='negative'?LocaleKeys.punishment.tr():LocaleKeys.excellence.tr(),
                               style: TextStyle(
                                   fontWeight: FontWeight.bold,
                                   color:provider.reviewsModel?.data?[index].type == 'negative'? AppColors.colorDeepRed:AppColors.colorPrimary),
                             ),
                           ],
                         ),
                         SizedBox(height: 10.h,),
                          Row(
                           children: [
                             Text(
                               LocaleKeys.points.tr(),
                               style: TextStyle(
                                   fontWeight: FontWeight.bold),
                             ),
                             Text(
                               "( ${provider.reviewsModel?.data?[index].points} )",
                               style: TextStyle(
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                           ],
                         ),
                         SizedBox(height: 10.h,),
                             Row(
                           children: [
                             Text(
                               provider.reviewsModel?.data?[index].type=='negative'? LocaleKeys.penaltyBalanceBecame.tr():
                               LocaleKeys.balanceBenefitsBecome.tr(),
                               style: TextStyle(
                                   fontWeight: FontWeight.bold,fontSize: 13.sp),
                             ),
                             Text(
                               "( ${provider.reviewsModel?.data?[index].balance} )",
                               style: TextStyle(
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                           ],
                         ),
                         SizedBox(height: 5.h,),
                             Row(
                           children: [
                             Text(
                               LocaleKeys.totalBalance.tr(),
                               style: TextStyle(
                                   fontWeight: FontWeight.bold,fontSize: 13.sp),
                             ),
                             Text(
                               "( ${provider.reviewsModel?.data?[index].totalPoints} )",
                               style: TextStyle(
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                           ],
                         ),
                         // SizedBox(height: 5.h,),
                         //     Row(
                         //   children: [
                         //     Text(
                         //       LocaleKeys.sortingByChapter.tr(),
                         //       style: TextStyle(
                         //           fontWeight: FontWeight.bold,fontSize: 13.sp),
                         //     ),
                         //     Text(
                         //       "( ${provider.reviewsModel?.data?[index].roomRanking} )",
                         //       style: TextStyle(
                         //         fontWeight: FontWeight.bold,
                         //       ),
                         //     ),
                         //   ],
                         // ),
                         SizedBox(height: 10.h,),

                         Padding(
                           padding: EdgeInsets.only(
                               bottom: 6.h, top: 6.h),
                           child:  Column(crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               SizedBox(width:MediaQuery.of(context).size.width*.69,
                                 child: Row(
                                   children: [
                                     Text(LocaleKeys.Subject.tr(),style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold),),
                                     Expanded(child: Text(provider.reviewsModel?.data?[index].category?.title.toString()??'',style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis))),
                                   ],
                                 ),
                               ),
                               SizedBox(height: 5.h,),

                               SizedBox(width:MediaQuery.of(context).size.width*.69,
                                 child: Row(
                                   children: [
                                     Text(LocaleKeys.teacherName.tr(),style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold)),
                                     Expanded(child: Text(provider.reviewsModel?.data?[index].teacher?.name.toString()??'',style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis))),
                                   ],
                                 ),
                               ),
                             ],
                           ),
                         ),
                         SizedBox(
                           height: 5.h,
                         ),
                          Row(
                           children: [
                             Text(
                               LocaleKeys.theDate.tr(),
                               style: TextStyle(
                                   color: Colors.black54,fontSize: 13.sp),
                             ),
                             Text(
                               provider.reviewsModel?.data?[index].date.toString()??'',
                               style:  TextStyle(
                                   color: Colors.black54,fontSize: 13.sp),
                             ),
                           ],
                         )
                           ],
                         ),
                       ],
                     ),
                 ),
                   );
               }),
        );
      });
  }
}
