import 'package:equatable/equatable.dart';

class Event extends Equatable {
  final String id;
  final String title;
  final DateTime start;
  final DateTime end;
  final String content;

  Event({
    this.id,
    this.title,
    this.start,
    this.end,
    this.content,
  });

  factory Event.fromJson(Map json) {
    String id = json["Uid"] ?? "";
    DateTime start = json["ErvenyessegKezdete"] != null
        ? DateTime.parse(json["ErvenyessegKezdete"]).toLocal()
        : null;
    DateTime end = json["ErvenyessegVege"] != null
        ? DateTime.parse(json["ErvenyessegVege"]).toLocal()
        : null;
    String title = json["Cim"] ?? "";
    String content =
        json["Tartalom"] != null ? json["Tartalom"].replaceAll("\r", "") : "";

    return Event(
      id: id,
      title: title,
      start: start,
      end: end,
      content: content,
    );
  }

  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}
