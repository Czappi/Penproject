import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:penproject/src/Widgets/CardFoundation.dart';
import 'package:penproject/src/Widgets/Homepage/Body/Pages/Diary/AveragesChart.dart';

class DiaryAllAverage extends StatelessWidget {
  final Map<int, double> averages;
  DiaryAllAverage({this.averages});

  @override
  Widget build(BuildContext context) {
    return CardFoundation(
      margin: EdgeInsets.fromLTRB(8.sp, 8.sp, 8.sp, 18.sp),
      color:
          Get.isDarkMode ? Colors.lightBlueAccent[900] : Colors.lightBlueAccent,
      child: Column(
        children: [
          Container(
            height: 90.h,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20.sp),
            child: Text('totalaverage'.tr,
                style: Get.textTheme.headline6.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 26.sp)),
          ),
          AveragesChart(
            averages: averages,
          )
        ],
      ),
    );
  }
}
