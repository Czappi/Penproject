import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

export 'package:provider/provider.dart';

enum DiaryType { table, tiles }

String _diaryKey = "diarytable";
String _themeKey = "darkmode";

String _notifIntervalKey = _notifKey("interval");
String _notifOnlyWifiKey = _notifKey("onlywifi");
String _notifLastRefreshKey = _notifKey("last");

String _notifKey(String tag) => "notif.$tag";

class SettingsProvider {
  DiaryType diary;
  ThemeMode themeMode;
  Duration refreshInterval;
  bool refreshOnlyWifi;
  DateTime refreshLast;

  Future<bool> initProvider() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // init diary
      if (prefs.containsKey(_diaryKey)) {
        diary = prefs.getBool(_diaryKey) ? DiaryType.table : DiaryType.tiles;
      } else {
        prefs.setBool(_diaryKey, true);
        diary = DiaryType.table;
      }

      // init theme
      if (prefs.containsKey(_themeKey)) {
        themeMode = prefs.getBool(_themeKey) ? ThemeMode.dark : ThemeMode.light;
      } else {
        var darkmode =
            MediaQuery.of(Get.context).platformBrightness == Brightness.dark;
        prefs.setBool(_themeKey, darkmode);
        themeMode = darkmode ? ThemeMode.dark : ThemeMode.light;
      }

      // init notification
      if (prefs.containsKey(_notifOnlyWifiKey)) {
        refreshOnlyWifi = prefs.getBool(_notifOnlyWifiKey);
      } else {
        prefs.setBool(_notifOnlyWifiKey, true);
        refreshOnlyWifi = true;
      }
      //
      if (prefs.containsKey(_notifIntervalKey)) {
        refreshInterval =
            Duration(milliseconds: prefs.getInt(_notifIntervalKey));
      } else {
        var d = Duration(minutes: 30);
        prefs.setInt(_notifIntervalKey, d.inMilliseconds);
        refreshInterval = d;
      }
      //
      if (prefs.containsKey(_notifLastRefreshKey)) {
        refreshLast = DateTime.fromMillisecondsSinceEpoch(
            prefs.getInt(_notifLastRefreshKey));
      } else {
        var d = DateTime.now();
        prefs.setInt(_notifLastRefreshKey, d.millisecondsSinceEpoch);
        refreshLast = d;
      }

      return true;
    } catch (e) {
      print("SettingsProvider.initProvider ERROR: $e");
      return false;
    }
  }

  Future<void> changeThemeMode(ThemeMode mode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, mode == ThemeMode.dark);
    themeMode = mode;
  }

  Future<void> changeDiaryType(DiaryType type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_diaryKey, type == DiaryType.table);
    diary = type;
  }

  bool isTable() {
    return diary == DiaryType.table ? true : false;
  }
}
