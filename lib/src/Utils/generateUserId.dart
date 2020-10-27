import 'package:crypto/crypto.dart';
import 'dart:convert';

String generateUserId(String username, String instituteCode) =>
    md5.convert(utf8.encode(username + instituteCode)).toString();

String generateLessonUID(String id, DateTime start) =>
    md5.convert(utf8.encode(id + start.toIso8601String())).toString();
