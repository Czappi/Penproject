import 'package:flutter/material.dart';
import 'package:penproject/src/Database/Database.dart';
import 'package:penproject/src/Database/Extensions.dart';
import 'package:penproject/src/Models/Evaluation.dart';
import 'package:penproject/src/Utils/Converters.dart';
import 'package:penproject/src/Widgets/Homepage/Body/Pages/Diary/EvalTable/EvalTile.dart';
import 'package:penproject/src/Widgets/Homepage/Body/Pages/Diary/EvalTable/SubjectTile.dart';

Future<List<DataRow>> evalTableRows(DatabaseProvider db,
    {List<Evaluation> evals, bool printSubject}) async {
  List<DataRow> rows = [];

  // group by subject
  while (evals.isNotEmpty) {
    List<DataCell> cells = [];

    var group = evals
        .where((element) => element.subject.id == evals.first.subject.id)
        .toList();

    if (printSubject) {
      var subject = await db.getSubjectbyId(group.first.subject.id);

      if (subject != null) {
        cells.add(DataCell(SubjectTile(
          value: subject.name,
          id: subject.id,
        )));
      } else {
        cells.add(DataCell(SubjectTile(
          value: "null",
          id: null,
        )));
      }
    }

    for (var i = 1; i <= 10; i++) {
      var items = group
          .where((element) => convertMonth(element.date.month) == i)
          .toList();
      if (items.isNotEmpty) {
        List<EvalTile> tiles = [];
        items.forEach((element) {
          var value = element.value.value;
          tiles.add(EvalTile(
            value: (value != null) ? value.toString() : "-",
          ));
        });

        cells.add(DataCell(Row(
          children: tiles,
        )));
      } else {
        cells.add(DataCell(SizedBox()));
      }
    }

    evals.toSet().removeAll(group.toSet());
    evals.toList();
    rows.add(DataRow(cells: cells));
  }

  return rows;
}
