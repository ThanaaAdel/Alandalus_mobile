import 'package:alandalos/screens/componets/my_appbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/res.dart';
import 'details_provider.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key, this.appointmentId}) : super(key: key);

  final int? appointmentId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => DetailsProvider(appointmentId!),
      child: Consumer<DetailsProvider>(
        builder: (context, provider, _) {
          // final data = provider.appointmentDetails?.data;
          return Scaffold(
            backgroundColor: AppColors.bgColor,
            appBar: MyAppBar(
              title: tr("appointment_details"),
              haveLeading: true,
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 2), // changes position of shadow
                  ),
                ], borderRadius: const BorderRadius.all(Radius.circular(12)), color: Colors.white),
                child: Column(
                  children: [
                    buildContainer(
                        title: tr('Appointment with'), titleValue:
                    // data?.appoinmentWith ??
                        ''),
                    buildContainer(title: tr("description"), titleValue:
                    // data?.title ??
                            ''),
                    buildContainer(title: tr("date"), titleValue:
                    // data?.date ??
                        ''),
                    buildContainer(title: tr("time"), titleValue:
                    // data?.time ??
                        ''),
                    buildContainer(title: tr("location"), titleValue:
                    // data?.location ??
                        ''),
                    buildContainer(title: tr("day"), titleValue:
                    // data?.day ??
                        ''),
                    buildContainer(title: tr("start_time"), titleValue:
                    // data?.startAt ??
                        ''),
                    buildContainer(title: tr("end_time"), titleValue:
                    // data?.endAt ??
                        ''),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Theme(
                        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          title: Text('data?.appoinmentWith ??' ''),
                          children: [
                            buildContainer(
                                title: tr("agree"),
                                titleValue: 'data?.otherParticipant?.isAgree ??' ''),
                            buildContainer(
                                title: tr("present"),
                                titleValue: 'data?.otherParticipant?.isPresent ??' ''),
                            buildContainer(
                                title: tr("present_at"),
                                titleValue: 'data?.otherParticipant?.presentAt ??' ''),
                            buildContainer(
                                title: tr("appointment_start_at"),
                                titleValue: 'data?.otherParticipant?.appoinmentStartedAt ??' ''),
                            buildContainer(
                                title: tr("appointment_end_at"),
                                titleValue: 'data?.otherParticipant?.appoinmentEndedAt ??' ''),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Container buildContainer(
      {String? title,
      String? titleValue,
      Function()? onPressed,
      bool iconVisibility = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.5, color: Colors.grey),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 130, child: Text(title ?? '')),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    titleValue ?? '',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                    maxLines: 1,
                  ),
                ),
                Visibility(
                  visible: iconVisibility,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(25),
                    onTap: onPressed,
                    child: const Icon(
                      Icons.edit,
                      size: 20,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
