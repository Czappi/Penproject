import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiarySubjectTileAverage extends StatelessWidget {
  final double average;
  const DiarySubjectTileAverage(this.average);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15)),
      child: Text(
        average.toString(),
        style: Get.textTheme.bodyText2.apply(color: Colors.white),
      ),
    );
  }
}
