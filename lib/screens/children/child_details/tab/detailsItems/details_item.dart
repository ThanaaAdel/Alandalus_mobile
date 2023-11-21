import 'package:alandalos/core/app_loader.dart';
import 'package:alandalos/core/extensions/num_extensions.dart';
import 'package:alandalos/screens/componets/my_appbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/resources/app_colors.dart';
import '../../../../../core/resources/locale_keys.g.dart';
import 'details_Item_provider.dart';

class DetailsItems extends StatefulWidget {
  const DetailsItems({Key? key, required this.witchScreen, required this.itemId, required this.studentId}) : super(key: key);
  final String witchScreen;
  final String? itemId;
  final String? studentId;

  @override
  _DetailsItemsState createState() => _DetailsItemsState();
}

class _DetailsItemsState extends State<DetailsItems> {
  @override
  void initState() {
    super.initState();
   (widget.witchScreen=='review')? Provider.of<DetailsItemProvider>(context, listen: false).getReviewDetailsList(context, widget.itemId??'', widget.studentId??''):
   (widget.witchScreen=='exam')? Provider.of<DetailsItemProvider>(context, listen: false).getExamDetailsList(context, widget.itemId??'', widget.studentId??''):
    Provider.of<DetailsItemProvider>(context, listen: false).getAbsenceDetailsList(context, widget.itemId??'', widget.studentId??'');
  }
  @override
  Widget build(BuildContext context) {
   final loading =context.watch<DetailsItemProvider>().isLoading;
    return Consumer<DetailsItemProvider>(builder: (context, provider, _) {
    return  Scaffold(
      appBar:MyAppBar(backgroundColor: Colors.transparent,
        title: (widget.witchScreen=='review')?LocaleKeys.reviewDetails.tr():(widget.witchScreen=='exam')?LocaleKeys.testDetails.tr():LocaleKeys.absenceDetails.tr(),
        haveLeading: true,
        // child: Container(padding: EdgeInsets.symmetric(horizontal: 30.w),
        // ),
      ),body:loading? const Center(child: AppLoader()): Column(crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 50.h,),
        Center(
          child: Container(height: 180.h,decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r),), child:
            (widget.witchScreen=='review')?Image.asset('assets/images/review.png'):
            (widget.witchScreen=='exam')?Image.asset('assets/images/exam.png'):
            Image.asset('assets/images/students.png')),
        ),
        SizedBox(height: 30.h,),
        (widget.witchScreen=='review')?Container(
          margin: EdgeInsets.symmetric(
              horizontal: 16.w, vertical: 8.h),
          padding: EdgeInsets.symmetric(
              horizontal: 16.w, vertical: 18.h),
          decoration: BoxDecoration(
            color:
            (provider.reviewDetailsModel?.data?.type == 'negative')
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
                            fontWeight: FontWeight.bold,fontSize: 18.sp),
                      ),
                      Text(
                        '( ${ provider.reviewDetailsModel?.data?.type=='negative'?LocaleKeys.punishment.tr():LocaleKeys.excellence.tr()} )',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,fontSize: 18.sp,
                            color: provider.reviewDetailsModel?.data?.type=='negative'?AppColors.colorDeepRed:AppColors.colorPrimary),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h,),
                  Row(
                    children: [
                      Text(
                        LocaleKeys.points.tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,fontSize: 18.sp),
                      ),
                      Text(
                        "( ${provider.reviewDetailsModel?.data?.points} )",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,fontSize: 16.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h,),
                  Row(
                    children: [
                      Text(
                        (provider.reviewDetailsModel?.data?.type == 'negative')
                            ? LocaleKeys.penaltyBalanceBecame.tr():LocaleKeys.balanceBenefitsBecome.tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,fontSize: 16.sp),
                      ),
                      Text(
                        "( ${ provider.reviewDetailsModel?.data?.balance} )",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,fontSize: 16.sp
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h,),
                  Row(
                    children: [
                      Text(
                        LocaleKeys.totalBalance.tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,fontSize: 16.sp),
                      ),
                      Text(
                        "( ${ provider.reviewDetailsModel?.data?.totalPoints} )",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,fontSize: 16.sp
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(height: 10.h,),
                  // Row(
                  //   children: [
                  //     Text(
                  //       LocaleKeys.sortingByChapter.tr(),
                  //       style: TextStyle(
                  //           fontWeight: FontWeight.bold,fontSize: 16.sp),
                  //     ),
                  //     Text(
                  //       "( ${ provider.reviewDetailsModel?.data?.roomRanking} )",
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.bold,fontSize: 16.sp
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
                        SizedBox(width:MediaQuery.of(context).size.width*.80,
                          child: Row(
                            children: [
                              Text(LocaleKeys.Subject.tr(),style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold),),
                              Expanded(child: Text(
                                  provider.reviewDetailsModel?.data?.category?.title.toString()??
                                  '',style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis,),maxLines: 2,)),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h,),

                        SizedBox(width:MediaQuery.of(context).size.width*.69,
                          child: Row(
                            children: [
                              Text(LocaleKeys.teacherName.tr(),style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold)),
                              Expanded(child: Text(
                                  provider.reviewDetailsModel?.data?.teacher?.name.toString()??
                                  '',style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),maxLines: 2,)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Text(
                        LocaleKeys.theDate.tr(),
                        style: TextStyle(
                            color: Colors.black54,fontSize: 14.sp),
                      ),
                      Text(
                        provider.reviewDetailsModel?.data?.date.toString()??
                            '',
                        style:  TextStyle(
                            color: Colors.black54,fontSize: 14.sp),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ):
        (widget.witchScreen=='exam')?Container(
          margin: EdgeInsets.symmetric(
              horizontal: 16.w, vertical: 8.h),
          padding: EdgeInsets.symmetric(
              horizontal: 16.w, vertical: 18.h),
          decoration: BoxDecoration(
            // color: Colors.red.shade50,
            color: AppColors.colorPrimaryLight,
            borderRadius:
            BorderRadius.all(Radius.circular(12.r)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width:MediaQuery.of(context).size.width*.82,
                    child: Row(
                      children: [
                        Text(LocaleKeys.Subject.tr(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.sp)),
                        Expanded(
                          child: Text(provider.examDetailsModel?.data?.category?.title??'',
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.sp),maxLines: 3,),
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
                  SizedBox(height: 20.h,),
                  Row(
                    children: [
                      Text(
                        LocaleKeys.totalMarks.tr(),
                        style:  TextStyle(
                            fontWeight: FontWeight.bold,fontSize: 18.sp),
                      ),
                      Text(
                        " : ( ${provider.examDetailsModel?.data?.degreeOfExam} )",
                        style:  TextStyle(
                          fontWeight: FontWeight.bold,fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10.h,),

                  Padding(
                    padding: EdgeInsets.only(
                        bottom: 6.h, top: 6.h),
                    child:  Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(LocaleKeys.studentGrade.tr(),style:  TextStyle(
                                fontWeight: FontWeight.bold,fontSize: 18.sp),),
                            Text(' : ( ${provider.examDetailsModel?.data?.degreeOfStudent} )',style:  TextStyle(
                                fontWeight: FontWeight.bold,fontSize: 16.sp),),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(width:MediaQuery.of(context).size.width*.81,
                    child: Row(
                      children: [
                        Text(
                          LocaleKeys.teacherName.tr(),
                          style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Text(
                            provider.examDetailsModel?.data?.teacher?.name??'',
                            style:  TextStyle(fontSize: 14.sp,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ):
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: 16.w, vertical: 8.h),
          padding: EdgeInsets.symmetric(
              horizontal: 16.w, vertical: 18.h),
          decoration: BoxDecoration(
            color:
            (provider.absenceDetailsModel?.data?.type == 'absence')
                ?Colors.red.shade50
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
                        LocaleKeys.status.tr(),
                        style:  TextStyle(
                            fontWeight: FontWeight.bold,fontSize: 18.sp),
                      ),
                      Text(
                        provider.absenceDetailsModel?.data?.type=='absence'? ' : ( ${LocaleKeys.absence.tr()} )':' : ( ${LocaleKeys.attendanc.tr()} )',
                        style:  TextStyle(
                            fontWeight: FontWeight.bold,fontSize: 18.sp,color:(provider.absenceDetailsModel?.data?.type)=='absence'? AppColors.colorDeepRed:AppColors.colorPrimary),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h,),
                  Row(
                    children: [
                      Text(
                        LocaleKeys.delayDays.tr(),
                        style:  TextStyle(
                            fontWeight: FontWeight.bold,fontSize: 18.sp,),
                      ),
                      Text(
                        "( ${provider.absenceDetailsModel?.data?.delayDay} )",
                        style:  TextStyle(
                          fontWeight: FontWeight.bold,fontSize: 18.sp,),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h,),
                  Row(
                    children: [
                      Text(
                        LocaleKeys.absenceDays.tr(),
                        style:  TextStyle(
                            fontWeight: FontWeight.bold,fontSize: 18.sp,),
                      ),
                      Text(
                        '( ${provider.absenceDetailsModel?.data?.absenceDay} )',
                        style:  TextStyle(
                          fontWeight: FontWeight.bold,fontSize: 18.sp,),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h,),
                  SizedBox(width:MediaQuery.of(context).size.width*.69,
                    child: Row(
                      children: [
                        Text(LocaleKeys.theDate.tr(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.sp)),
                        Expanded(
                          child: Text(
                              provider.absenceDetailsModel?.data?.date??
                                  '',
                              style: TextStyle(fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis,fontSize: 18.sp)),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
    ],),
    );});
  }
}
