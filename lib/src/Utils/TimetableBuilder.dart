class TimetableBuilder {
  /// Without lessons
  Map<String, dynamic> getWeek(int weekOfYear) {
    // Returns the current week of the school year
    final now = DateTime.now();
    DateTime schoolStart;
    DateTime prevstart;
    DateTime prevend;
    DateTime currentstart;
    DateTime currentend;
    DateTime nextstart;
    DateTime nextend;

    if (DateTime(now.year, DateTime.september).isAfter(now))
      schoolStart = DateTime(now.year - 1, DateTime.september, 1);
    else
      schoolStart = DateTime(now.year, DateTime.september, 1);

    if (schoolStart.weekday == 6 || schoolStart.weekday == 7)
      schoolStart = schoolStart.add(Duration(days: -schoolStart.weekday + 8));

    Map<String, DateTime> startEnd(int weekOfYear) {
      DateTime start, end;
      start = schoolStart
          .add(Duration(days: 7 * weekOfYear - (schoolStart.weekday - 1)));
      if (start.isBefore(DateTime.utc(now.year, DateTime.september, 1))) {
        start = DateTime.utc(now.year, DateTime.september, 1);
      }
      end = schoolStart
          .add(Duration(days: 7 * weekOfYear + (7 - schoolStart.weekday)));
      if (DateTime.utc(now.year, DateTime.september).isAfter(now)) {
        if (end.isAfter(DateTime.utc(now.year, DateTime.august, 31))) {
          start = DateTime.utc(now.year, 9, 1);
        }
      }
      return {"start": start, "end": end};
    }

    var prev = startEnd(weekOfYear - 1);
    var current = startEnd(weekOfYear);
    var next = startEnd(weekOfYear + 1);

    return {
      'prevstart': prev['start'],
      'prevend': prev["end"],
      'currentstart': current["start"],
      "currentend": current["end"],
      'nextstart': next["start"],
      'nextend': next['end'],
    };
  }

  int getCurrentWeek() {
    final now = DateTime.now();
    DateTime schoolStart;

    if (DateTime(now.year, DateTime.september).isAfter(now))
      schoolStart = DateTime(now.year - 1, DateTime.september, 1);
    else
      schoolStart = DateTime(now.year, DateTime.september, 1);

    if (schoolStart.weekday == 6 || schoolStart.weekday == 7)
      schoolStart = schoolStart.add(Duration(days: -schoolStart.weekday + 8));

    return ((now.difference(schoolStart).inDays - (now.weekday - 1)) / 7)
            .floor() +
        1;
  }

  int today(int weeklength) {
    var today = DateTime.now().weekday;
    //print('$today - $weeklength');

    if (today > weeklength) {
      today = weeklength;
    }
    return today - 1;
  }
}
