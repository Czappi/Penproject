import 'package:equatable/equatable.dart';
import 'package:penproject/src/Models/Data.dart';

class Exam extends Equatable {
  final DateTime date;
  final DateTime writeDate;
  final Data mode;
  final int subjectIndex;
  final String subjectName;
  final String teacher;
  final String description;
  final String group;
  final String id;

  Exam(
      {this.date,
      this.writeDate,
      this.mode,
      this.subjectIndex,
      this.subjectName,
      this.teacher,
      this.description,
      this.group,
      this.id});

  factory Exam.fromJson(Map json) {
    DateTime date = json["BejelentesDatuma"] != null
        ? DateTime.parse(json["BejelentesDatuma"]).toLocal()
        : null;
    DateTime writeDate =
        json["Datum"] != null ? DateTime.parse(json["Datum"]).toLocal() : null;
    Data mode = json["Modja"] != null ? Data.fromJson(json["Modja"]) : null;
    int subjectIndex = json["OrarendiOraOraszama"];
    String subjectName = json["TantargyNeve"] ?? "";
    String teacher = json["RogzitoTanarNeve"] ?? "";
    String description = (json["Temaja"] ?? "").trim();
    String group =
        json["OsztalyCsoport"] != null ? json["OsztalyCsoport"]["Uid"] : null;
    String id = json["Uid"];

    return Exam(
        date: date,
        writeDate: writeDate,
        mode: mode,
        subjectIndex: subjectIndex,
        subjectName: subjectName,
        teacher: teacher,
        description: description,
        group: group,
        id: id);
  }

  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}
