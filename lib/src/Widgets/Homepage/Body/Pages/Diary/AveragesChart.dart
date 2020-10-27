import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AveragesChart extends StatelessWidget {
  final Map<int, double> averages;
  const AveragesChart({this.averages});

  static Color color = Get.theme.buttonColor;

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: EdgeInsets.all(10.sp),
      //color: Get.theme.cardColor,
      child: Stack(
        children: <Widget>[
          Container(
            height: 250.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(18.sp),
              ),
              color: Get.theme.cardColor, //Color(0xff232d37)
            ),
            child: LineChart(
              mainData(),
            ),
          ),
        ],
      ),
    );
  }

  List<FlSpot> spots() {
    List<FlSpot> spots = [];
    for (var i = 1; i < 10; i++) {
      if (averages.containsKey(i)) {
        if (i == 1 || averages[i] != 0.0)
          spots.add(FlSpot(
              (i - 1).toDouble(), averages[i].toPrecision(2).toDouble()));
      }
    }
    return spots;
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false, //true,
        drawHorizontalLine: false,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
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
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'OCTShort'.tr;
              case 5:
                return 'JANShort'.tr;
              case 8:
                return 'APRShort'.tr;
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15.sp,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '1';
              case 3:
                return '3';
              case 5:
                return '5';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: false, //true,
          border: Border.all(color: const Color(0xff37434d), width: 1.sp)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: spots(),
          isCurved: true,
          colors: [color], //gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: [color.withOpacity(0.3)],
          ),
        ),
      ],
    );
  }
}
