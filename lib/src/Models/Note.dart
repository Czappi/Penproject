import 'package:equatable/equatable.dart';
import 'package:penproject/src/Models/Data.dart';

class Note extends Equatable {
  final String id;
  final String title;
  final DateTime date;
  final DateTime createDate;
  final String teacher;
  final DateTime seenDate;
  final String groupId;
  final String content;
  final Data type;

  Note({
    this.id,
    this.title,
    this.date,
    this.createDate,
    this.teacher,
    this.seenDate,
    this.groupId,
    this.content,
    this.type,
  });

  factory Note.fromJson(Map json) {
    String id = json["Uid"];
    String title = json["Cim"] ?? "";
    DateTime date =
        json["Datum"] != null ? DateTime.parse(json["Datum"]).toLocal() : null;
    DateTime createDate = json["KeszitesDatuma"] != null
        ? DateTime.parse(json["KeszitesDatuma"]).toLocal()
        : null;
    String teacher = json["KeszitoTanarNeve"] ?? "";
    DateTime seenDate = json["LattamozasDatuma"] != null
        ? DateTime.parse(json["LattamozasDatuma"]).toLocal()
        : null;
    String groupId = json["OsztalyCsoport"] != null
        ? json["OsztalyCsoport"]["Uid"] ?? ""
        : "";
    String content = json["Tartalom"].replaceAll("\r", "") ?? "";
    Data type = json["Tipus"] != null ? Data.fromJson(json["Tipus"]) : null;

    return Note(
      id: id,
      title: title,
      date: date,
      createDate: createDate,
      teacher: teacher,
      seenDate: seenDate,
      groupId: groupId,
      content: content,
      type: type,
    );
  }

  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}
