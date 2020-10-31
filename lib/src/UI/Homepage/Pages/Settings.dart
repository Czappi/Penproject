import 'package:flutter/material.dart';
import 'Settings/UserInterfaceTile.dart';

// TODO
class HomepageSettings extends StatelessWidget {
  const HomepageSettings({Key key}) : super(key: key);

  static List<Widget> children = [
    SettingsUserInterfaceTile(),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: children.length,
      itemBuilder: (BuildContext context, int index) {
        return children[index];
      },
    );
  }
}
