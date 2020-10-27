import 'package:equatable/equatable.dart';
import 'package:penproject/src/Models/Data.dart';
import 'package:penproject/src/Models/Subject.dart';
import 'package:penproject/src/Utils/generateUserId.dart';
import 'package:supercharged/supercharged.dart';

class Lesson extends Equatable {
  const Lesson(
      {this.uid,
      this.id,
      this.status,
      this.type,
      this.lessonIndex,
      this.lessonYearIndex,
      this.teacher,
      this.substituteTeacher,
      this.date,
      this.start,
      this.end,
      this.description,
      this.room,
      this.groupName,
      this.name,
      this.subject});

  final String uid;
  final String id;

  final Data status;
  final Data type;

  final int lessonIndex;
  final int lessonYearIndex;

  final String teacher;
  final String substituteTeacher;

  final DateTime date;
  final DateTime start;
  final DateTime end;

  final String description;
  final String room;

  final String groupName;
  final String name;

  final Subject subject;

  @override
  List<Object> get props => [
        uid,
        id.toString() ?? "null",
        status.props,
        type.props,
        lessonIndex,
        lessonYearIndex,
        teacher,
        substituteTeacher,
        date,
        start,
        end,
        description,
        room,
        groupName,
        name,
        subject.props
      ];

  @override
  bool get stringify => false;

  factory Lesson.fromJson(Map json) {
    Data status =
        json["Allapot"] != null ? Data.fromJson(json["Allapot"]) : null;
    DateTime date =
        json["Datum"] != null ? DateTime.parse(json["Datum"]).toLocal() : null;
    Subject subject =
        json["Tantargy"] != null ? Subject.fromJson(json["Tantargy"]) : null;
    int lessonIndex = json["Oraszam"] ?? 0;
    int lessonYearIndex = json["OraEvesSorszama"];
    String substituteTeacher = json["HelyettesTanarNeve"] ?? "";
    String teacher = json["TanarNeve"] ?? "";
    //bool homeworkEnabled = json["IsTanuloHaziFeladatEnabled"] ?? false;
    DateTime start = json["KezdetIdopont"] != null
        ? DateTime.parse(json["KezdetIdopont"]).toLocal()
        : null;
    DateTime end = json["VegIdopont"] != null
        ? DateTime.parse(json["VegIdopont"]).toLocal()
        : null;
    //Data studentPresence;
    //String homeworkId = json["HaziFeladatUid"];
    //List tests = json["BejelentettSzamonkeresUids"] != null ? json["BejelentettSzamonkeresUids"] : [];
    String id = json["Uid"] ?? "null";
    Data type = json["Tipus"] != null ? Data.fromJson(json["Tipus"]) : null;
    String description = json["Tema"] ?? "";
    String room = json["TeremNeve"] ?? "";
    String groupName =
        json["OsztalyCsoport"] != null ? json["OsztalyCsoport"]["Nev"] : null;
    String name = json["Nev"] ?? "";
    String uid = generateLessonUID(
        (id.allBefore(',') != '') ? id.allBefore(',') : id, start);

    return Lesson(
        uid: uid,
        id: id,
        status: status,
        type: type,
        lessonIndex: lessonIndex,
        lessonYearIndex: lessonYearIndex,
        teacher: teacher,
        substituteTeacher: substituteTeacher,
        date: date,
        start: start,
        end: end,
        description: description,
        room: room,
        groupName: groupName,
        name: name,
        subject: subject);
  }
}
