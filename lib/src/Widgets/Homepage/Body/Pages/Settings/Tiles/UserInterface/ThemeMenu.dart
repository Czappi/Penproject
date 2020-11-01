import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:penproject/main.dart';
import 'package:penproject/src/Widgets/RestartWidget.dart';
import 'package:theme_provider/theme_provider.dart';

class SettingsUIThemeMenu extends StatefulWidget {
  SettingsUIThemeMenu({Key key}) : super(key: key);

  @override
  _SettingsUIThemeMenuState createState() => _SettingsUIThemeMenuState();
}

class _SettingsUIThemeMenuState extends State<SettingsUIThemeMenu> {
  bool darkmode;

  @override
  void initState() {
    darkmode = ThemeProvider.themeOf(Get.context).id == "darktheme";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text('darkmode'.tr),
      value: darkmode,
      onChanged: (bool value) {
        setState(() {
          darkmode = value;
        });
        Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
        ThemeProvider.controllerOf(Get.context).nextTheme();
        RestartWidget.restartApp(context);
      },
      secondary: const Icon(Feather.moon),
    );
  }
}
