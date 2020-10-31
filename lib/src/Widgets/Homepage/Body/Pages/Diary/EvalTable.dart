import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:penproject/src/Widgets/Homepage/Body/Pages/Diary/EvalTable/Columns.dart';

class EvalTable extends StatelessWidget {
  final bool printSubject;
  final List<DataRow> dataRows;
  const EvalTable({@required this.printSubject, @required this.dataRows});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.sp),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(18.sp),
          ),
          color: Get.theme.cardColor, //Color(0xff232d37)
        ),
        child: DataTable(
          columns: evalTableColumns(printSubject),
          rows: dataRows,
        ),
      ),
    );
  }
}
