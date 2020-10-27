import 'package:equatable/equatable.dart';

class School extends Equatable {
  final String id;
  final String name;
  final String city;

  School({this.id, this.city, this.name});

  factory School.fromJson(Map json) {
    String id = json["id"];
    String city = json["city"];
    String name = json["name"];

    return School(id: id, city: city, name: name);
  }

  Map toJson() {
    return {"id": id, "city": city, "name": name};
  }

  @override
  List<Object> get props => [id, city, name];

  @override
  bool get stringify => false;
}
