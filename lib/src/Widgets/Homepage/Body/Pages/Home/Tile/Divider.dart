import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeLessonTileDivider extends StatelessWidget {
  const HomeLessonTileDivider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      width: 1,
      height: double.infinity,
      color: Get.isDarkMode ? Colors.black87 : Colors.grey[300],
    );
  }
}
