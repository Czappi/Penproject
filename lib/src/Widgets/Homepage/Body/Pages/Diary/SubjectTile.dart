import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:penproject/src/Widgets/Homepage/Body/Pages/Diary/SubjectTile/Average.dart';
import 'package:penproject/src/Widgets/Homepage/Body/Pages/Diary/SubjectTile/Name.dart';

class DiarySubjectTile extends StatelessWidget {
  final String name, id;
  final double average;
  const DiarySubjectTile({this.name, this.average, this.id});

  @override
  Widget build(BuildContext context) {
    var _average = average;
    if (average > 5.00) {
      _average = 5;
    }
    Color color;
    switch (_average.round()) {
      case 1:
        color = Colors.redAccent;
        break;
      case 2:
        color = Colors.yellowAccent[700];
        break;
      case 3:
        color = Colors.amberAccent[400];
        break;
      case 4:
        color = Colors.green[400];
        break;
      case 5:
        color = Colors.greenAccent[700];
        break;
      default:
        color = Colors.black87;
    }
    return Padding(
        padding: EdgeInsets.fromLTRB(8.sp, 0.sp, 8.sp, 10.sp),
        child: Material(
            color: Colors.transparent,
            child: InkWell(
                onTap: () {
                  Get.toNamed("/DiaryPage/$id");
                },
                borderRadius: BorderRadius.circular(18.sp),
                child: Ink(
                  padding: EdgeInsets.all(15.sp),
                  decoration: BoxDecoration(
                      color: color, borderRadius: BorderRadius.circular(18.sp)),
                  child: Stack(
                    children: [
                      Align(
                        alignment: AlignmentDirectional.bottomStart,
                        child: DiarySubjectTileName(name ?? 'ERROR'),
                      ),
                      Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: DiarySubjectTileAverage(_average ?? 0.0),
                      ),
                    ],
                  ),
                ))));
  }
}
/*
Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          
          Expanded(
            child: 
          )
        ],
      ) */
