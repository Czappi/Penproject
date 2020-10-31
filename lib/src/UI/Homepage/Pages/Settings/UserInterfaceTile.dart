import 'package:flutter/material.dart';
import 'package:penproject/src/Widgets/Homepage/Body/Pages/Settings/SettingsTile.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

import 'package:penproject/src/Widgets/Homepage/Body/Pages/Settings/Tiles/UserInterface/DiaryType/TablePreview.dart';
import 'package:penproject/src/Widgets/Homepage/Body/Pages/Settings/Tiles/UserInterface/DiaryType/GridPreview.dart';

class SettingsUserInterfaceTile extends StatelessWidget {
  const SettingsUserInterfaceTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsTile(
      icon: Feather.sidebar,
      title: 'User Interface'.tr,
      children: [
        Column(
          children: [
            Row(
              children: [
                Transform.scale(
                  scale: 1.0,
                  child: TablePreview(),
                ),
                Transform.scale(
                  scale: 1.0,
                  child: GridPreview(),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
