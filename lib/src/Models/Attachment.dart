import 'dart:io';

import 'package:equatable/equatable.dart';

class Attachment extends Equatable {
  final int id;
  final File file;
  final String name;
  final String fileId;
  final String kretaFilePath;

  Attachment({
    this.id,
    this.file,
    this.name,
    this.fileId,
    this.kretaFilePath,
  });

  factory Attachment.fromJson(Map json) {
    int id = json["azonosito"];
    File file;
    String name = json["fajlNev"];
    String fileId;
    String kretaFilePath = json["utvonal"] ?? "";

    return Attachment(
      id: id,
      file: file,
      name: name,
      fileId: fileId,
      kretaFilePath: kretaFilePath,
    );
  }
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}
