import 'package:flutter/material.dart';
import 'package:penproject/src/Widgets/CardFoundation.dart';
import 'package:penproject/src/Widgets/Homepage/Body/Pages/Diary/EvalTable/Columns.dart';

class EvalTable extends StatelessWidget {
  final bool printSubject;
  final List<DataRow> dataRows;
  const EvalTable({@required this.printSubject, @required this.dataRows});

  @override
  Widget build(BuildContext context) {
    return CardFoundation(
      child: SizedBox(
          child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: ScrollController(),
        child: DataTable(
          //showBottomBorder: true,
          columns: evalTableColumns(printSubject),
          rows: dataRows,
        ),
      )),
    );
  }
}
