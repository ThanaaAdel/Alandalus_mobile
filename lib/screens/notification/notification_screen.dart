import 'package:alandalos/core/app_loader.dart';
import 'package:alandalos/core/extensions/num_extensions.dart';
import 'package:alandalos/core/routing/route.dart';
import 'package:alandalos/screens/componets/my_appbar.dart';
import 'package:alandalos/screens/notification/notification_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/res.dart';
import '../children/child_details/tab/detailsItems/details_item.dart';
import '../children/children_provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key, required this.parentId})
      : super(key: key);
  final String parentId;

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<NotificationProvider>(context, listen: false).getNotificationList(context, widget.parentId);
    Provider.of<NotificationProvider>(context, listen: false).readNotificationAPI(context, widget.parentId);
    Provider.of<StudentsProvider>(context, listen: false).refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(
      builder: (context, provider, _) {
        return Scaffold(
            backgroundColor: AppColors.bgColor,
            appBar: MyAppBar(
              title: tr("notifications"),haveLeading: true,
            ),
            body: Padding(
              padding:  EdgeInsets.symmetric(vertical: 8.0.r),
              child: Column(
                children: [
              provider.isLoading
                  ? Container(height: 500,
                  child: Center(child: AppLoader()))
                  : Expanded(
                      child: (provider.notificationModel?.data?.length != 0)
                          ? ListView.builder(
                              itemCount:
                                  provider.notificationModel?.data?.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(children: [
                                  InkWell(
                                    onTap: () {
                                      push(DetailsItems(witchScreen: provider.notificationModel?.data?[index].type??'', itemId: provider.notificationModel?.data?[index].foreignId.toString(), studentId: provider.notificationModel?.data?[index].student?.id.toString(),));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 16.w, vertical: 8.h),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w, vertical: 10.h),
                                      decoration: BoxDecoration(
                                        color:
                                        provider.notificationModel?.data?[index].type=='exam'
                                            ? Colors.green.shade100
                                            :provider.notificationModel?.data?[index].type=='review'?
                                        Colors.red.shade100:AppColors.colorPrimaryLight,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12.r)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          ClipOval(
                                            child: CachedNetworkImage(
                                              height: 52.h,
                                              width: 52.w,
                                              fit: BoxFit.cover,
                                              imageUrl: 'CommonUtils.loadImageUrl(data?.image)',
                                              placeholder: (context, url) =>
                                                  Center(
                                                child: Image.asset(
                                                    "assets/images/placeholder_image.png"),
                                              ),
                                              errorWidget: (context, url,
                                                      error) =>
                                                  Image.asset(
                                                      (provider.notificationModel?.data?[index].type=='exam')?'assets/images/exam.png':(provider.notificationModel?.data?[index].type=='review')?'assets/images/review.png'
                                                          :'assets/images/students.png'
                                                  ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Wrap(
                                                children: [
                                                  Text(
                                                    provider
                                                            .notificationModel
                                                            ?.data?[index]
                                                            .title ??
                                                        '',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(bottom: 6.h,top: 6.h),
                                                    child: Text(provider
                                                            .notificationModel
                                                            ?.data?[index]
                                                            .text ??
                                                        ''),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Text(
                                                provider.notificationModel
                                                        ?.data?[index].date
                                                        .toString() ??
                                                    '',
                                                style: const TextStyle(
                                                    color: Colors.black54),
                                              )
                                            ],
                                          )),
                                        ],
                                      ),
                                    ),
                                  )
                                ]);
                              },
                            )
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                    'https://i.pinimg.com/originals/f3/36/64/f3366437556b621bc1b69248bf5a08c4.png',
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    tr("no_notification_found"),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )),
                ],
              ),
            ));
      },
    );
  }
}
