import 'package:equatable/equatable.dart';
import 'package:penproject/src/Models/School.dart';
import 'package:penproject/src/Utils/format.dart';

class Student extends Equatable {
  final String id;
  final String name;
  final List<String> parents;

  final School school;
  final DateTime birth;

  final String yearId;
  final String address;
  final String groupId;

  Student(
      {this.id,
      this.name,
      this.parents,
      this.school,
      this.birth,
      this.yearId,
      this.address,
      this.groupId});

  factory Student.fromJson(Map json) {
    String name = json["Nev"] ?? json["SzuletesiNev"] ?? "";
    School school = School(
      id: json["IntezmenyAzonosito"] ?? "",
      name: json["IntezmenyNev"] ?? "",
      city: "",
    );
    String id = json["Uid"];
    DateTime birth = json["SzuletesiDatum"] != null
        ? DateTime.parse(json["SzuletesiDatum"]).toLocal()
        : null;
    String yearId = json["TanevUid"] ?? "";
    String address = json["Cimek"] != null
        ? json["Cimek"].length > 0 ? json["Cimek"][0] : null
        : null;
    List<String> parents = [];

    if (json["AnyjaNeve"] != null) {
      [
        [capitalize(json["AnyjaNeve"])],
        json["Gondviselok"]
            .map((e) => capitalize(e["Nev"]))
            .toList()
            .where((name) => !name.contains(json["AnyjaNeve"]))
      ].expand((x) => x).forEach((e) => parents.add(e));
    }

    return Student(
      id: id,
      name: name,
      school: school,
      birth: birth,
      yearId: yearId,
      address: address,
      parents: parents,
    );
  }

  @override
  List<Object> get props => [id, name, school, birth, yearId, address, parents];

  @override
  bool get stringify => false;
}
