import 'package:equatable/equatable.dart';

class Homework extends Equatable {
  final DateTime date;
  final DateTime lessonDate;
  final DateTime deadline;
  final bool byTeacher;
  final bool homeworkEnabled;
  final bool isSolved;
  final String teacher;
  final String content;
  final String subjectName;
  final String group;
  final List attachments;
  final String id;

  Homework({
    this.date,
    this.lessonDate,
    this.deadline,
    this.byTeacher,
    this.homeworkEnabled,
    this.teacher,
    this.content,
    this.subjectName,
    this.group,
    this.attachments,
    this.id,
    this.isSolved,
  });

  factory Homework.fromJson(Map json) {
    DateTime date = json["RogzitesIdopontja"] != null
        ? DateTime.parse(json["RogzitesIdopontja"]).toLocal()
        : null;
    DateTime lessonDate = json["FeladasDatuma"] != null
        ? DateTime.parse(json["FeladasDatuma"]).toLocal()
        : null;
    DateTime deadline = json["HataridoDatuma"] != null
        ? DateTime.parse(json["HataridoDatuma"]).toLocal()
        : null;
    bool byTeacher = json["IsTanarRogzitette"] ?? true;
    bool homeworkEnabled = json["IsTanuloHaziFeladatEnabled"] ?? false;
    String teacher = json["RogzitoTanarNeve"] ?? "";
    String content = (json["Szoveg"] ?? "").trim();
    String subjectName = json["TantargyNeve"] ?? "";
    String group =
        json["OsztalyCsoport"] != null ? json["OsztalyCsoport"]["Uid"] : null;
    List attachments = json["Csatolmanyok"];
    String id = json["Uid"];
    bool isSolved = json["IsMegoldva"] ?? false;

    return Homework(
        date: date,
        lessonDate: lessonDate,
        deadline: deadline,
        byTeacher: byTeacher,
        homeworkEnabled: homeworkEnabled,
        teacher: teacher,
        content: content,
        subjectName: subjectName,
        group: group,
        attachments: attachments,
        id: id,
        isSolved: isSolved);
  }

  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}
