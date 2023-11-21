import 'package:alandalos/core/app_loader.dart';
import 'package:alandalos/core/extensions/num_extensions.dart';
import 'package:alandalos/core/helper/no_data.dart';
import 'package:alandalos/custom_widgets/custom_build_profile_details.dart';
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
import '../detailsItems/details_item.dart';
import 'absences_provider.dart';

class AbsencesTab extends StatefulWidget {
  final String? studentId;

  const AbsencesTab({Key? key, this.studentId}) : super(key: key);

  @override
  State<AbsencesTab> createState() => _AbsencesTabState();
}

class _AbsencesTabState extends State<AbsencesTab> {
  @override
  void initState() {
    super.initState();
    Provider.of<ChildDetailsProvider>(context, listen: false).getAbsenceList(context, widget.studentId.toString());
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
            title: LocaleKeys.absences.tr(),
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
          body: loading? const Center(child: AppLoader()):
              (provider.absenceModel?.data?.length==0)?NoDataScreen():
              ListView.builder(
                padding: EdgeInsets.all(8.r),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:provider.absenceModel?.data?.length, //from API
                  itemBuilder: (context, index) {
                    return
                      InkWell(onTap: (){
                        NavUtil.navigateScreen(
                            context,DetailsItems(witchScreen: 'absence', itemId: provider.absenceModel?.data?[index].id.toString(), studentId: widget.studentId,));
                      },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 8.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 16.h),
                          decoration: BoxDecoration(
                            color:
                            (provider.absenceModel?.data?[index].type == 'absence')
                            ?Colors.red.shade50 : AppColors.colorPrimaryLight,
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
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        provider.absenceModel?.data?[index].type=='absence'? ' : ( ${LocaleKeys.absence.tr()} )':' : ( ${LocaleKeys.attendanc.tr()} )',
                                        style:  TextStyle(
                                          fontWeight: FontWeight.bold,color:(provider.absenceModel?.data?[index].type)=='absence'? AppColors.colorDeepRed:AppColors.colorPrimary),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.h,), Row(
                                    children: [
                                      Text(
                                        LocaleKeys.delayDays.tr(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                       "( ${provider.absenceModel?.data?[index].delayDay} )",
                                        style:  TextStyle(
                                          fontWeight: FontWeight.bold,),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.h,),
                                  Row(
                                    children: [
                                      Text(
                                        LocaleKeys.absenceDays.tr(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                          '( ${provider.absenceModel?.data?[index].absenceDay} )',
                                        style:  TextStyle(
                                          fontWeight: FontWeight.bold,),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.h,),
                                  SizedBox(width:MediaQuery.of(context).size.width*.69,
                                    child: Row(
                                      children: [
                                        Text(LocaleKeys.theDate.tr(),style: TextStyle(fontWeight: FontWeight.bold)),
                                        Expanded(
                                          child: Text(
                                               provider.absenceModel?.data?[index].date??
                                                  '',
                                              style: TextStyle(fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis,fontSize: 13.sp)),
                                        ),
                                      ],
                                    ),
                                  ),

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
