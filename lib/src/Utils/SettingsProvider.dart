import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum DiaryType { table, tiles }

String _diaryKey = "diarytable";
String _themeKey = "darkmode";

class SettingsProvider {
  DiaryType diary;
  ThemeMode themeMode;

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
