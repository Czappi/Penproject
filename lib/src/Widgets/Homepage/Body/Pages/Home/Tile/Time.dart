import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penproject/src/Utils/format.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeLessonTileTime extends StatelessWidget {
  final DateTime start;
  const HomeLessonTileTime({this.start});

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: EdgeInsets.only(right: 10.sp),
      child: Center(
        child: Text(
          dateformat(DateFormatType.basic),
          style: Get.textTheme.headline6,
        ),
      ),
    );
  }
}
