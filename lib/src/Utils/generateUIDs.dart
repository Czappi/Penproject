import 'package:crypto/crypto.dart';
import 'dart:convert';

String generateUserId(String username, String instituteCode) =>
    md5.convert(utf8.encode(username + instituteCode)).toString();

String generateLessonUID(String id, DateTime start) =>
    md5.convert(utf8.encode(id + start.toIso8601String())).toString();

String encryptName(String name) => base64.encode(utf8.encode(name)).toString();

String decryptName(String encryptedName) =>
    utf8.decode(base64.decode(encryptedName)).toString();
