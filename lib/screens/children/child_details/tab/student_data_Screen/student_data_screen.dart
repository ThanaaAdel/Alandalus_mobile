import 'package:alandalos/core/app_loader.dart';
import 'package:alandalos/core/extensions/num_extensions.dart';
import 'package:alandalos/core/resources/app_colors.dart';
import 'package:alandalos/core/resources/locale_keys.g.dart';
import 'package:alandalos/screens/children/children_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../../core/routing/route.dart';
import '../../../../../utils/month_lib/month_picker_dialog.dart';
import '../../../../componets/my_appbar.dart';
import '../../../../notification/notification_provider.dart';
import '../../../../notification/notification_screen.dart';
class StudentDataScreen extends StatefulWidget {
  const StudentDataScreen({Key? key, required this.studentId}) : super(key: key);
  final String studentId;

  @override
  _StudentDataScreenState createState() => _StudentDataScreenState();
}

class _StudentDataScreenState extends State<StudentDataScreen> {

  String? selectedDate;
@override
  void initState() {
    super.initState();
    Provider.of<NotificationProvider>(context, listen: false).getCountNotification(context, widget.studentId??'');
}
  @override
  Widget build(BuildContext context) {
    return Consumer<StudentsProvider>(
        builder: (context, provider, _) {
          return Scaffold(resizeToAvoidBottomInset: false,
              appBar:  MyAppBar(haveLeading: true,
                title: LocaleKeys.studentGrades.tr(),
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
        body:(provider.isLoading)?const Center(child: AppLoader()): SingleChildScrollView(
          child: Padding(
              padding:  EdgeInsets.all(8.0.r),
              child: Column(
                children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(height: 45.h,
                        margin: EdgeInsets.all(10.r),
                        padding:EdgeInsets.all(10.r) ,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r),border: Border.all(width: 1.w,color: AppColors.borderColor),color: Color(0xFFFFE57F)
                        ),child: Center(child: Text(
                          LocaleKeys.schoolType.tr(),
                          style: TextStyle(
                            color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp),
                        )),

                      ),
                    ],
                  ),
                  InkWell(
                    onTap: (){
                      showMonthPicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(DateTime.now().year, 1),
                        lastDate: DateTime(DateTime.now().year, 12),
                      ).then((date) {
                        if (date != null) {
                          setState(() {
                            print(date);
                            String formattedMonth = DateFormat('MMMM').format(date);
                            print(formattedMonth);
                            selectedDate = formattedMonth;
                            int month = date.month;
                            print(month);
                            Provider.of<StudentsProvider>(context,listen: false).getGraduateApi(context,widget.studentId,month);
                          });
                        }
                      });
                    },
                    child: Container(
                      height: 40.h,width: 150.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: AppColors.colorPrimary,
                        border: Border.all(
                          width: 1.w,
                          color: AppColors.borderColor,
                        ),
                      ),
                      child: Center(
                        child: Text(
                            LocaleKeys.selectMonth.tr(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp),
                        ),
                      ),
                    ),
                  ),
                  Container(height: 45.h,
                    margin: EdgeInsets.all(10.r),
                    padding:EdgeInsets.all(10.r) ,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r),border: Border.all(width: 1.w,color: AppColors.borderColor),color: Color(0xFFD6D6D6)
                    ),child: Center(child: Text(
                      LocaleKeys.behavioralReport.tr(),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp),
                    ),),

                  ),
                  selectedDate == null ? SizedBox(height: 400.h,
                    child: Center(child:Text(
                    LocaleKeys.selectMonthFirst.tr(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,color: Colors.red,),
                  ) ,),):
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                          width: 4.w,
                          color: Colors.black,
                        ),
                      ),
                      child: Column(children: [
                        Container(
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: Color(0xffAED581),
                            border: Border.all(
                              color: Colors.black,
                              width: 1.0.w,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              LocaleKeys.academicReport.tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp),
                            ),
                          ),
                        ),
                        Container(
                            height: 180.h,
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    buildItem(LocaleKeys.subjectName.tr(), Colors.black12),
                                    buildItem(
                                        LocaleKeys.totalMarks.tr(), Colors.black12),
                                    buildItem(LocaleKeys.studentGrade.tr(), Colors.white),
                                  ],
                                ),
                                Expanded(
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: provider.graduateModel?.data?.academicReport?.exams?.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            buildItem(provider.graduateModel?.data?.academicReport?.exams?[index].category?.title??'',
                                                Colors.black12),
                                            buildItem(provider.graduateModel?.data?.academicReport?.exams?[index].degreeOfExam.toString()??'', Colors.black12),
                                            buildItem(provider.graduateModel?.data?.academicReport?.exams?[index].degreeOfStudent.toString()??'', Colors.white),
                                          ],
                                        );
                                      }),
                                ),
                                Column(
                                  children: [
                                    buildItem(
                                        LocaleKeys.academicAppreciation.tr(), Colors.white),
                                    Container(
                                      height: 120.h,
                                      width: 80.w,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1.w,
                                        ),
                                      ),
                                      child: Center(
                                        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text('${provider.graduateModel?.data?.academicReport?.appreciationPercentage ?? ""} \%'),
                                            Text(provider.graduateModel?.data?.academicReport?.appreciationTitle??''),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ])),
                  SizedBox(
                    height: 50.h,
                  ),
                  selectedDate == null ? SizedBox():
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                          width: 4.w,
                          color: Colors.black,
                        ),
                      ),
                      child: Column(children: [
                        Container(
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: Color(0xffFFAB91),
                            border: Border.all(
                              color: Colors.black,
                              width: 1.0.w,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              LocaleKeys.behaviorReport.tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp),
                            ),
                          ),
                        ),
                        Container(
                            height: 120.h,
                            child: Row(
                              children: [
                                // Column(
                                //   children: [
                                //     buildItem(
                                //         LocaleKeys.totalMarks.tr()
                                //
                                //         , Colors.black12),
                                //     buildItem(LocaleKeys.studentGrade.tr(), Colors.white),
                                //   ],
                                // ),
                                Expanded(
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      Column(
                                              children: [
                                                buildItem(LocaleKeys.numberOfAbsenceDays.tr(),
                                                    Colors.black12),
                                                buildItem(provider.graduateModel?.data?.behavioralReport?.scrollBehavioralReport?.numberOfAbsenceDay.toString()??'', Colors.white),
                                              ],
                                            ),Column(
                                              children: [
                                                buildItem(LocaleKeys.numberOfDelayDay.tr(),
                                                    Colors.black12),
                                                buildItem(provider.graduateModel?.data?.behavioralReport?.scrollBehavioralReport?.numberOfDelayDay.toString()??'', Colors.white),
                                              ],
                                            ),Column(
                                              children: [
                                                buildItem(LocaleKeys.positivePoints.tr(),
                                                    Colors.black12),
                                                buildItem(provider.graduateModel?.data?.behavioralReport?.scrollBehavioralReport?.positivePoint.toString()??'', Colors.white),
                                              ],
                                            ),Column(
                                              children: [
                                                buildItem(LocaleKeys.negativePoints.tr(),
                                                    Colors.black12),
                                                buildItem(provider.graduateModel?.data?.behavioralReport?.scrollBehavioralReport?.negativePoint.toString()??'', Colors.white),
                                              ],
                                            ),Column(
                                              children: [
                                                buildItem(LocaleKeys.totalPoints.tr(),
                                                    Colors.black12),
                                                buildItem(provider.graduateModel?.data?.behavioralReport?.scrollBehavioralReport?.totalPoint.toString()??'', Colors.white),
                                              ],
                                            ),
                                    ],
                                  )

                                ),
                                Column(
                                  children: [
                                    buildItem(
                                        LocaleKeys.behavioralAppreciation.tr(), Colors.black12),
                                    Container(
                                      height: 60.h,
                                      width: 80.w,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1.w,
                                        ),
                                      ),
                                      child: Center(
                                        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(provider.graduateModel?.data?.behavioralReport?.appreciationTitle??''),
                                            Text('${provider.graduateModel?.data?.behavioralReport?.appreciationPercentage} \%'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            )),
                      ])),
                ],
              )),
        ));});
  }

  buildItem(String text, Color color) {
    return Container(
      height: 60.h,
      width: 80.w,
      decoration: BoxDecoration(
        color: color,
        border: Border(
          left: BorderSide(
            color: Colors.black,
            width: 1.0.w,
          ),
          right: BorderSide(
            color: Colors.black,
            width: 1.0.w,
          ),
          bottom: BorderSide(
            color: Colors.black,
            width: 1.0.w,
          ),
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
