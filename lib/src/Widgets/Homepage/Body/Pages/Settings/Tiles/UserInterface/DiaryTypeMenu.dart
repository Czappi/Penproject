import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:penproject/src/Utils/SettingsProvider.dart';
import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';

class SettingsUIDiaryTypeMenu extends StatefulWidget {
  SettingsUIDiaryTypeMenu({Key key}) : super(key: key);

  @override
  _SettingsUIDiaryTypeMenuState createState() =>
      _SettingsUIDiaryTypeMenuState();
}

class _SettingsUIDiaryTypeMenuState extends State<SettingsUIDiaryTypeMenu> {
  bool tablemode;

  @override
  void initState() {
    tablemode = Get.context.read<SettingsProvider>().diary == DiaryType.table;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text('diarytable'.tr),
      value: tablemode,
      onChanged: (bool value) async {
        setState(() {
          tablemode = value;
        });
        await Get.context
            .read<SettingsProvider>()
            .changeDiaryType(value ? DiaryType.table : DiaryType.tiles);
      },
      secondary: const Icon(Feather.layout),
    );
  }
}
