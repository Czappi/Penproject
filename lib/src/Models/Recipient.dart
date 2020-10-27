import 'package:equatable/equatable.dart';

class Recipient extends Equatable {
  final int id;
  final String studentId; // oktatasi azonosito
  final int kretaId;
  final String name;
  final RecipientCategory category;

  Recipient({
    this.id,
    this.studentId,
    this.name,
    this.kretaId,
    this.category,
  });

  factory Recipient.fromJson(Map json) {
    int id = json["azonosito"];
    int kretaId = json["kretaAzonosito"];
    String name = json["nev"];
    RecipientCategory category = RecipientCategory.fromJson(json["tipus"]);

    return Recipient(
      id: id,
      studentId: "",
      name: name,
      kretaId: kretaId,
      category: category,
    );
  }
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}

class RecipientCategory extends Equatable {
  final int id;
  final String code;
  final String shortName;
  final String name;
  final String description;

  RecipientCategory({
    this.id,
    this.code,
    this.shortName,
    this.name,
    this.description,
  });

  factory RecipientCategory.fromJson(Map json) {
    int id = json["azonosito"];
    String code = json["kod"];
    String shortName = json["rovidNev"];
    String name = json["nev"];
    String description = json["leiras"];

    return RecipientCategory(
      id: id,
      code: code,
      shortName: shortName,
      name: name,
      description: description,
    );
  }

  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}
