DateTime getSchoolStartDate() {
  final now = DateTime.now();
  DateTime schoolStart;

  if (DateTime(now.year, DateTime.september).isAfter(now))
    schoolStart = DateTime(now.year - 1, DateTime.september, 1);
  else
    schoolStart = DateTime(now.year, DateTime.september, 1);

  if (schoolStart.weekday == 6 || schoolStart.weekday == 7)
    schoolStart = schoolStart.add(Duration(days: -schoolStart.weekday + 8));

  return schoolStart;
}
