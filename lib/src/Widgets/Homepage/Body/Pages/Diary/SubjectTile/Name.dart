import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penproject/src/Utils/format.dart';

class DiarySubjectTileName extends StatelessWidget {
  final String name;
  const DiarySubjectTileName(this.name);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15)),
      child: Text(
        capitalize(name),
        style: Get.textTheme.headline6.apply(color: Colors.white),
      ),
    );
  }
}
