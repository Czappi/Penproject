import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

List<BarChartGroupData> barGroups(List<Map<String, dynamic>> data) {
  List<int> ints = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  var list = List.generate(10, (i) {
    var count = 0;
    var delayCount = 0;
    var missCount = 0;
    var absenceCount = 0;
    var x = ints.contains(i) ? i : ints.first;

    if (data.length - 1 >= i) {
      DateTime date = data[i]['date'];
      absenceCount = data[i]['absencecount'] ?? 0;
      missCount = data[i]['misscount'] ?? 0;
      delayCount = data[i]['delaycount'] ?? 0;
      count = data[i]['count'] ?? 0;
      x = getMonth(date.month);
      ints.remove(getMonth(date.month));
    }
    print(i);

    return makeGroupData(x, absenceCount.toDouble(), missCount.toDouble(),
        delayCount.toDouble(), count.toDouble());
  });
  list.sort((a, b) => a.x.compareTo(b.x));
  return list;
}

int getMonth(int i) {
  switch (i) {
    case 9:
      return 0;
      break;
    case 10:
      return 1;
      break;
    case 11:
      return 2;
      break;
    case 12:
      return 3;
      break;
    case 1:
      return 4;
      break;
    case 2:
      return 5;
      break;
    case 3:
      return 6;
      break;
    case 4:
      return 7;
      break;
    case 5:
      return 8;
      break;
    case 6:
      return 9;
      break;
    default:
      return 0;
  }
}

BarChartGroupData makeGroupData(
  int x,
  double absenceCount,
  double missCount,
  double delayCount,
  double count, {
  bool isTouched = false,
  Color barColor = Colors.white,
  double width = 22,
  List<int> showTooltips = const [],
  double barWidth = 10,
}) {
  return BarChartGroupData(
    x: x,
    barRods: [
      BarChartRodData(
        y: absenceCount.toDouble(),
        width: barWidth,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6), topRight: Radius.circular(6)),
        rodStackItems: [
          BarChartRodStackItem(0, absenceCount ?? 0, const Color(0xff2bdb90)),
        ],
      ),
      BarChartRodData(
        y: missCount.toDouble(),
        width: barWidth,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6), topRight: Radius.circular(6)),
        rodStackItems: [
          BarChartRodStackItem(0, missCount ?? 0, const Color(0xffffdd80)),
        ],
      ),
      BarChartRodData(
        y: delayCount.toDouble(),
        width: barWidth,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6), topRight: Radius.circular(6)),
        rodStackItems: [
          BarChartRodStackItem(0, delayCount ?? 0, const Color(0xff19bfff)),
        ],
      ),
    ],
  );
}
