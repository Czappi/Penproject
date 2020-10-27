import 'package:equatable/equatable.dart';
import 'package:penproject/src/Models/Data.dart';

class Subject extends Equatable {
  final String id;
  final Data category;
  final String name;
  final String nickname;

  Subject({this.id, this.category, this.name, this.nickname});

  factory Subject.fromJson(Map json) {
    String id;
    Data category;
    String name;
    if (json.containsKey("Uid")) {
      id = json["Uid"] ?? "";
      category = Data.fromJson(json["Kategoria"]);
      name = json["Nev"];
    } else {
      id = json["id"] ?? "";
      category = Data.fromJson(json["category"]);
      name = json["name"] ?? "";
    }

    return Subject(id: id, category: category, name: name, nickname: name);
  }

  Map toJson() {
    return {
      "id": id,
      "category": category.toJson(),
      "name": name,
      "nickname": nickname
    };
  }

  @override
  List<Object> get props => [id, category.props, name, nickname];

  @override
  bool get stringify => false;
}
