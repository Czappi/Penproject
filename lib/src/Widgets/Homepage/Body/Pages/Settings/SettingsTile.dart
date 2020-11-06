import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:penproject/src/Widgets/CardFoundation.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<Widget> children;
  const SettingsTile(
      {@required this.icon, @required this.title, @required this.children});

  @override
  Widget build(BuildContext context) {
    return CardFoundation(
      child: ExpansionTile(
        leading: Icon(icon),
        title: Text(title, style: Get.textTheme.headline6),
        children: children,
        childrenPadding: EdgeInsets.only(bottom: 8.sp),
      ),
    );
  }
}
