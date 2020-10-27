import 'package:equatable/equatable.dart';
import 'package:penproject/src/Models/Data.dart';
import 'package:penproject/src/Models/Subject.dart';

class Evaluation extends Equatable {
  final String id;
  final EvaluationValue value;
  final DateTime date;
  final String teacher;
  final String description;
  final Data type;
  final String groupId;
  final Subject subject;
  final Data evaluationType;
  final Data mode;
  final DateTime writeDate;
  final DateTime seenDate;
  final String form;

  Evaluation(
      {this.id,
      this.value,
      this.date,
      this.teacher,
      this.description,
      this.type,
      this.groupId,
      this.subject,
      this.evaluationType,
      this.mode,
      this.writeDate,
      this.seenDate,
      this.form});

  factory Evaluation.fromJson(Map json) {
    String id = json["Uid"];
    DateTime date = json["RogzitesDatuma"] != null
        ? DateTime.parse(json["RogzitesDatuma"]).toLocal()
        : null;
    EvaluationValue value = EvaluationValue(
      json["SzamErtek"] ?? 0,
      json["SzovegesErtek"] ?? "",
      json["SzovegesErtekRovidNev"] ?? "",
      json["SulySzazalekErteke"] ?? 0,
    );
    String teacher = json["ErtekeloTanarNeve"] ?? "";
    String description = json["Tema"] ?? "";
    Data type = json["Tipus"] != null ? Data.fromJson(json["Tipus"]) : null;
    String groupId = json["OsztalyCsoport"]["Uid"] ?? "";
    Subject subject =
        json["Tantargy"] != null ? Subject.fromJson(json["Tantargy"]) : null;
    Data evaluationType =
        json["ErtekFajta"] != null ? Data.fromJson(json["ErtekFajta"]) : null;
    Data mode = json["Mod"] != null ? Data.fromJson(json["Mod"]) : null;
    DateTime writeDate = json["KeszitesDatuma"] != null
        ? DateTime.parse(json["KeszitesDatuma"]).toLocal()
        : null;
    DateTime seenDate = json["LattamozasDatuma"] != null
        ? DateTime.parse(json["LattamozasDatuma"]).toLocal()
        : null;
    String form = json["Jelleg"] ?? "";

    return Evaluation(
        date: date,
        id: id,
        value: value,
        teacher: teacher,
        description: description,
        type: type,
        groupId: groupId,
        subject: subject,
        evaluationType: evaluationType,
        mode: mode,
        writeDate: writeDate,
        seenDate: seenDate,
        form: form);
  }

  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}

class EvaluationValue extends Equatable {
  final int value;
  final String valueName;
  final String shortName;
  final int weight;

  EvaluationValue(this.value, this.valueName, this.shortName, this.weight);

  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}
