import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeLessonsTitle extends StatelessWidget {
  final int count;
  const HomeLessonsTitle({this.count});

  @override
  Widget build(BuildContext context) {
    String _count = count != null ? count.toString() : "0";
    return Container(
      height: 60.h,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 20.sp),
      child: Row(
        children: [
          Text.rich(TextSpan(children: [
            TextSpan(text: 'todaylessons'.tr, style: Get.textTheme.headline6),
            TextSpan(
                text: " ($_count)",
                style: Get.textTheme.headline6
                    .apply(color: Colors.black54, fontSizeFactor: 0.8))
          ]))
        ],
      ),
    );
  }
}

/*
Container(
            height: 90.h,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20.sp),
            child:  ,)*/

/*Row(
      children: [
        Text.rich(TextSpan(children: [
          TextSpan(text: 'todaylessons'.tr, style: Get.textTheme.headline6),
          TextSpan(
              text: " ($_count)",
              style: Get.textTheme.headline6
                  .apply(color: Colors.black54, fontSizeFactor: 0.8))
        ]))
      ],
    ) */
