import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

BarChartData barChartData(List<BarChartGroupData> barGroups) {
  return BarChartData(
    maxY: maxY(barGroups),
    barTouchData: BarTouchData(
      touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.blueGrey,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String month;
            switch (groupIndex) {
              case 0:
                month = 'SEPTEMBER'.tr;
                break;
              case 1:
                month = 'OCTOBER'.tr;
                break;
              case 2:
                month = 'NOVEMBER'.tr;
                break;
              case 3:
                month = 'DECEMBER'.tr;
                break;
              case 4:
                month = 'JANUARY'.tr;
                break;
              case 5:
                month = 'FEBUARY'.tr;
                break;
              case 6:
                month = 'MARCH'.tr;
                break;
              case 7:
                month = 'APRIL'.tr;
                break;
              case 8:
                month = 'MAY'.tr;
                break;
              case 9:
                month = 'JUNE'.tr;

                break;
            }
            return BarTooltipItem(
                "$month" +
                    "\n" +
                    "absence".tr +
                    ": " +
                    (group.barRods[0].y).toInt().toString() +
                    "\n" +
                    "miss".tr +
                    ": " +
                    (group.barRods[1].y).toInt().toString() +
                    "\n" +
                    "delay".tr +
                    ": " +
                    (group.barRods[2].y).toInt().toString(),
                TextStyle(color: Colors.yellow));
          }),
    ),
    titlesData: FlTitlesData(
      show: true,
      bottomTitles: SideTitles(
        showTitles: true,
        reservedSize: 22,
        textStyle: TextStyle(
            color: Color(0xff68737d),
            fontWeight: FontWeight.bold,
            fontSize: 16.sp),
        getTitles: (double value) {
          switch (value.toInt()) {
            case 0:
              return 'SEPShort'.tr;
              break;
            /* case 2:
              return 'NOVShort'.tr;
              break; */
            case 4:
              return 'JANShort'.tr;
              break;
            /* case 6:
              return 'MARShort'.tr;
              break; */
            case 8:
              return 'MAYShort'.tr;
              break;
            default:
              return "";
          }
        },
      ),
      leftTitles: SideTitles(
        showTitles: false,
      ),
    ),
    borderData: FlBorderData(
      show: false,
    ),
    barGroups: barGroups,
  );
}

double maxY(List<BarChartGroupData> barGroups) {
  var ylist = barGroups.map((e) {
    var l = e.barRods;
    l.sort((a, b) => b.y.compareTo(a.y));
    return l.first.y;
  }).toList();
  ylist.sort((a, b) => b.compareTo(a));
  return ylist.first * 1.3;
}
