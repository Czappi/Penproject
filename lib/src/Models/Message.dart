import 'package:equatable/equatable.dart';
import 'package:penproject/src/Models/Attachment.dart';
import 'package:penproject/src/Models/Recipient.dart';

class Message extends Equatable {
  final int id;
  final int replyId;
  final int messageId;
  final int conversationId;
  final bool seen;
  final bool deleted;
  final DateTime date;
  final String sender;
  final String content;
  final String subject;
  final List<Recipient> recipients;
  final List<Attachment> attachments;

  Message({
    this.id,
    this.messageId,
    this.seen,
    this.deleted,
    this.date,
    this.sender,
    this.content,
    this.subject,
    this.recipients,
    this.attachments,
    this.replyId,
    this.conversationId,
  });

  factory Message.fromJson(Map json) {
    Map message = json["uzenet"];

    int id = message["azonosito"] ?? 0;
    int messageId = message["azonosito"];
    int replyId = message["elozoUzenetAzonosito"];
    int conversationId = message["beszelgetesAzonosito"];
    bool seen = json["isElolvasva"] ?? false;
    bool deleted = json["isToroltElem"] ?? false;
    DateTime date = message["kuldesDatum"] != null
        ? DateTime.parse(message["kuldesDatum"]).toLocal()
        : null;
    String sender = message["feladoNev"] ?? "";
    String content = message["szoveg"].replaceAll("\r", "") ?? "";
    String subject = message["targy"] ?? "";

    List<Recipient> recipients = [];
    List<Attachment> attachments = [];

    message["cimzettLista"].forEach((recipient) {
      recipients.add(Recipient.fromJson(recipient));
    });

    message["csatolmanyok"].forEach((attachment) {
      attachments.add(Attachment.fromJson(attachment));
    });

    return Message(
      id: id,
      messageId: messageId,
      seen: seen,
      deleted: deleted,
      date: date,
      sender: sender,
      content: content,
      subject: subject,
      recipients: recipients,
      attachments: attachments,
      replyId: replyId,
      conversationId: conversationId,
    );
  }
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}
