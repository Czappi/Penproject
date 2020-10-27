import 'package:equatable/equatable.dart';
import 'package:penproject/src/Models/Data.dart';
import 'package:penproject/src/Models/Subject.dart';

class Absence extends Equatable {
  final String id;
  final DateTime date;
  final int delay;
  final DateTime submitDate;
  final String teacher;
  final String state;
  final Data justification;
  final Data type;
  final Data mode;
  final Subject subject;
  final DateTime lessonStart;
  final DateTime lessonEnd;
  final int lessonIndex;
  final String group;

  Absence(
      {this.id,
      this.date,
      this.delay,
      this.submitDate,
      this.teacher,
      this.state,
      this.justification,
      this.type,
      this.mode,
      this.subject,
      this.lessonStart,
      this.lessonEnd,
      this.lessonIndex,
      this.group});

  factory Absence.fromJson(Map json) {
    String id = json["Uid"];
    DateTime date =
        json["Datum"] != null ? DateTime.parse(json["Datum"]).toLocal() : null;
    int delay = json["KesesPercben"] ?? 0;
    DateTime submitDate = json["KeszitesDatuma"] != null
        ? DateTime.parse(json["KeszitesDatuma"]).toLocal()
        : null;
    String teacher = json["RogzitoTanarNeve"] ?? "";
    String state = json["IgazolasAllapota"] ?? "";
    Data justification = json["IgazolasTipusa"] != null
        ? Data.fromJson(json["IgazolasTipusa"])
        : null;
    Data type = json["Tipus"] != null ? Data.fromJson(json["Tipus"]) : null;
    Data mode = json["Mod"] != null ? Data.fromJson(json["Mod"]) : null;
    Subject subject =
        json["Tantargy"] != null ? Subject.fromJson(json["Tantargy"]) : null;

    DateTime lessonStart;
    DateTime lessonEnd;
    int lessonIndex;
    if (json["Ora"] != null) {
      lessonStart = json["Ora"]["KezdoDatum"] != null
          ? DateTime.parse(json["Ora"]["KezdoDatum"]).toLocal()
          : null;
      lessonEnd = json["Ora"]["VegDatum"] != null
          ? DateTime.parse(json["Ora"]["VegDatum"]).toLocal()
          : null;
      lessonIndex = json["Ora"]["Oraszam"] ?? 0;
    }

    String group =
        json["OsztalyCsoport"] != null ? json["OsztalyCsoport"]["Uid"] : null;

    return Absence(
      id: id,
      date: date,
      delay: delay,
      submitDate: submitDate,
      teacher: teacher,
      state: state,
      justification: justification,
      type: type,
      mode: mode,
      subject: subject,
      lessonStart: lessonStart,
      lessonEnd: lessonEnd,
      lessonIndex: lessonIndex,
      group: group,
    );
  }

  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}
