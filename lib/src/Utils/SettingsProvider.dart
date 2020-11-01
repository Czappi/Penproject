import 'package:shared_preferences/shared_preferences.dart';

enum DiaryType { table, tiles }

String _diaryKey = "diarytable";

class SettingsProvider {
  DiaryType diary;

  void initProvider() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // init diary
    if (prefs.containsKey(_diaryKey)) {
      diary = prefs.getBool(_diaryKey) ? DiaryType.table : DiaryType.tiles;
    } else {
      prefs.setBool(_diaryKey, true);
      diary = DiaryType.table;
    }
  }

  Future<void> changeDiaryType(DiaryType type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_diaryKey, type == DiaryType.table ? true : false);
    diary = type;
  }

  bool isTable() {
    return diary == DiaryType.table ? true : false;
  }
}
