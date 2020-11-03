import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:penproject/src/Utils/format.dart';

class TimetableLessonTileHeader extends StatelessWidget {
  final DateTime start;
  final DateTime end;
  const TimetableLessonTileHeader({this.start, this.end});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 12.h,
          width: 20.w,
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.horizontal(right: Radius.circular(10.sp)),
              color: Color(0xfffdbb7e)),
        ),
        SizedBox(
          width: 8.w,
        ),
        Text(
          dateformat(DateFormatType.basic, date: start.toLocal()),
          style: Get.textTheme.headline6
              .apply(color: Get.isDarkMode ? Colors.white70 : Colors.grey[800]),
        ),
        Expanded(
          child: Container(
            height: 26.h,
            alignment: Alignment.bottomRight,
            margin: EdgeInsets.only(right: 20.sp),
            child: Text(
              dateformat(DateFormatType.custom,
                  duration: end.toLocal().difference(start.toLocal())),
              style: Get.textTheme.bodyText2
                  .apply(fontSizeFactor: 1.1, color: Colors.grey[500]),
            ),
          ),
        )
      ],
    );
  }
}
