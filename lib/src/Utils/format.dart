import 'package:get/get.dart';

enum DateFormatType { basic, custom, date, yyyymmdd }

String capital(String s) => s != null
    ? s.length > 0
        ? s[0].toUpperCase() + s.substring(1).toLowerCase()
        : ""
    : null;

String capitalize(String s) =>
    s != null ? s.split(" ").map((w) => capital(w)).join(" ") : null;

String dateformat(DateFormatType type, {DateTime date, Duration duration}) {
  Duration _duration;
  if (date != null) {
    _duration = Duration(hours: date.hour, minutes: date.minute);
  } else if (duration != null) {
    _duration = duration;
  } else {
    _duration = Duration();
  }

  if (type == DateFormatType.basic) {
    String twoDigitHours = _toTwoDigits(_duration.inHours.remainder(60));
    String twoDigitMinutes = _toTwoDigits(_duration.inMinutes.remainder(60));
    return "$twoDigitHours:$twoDigitMinutes";
  } else if (type == DateFormatType.custom) {
    var hours = _duration.inHours;
    var minutes = _duration.inMinutes.remainder(60);
    if (hours >= 1 && minutes >= 1) {
      return "$hours" + "hour".tr + " " + "$minutes" + "minute".tr;
    } else if (hours >= 1 && minutes < 1) {
      return "$hours" + "hour".tr;
    } else if (hours < 1 && minutes >= 1) {
      return "$minutes" + "minute".tr;
    } else {
      return '';
    }
  } else if (type == DateFormatType.date) {
    //var year = date.year;
    var month = _toTwoDigits(date.month);
    var day = _toTwoDigits(date.day);
    return "$month.$day";
  } else if (type == DateFormatType.yyyymmdd) {
    var year = date.year;
    var month = _toTwoDigits(date.month);
    var day = _toTwoDigits(date.day);
    return "$year-$month-$day";
  } else {
    return '';
  }
}

String _toTwoDigits(int n) {
  if (n >= 10) return "$n";
  return "0$n";
}
