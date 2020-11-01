import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubjectTile extends StatelessWidget {
  final String value;
  const SubjectTile({@required this.value});

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: Get.textTheme.bodyText2.apply(
          fontWeightDelta: 2,
          fontSizeFactor: 1.1,
          color: Get.isDarkMode ? Colors.white : Colors.black87),
    );
  }
}
