import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:penproject/src/Utils/SettingsProvider.dart';
import 'package:penproject/src/Widgets/RestartWidget.dart';
import 'package:provider/provider.dart';

class SettingsUIThemeMenu extends StatefulWidget {
  SettingsUIThemeMenu({Key key}) : super(key: key);

  @override
  _SettingsUIThemeMenuState createState() => _SettingsUIThemeMenuState();
}

class _SettingsUIThemeMenuState extends State<SettingsUIThemeMenu> {
  bool darkmode;

  @override
  void initState() {
    darkmode = Get.isDarkMode;
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

        var mode = value ? ThemeMode.dark : ThemeMode.light;

        // setting function
        Get.changeThemeMode(mode);
        context.read<SettingsProvider>().changeThemeMode(mode);

        // app restart
        RestartWidget.restartApp(context);
      },
      secondary: const Icon(Feather.moon),
    );
  }
}
