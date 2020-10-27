import 'package:equatable/equatable.dart';

class Data extends Equatable {
  final String id;
  final String description;
  final String name;

  Data(this.id, this.description, this.name);

  factory Data.fromJson(Map json) {
    String id;
    String description;
    String name;
    if (json.containsKey("Uid")) {
      id = json["Uid"] ?? "";
      description = json["Leiras"] ?? "";
      name = json["Nev"] ?? "";
    } else {
      id = json["id"] ?? "";
      description = json["description"] ?? "";
      name = json["name"] ?? "";
    }

    return Data(id, description, name);
  }

  Map toJson() {
    return {"id": id, "description": description, "name": name};
  }

  @override
  List<Object> get props => [id, description, name];

  @override
  bool get stringify => false;
}
