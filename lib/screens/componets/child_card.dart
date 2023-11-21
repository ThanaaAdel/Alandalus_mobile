import 'package:alandalos/core/extensions/num_extensions.dart';
import 'package:alandalos/core/resources/locale_keys.g.dart';
import 'package:alandalos/utils/common_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../core/resources/app_colors.dart';
import '../../data/model/response/childrenModel.dart';

class ChildCard extends StatelessWidget {
  const ChildCard({Key? key, required this.student}) : super(key: key);

  final ChildrenData? student;

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0.r),
      ),
      elevation: 3,
      margin:  EdgeInsets.only(bottom: 10.h),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 10.h),
        child:
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Row(
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(16.r),
                child: CachedNetworkImage(
                  width: 100.w,
                  height: 110.h,
                  fit: BoxFit.fill,
                  imageUrl: CommonUtils.loadImageUrl(student?.image ?? ""),
                  placeholder: (context, url) => Center(
                    child: Image.asset("assets/images/placeholder_image.png"),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              SizedBox(width: 10.h,),
              SizedBox(width: MediaQuery.of(context).size.width*0.47,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(student?.name ?? "",maxLines: 3,style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),),
                    Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(student?.room?.title ?? "",style: const  TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                          SizedBox(height: 5.h,),
                          Row(
                            children: [
                              Text(LocaleKeys.rankingSchool.tr(),maxLines: 2,style: TextStyle(color: Colors.black,fontSize: 14.sp),),
                              Text('( ${student?.schoolRank} )',style:   TextStyle(color: Colors.black,fontSize: 14.sp),maxLines: 2,),
                            ],
                          ),
                          SizedBox(height: 5.h,),
                          Row(
                            children: [
                              Text( LocaleKeys.rankingClass.tr(),maxLines: 2,style:   TextStyle(color: Colors.black,fontSize: 14.sp),),
                              Text('( ${student?.rowRank} )',maxLines: 2,style:  TextStyle(color: Colors.black,fontSize: 14.sp),),
                            ],
                          ),
                          SizedBox(height: 5.h,),
                          Row(
                            children: [
                              Text( LocaleKeys.rankingChapter.tr(),maxLines: 2,style:  TextStyle(color: Colors.black,fontSize: 14.sp),),
                              Text('( ${student?.roomRank} )',maxLines: 2,style:  TextStyle(color: Colors.black,fontSize: 14.sp),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
            (student?.newNotificationCount==0)?const SizedBox():Container(
            padding:const EdgeInsets.all(2),
            margin: EdgeInsets.all(5.r),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100.r), border: Border.all(
                width: .8.w,
                color: AppColors.light_grey),color: Colors.red),
            child: Center(child:Text(
              student?.newNotificationCount.toString()??'',
              style:TextStyle(
                color:Colors.white,
                fontSize: 10.sp,
              ),
            ) ,),)
        ],),
        // ListTile(
        //   leading: ClipRRect(borderRadius: BorderRadius.circular(16.r),
        //     child: CachedNetworkImage(
        //       width: 72.w,
        //       height: 72.h,
        //       fit: BoxFit.fill,
        //       imageUrl: CommonUtils.loadImageUrl(student?.image ?? ""),
        //       placeholder: (context, url) => Center(
        //         child: Image.asset("assets/images/placeholder_image.png"),
        //       ),
        //       errorWidget: (context, url, error) => const Icon(Icons.error),
        //     ),
        //   ),
        //   title: Text(student?.name ?? ""),
        //   subtitle: Padding(
        //     padding: EdgeInsets.only(top: 10.h),
        //     child: Text(student?.room?.title ?? ""),
        //   ),
        // ),
      ),
    );
  }
}
