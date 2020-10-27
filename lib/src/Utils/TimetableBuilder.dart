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

    // prev
    prevstart = schoolStart
        .add(Duration(days: 7 * (weekOfYear - 1) - (schoolStart.weekday - 1)));
    if (prevstart.isBefore(DateTime(now.year, DateTime.september, 1))) {
      prevstart = DateTime(now.year, DateTime.september, 1);
    }

    prevend = schoolStart
        .add(Duration(days: 7 * (weekOfYear - 1) + (6 - schoolStart.weekday)));
    if (DateTime(now.year, DateTime.september).isAfter(now)) {
      if (prevend.isAfter(DateTime(now.year, DateTime.august, 31))) {
        prevstart = DateTime(now.year, 9, 1);
      }
    }

    // current week
    currentstart = schoolStart
        .add(Duration(days: 7 * weekOfYear - (schoolStart.weekday - 1)));
    if (currentstart.isBefore(DateTime(now.year, DateTime.september, 1))) {
      currentstart = DateTime(now.year, DateTime.september, 1);
    }

    currentend = schoolStart
        .add(Duration(days: 7 * weekOfYear + (6 - schoolStart.weekday)));
    if (DateTime(now.year, DateTime.september).isAfter(now)) {
      if (currentend.isAfter(DateTime(now.year, DateTime.august, 31))) {
        currentstart = DateTime(now.year, 9, 1);
      }
    }

    // next
    nextstart = schoolStart
        .add(Duration(days: 7 * (weekOfYear - 1) - (schoolStart.weekday - 1)));
    if (nextstart.isBefore(DateTime(now.year, DateTime.september, 1))) {
      nextstart = DateTime(now.year, DateTime.september, 1);
    }

    nextend = schoolStart
        .add(Duration(days: 7 * (weekOfYear - 1) + (6 - schoolStart.weekday)));
    if (DateTime(now.year, DateTime.september).isAfter(now)) {
      if (nextend.isAfter(DateTime(now.year, DateTime.august, 31))) {
        nextstart = DateTime(now.year, 9, 1);
      }
    }

    return {
      'prevstart': prevstart,
      'prevend': prevend,
      'currentstart': currentstart,
      "currentend": currentend,
      'nextstart': nextstart,
      'nextend': nextend,
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
    print('$today - $weeklength');

    if (today > weeklength) {
      today = weeklength;
    }
    return today - 1;
  }
}
