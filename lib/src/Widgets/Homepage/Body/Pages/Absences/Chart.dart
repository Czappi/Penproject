import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:penproject/src/Widgets/CardFoundation.dart';

import 'chart/barGroups.dart';
import 'chart/data.dart';

class AbsencesChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  AbsencesChart({@required this.data});

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
            child: Text('absences'.tr,
                style: Get.textTheme.headline6.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 26.sp)),
          ),
          Container(
            padding: EdgeInsets.all(10.sp),
            child: Stack(
              children: <Widget>[
                Container(
                    height: 250.h,
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(20.sp, 10.sp, 20.sp, 10.sp),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(18.sp),
                      ),
                      color: Get.theme.cardColor, //Color(0xff232d37)
                    ),
                    child: BarChart(barChartData(barGroups(data)))),
              ],
            ),
          )
        ],
      ),
    );
  }
}
