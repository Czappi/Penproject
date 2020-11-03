import 'dart:convert';
import 'dart:typed_data';

//import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:penproject/src/Database/UserDatabase.dart';
import 'package:penproject/src/Models/Absence.dart';
import 'package:penproject/src/Models/Attachment.dart';
import 'package:penproject/src/Models/Evaluation.dart';
import 'package:penproject/src/Models/Event.dart';
import 'package:penproject/src/Models/Exam.dart';
import 'package:penproject/src/Models/Homework.dart';
import 'package:penproject/src/Models/Lesson.dart';
import 'package:penproject/src/Models/Message.dart';
import 'package:penproject/src/Models/Note.dart';
import 'package:penproject/src/Models/Recipient.dart';
import 'package:penproject/src/Models/School.dart';
import 'package:penproject/src/Models/Student.dart';
import 'package:penproject/src/Models/Subject.dart';
import 'package:penproject/src/Models/User.dart';
import 'package:penproject/src/Utils/format.dart';
import 'package:penproject/src/Utils/generateUserId.dart';
import 'package:penproject/src/Utils/parseJwt.dart';
import 'package:penproject/src/Utils/Constants/Api.dart';

class ApiClient {
  var client = http.Client();
  final String clientId = "kreta-ellenorzo-mobile";
  final String userAgent = "hu.ekreta.student/1.0.5/Android/0/0";
  String accessToken;
  String refreshToken;
  String instituteCode;
  String userId;
  String name;

  void fillLoginData(User user) {
    instituteCode = user.instituteCode;
    userId = user.id;
  }

  Future<bool> refreshLogin(String userId) async {
    var user = await UserDatabase.db.getUserbyId(userId);
    if (user != null) {
      return await login(user);
    } else {
      return false;
    }
  }

  Future<bool> login(User user) async {
    try {
      var response = await client.post(
        BaseURL.KRETA_IDP + KretaEndpoints.token,
        body: {
          "userName": user.username,
          "password": user.password,
          "institute_code": user.instituteCode,
          "grant_type": "password",
          "client_id": clientId
        },
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "User-Agent": userAgent,
        },
      );

      Map responseJson = jsonDecode(response.body);
      if (responseJson["error"] == null) {
        accessToken = responseJson["access_token"];
        refreshToken = responseJson["refresh_token"];
        instituteCode = user.instituteCode;
        userId = generateUserId(user.username, user.instituteCode);
        name = parseJwt(accessToken)["name"];
        /*
        await UserDatabase.db.login(
            username: user.username,
            password: user.password,
            instituteCode: instituteCode,
            id: userId,
            name: name,
            status: true); */
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("ERROR: ApiClient.login: " + e.toString());
      return false;
    }
  }

  Future<List<Lesson>> getLessons(DateTime from, DateTime to) async {
    if (from == null || to == null) return [];

    try {
      var response = await client.get(
        BaseURL.kreta(instituteCode) +
            KretaEndpoints.timetable +
            "?datumTol=" +
            dateformat(DateFormatType.yyyymmdd, date: from) +
            "&datumIg=" +
            dateformat(DateFormatType.yyyymmdd, date: to),
        headers: {
          "Authorization": "Bearer $accessToken",
          "User-Agent": userAgent
        },
      );

      await checkResponse(response);

      //print(response.body);
      List responseJson = jsonDecode(response.body);
      List<Lesson> lessons = [];

      responseJson.forEach((lesson) => lessons.add(Lesson.fromJson(lesson)));

      return lessons;
    } catch (error) {
      print("ERROR: ApiClient.getLessons: " + error.toString());
      return <Lesson>[];
    }
  }

  Future<Student> getStudent() async {
    try {
      var response = await client.get(
        BaseURL.kreta(instituteCode) + KretaEndpoints.student,
        headers: {
          "Authorization": "Bearer $accessToken",
          "User-Agent": userAgent,
        },
      );

      await checkResponse(response);

      Map responseJson = jsonDecode(response.body);
      Student student = Student.fromJson(responseJson);

      return student;
    } catch (error) {
      print("ERROR: KretaAPI.getStudent: " + error.toString());
      return null;
    }
  }

  Future<List<Evaluation>> getEvaluations() async {
    try {
      var response = await client.get(
        BaseURL.kreta(instituteCode) + KretaEndpoints.evaluations,
        headers: {
          "Authorization": "Bearer $accessToken",
          "User-Agent": userAgent,
        },
      );

      await checkResponse(response);

      List responseJson = jsonDecode(response.body);
      List<Evaluation> evaluations = [];

      responseJson.forEach(
          (evaluation) => evaluations.add(Evaluation.fromJson(evaluation)));

      return evaluations;
    } catch (error) {
      print("ERROR: ApiClient.getEvaluations: " + error.toString());
      return null;
    }
  }

  Future<List<Absence>> getAbsences() async {
    try {
      var response = await client.get(
        BaseURL.kreta(instituteCode) + KretaEndpoints.absences,
        headers: {
          "Authorization": "Bearer $accessToken",
          "User-Agent": userAgent,
        },
      );

      await checkResponse(response);

      List responseJson = jsonDecode(response.body);
      List<Absence> absences = [];

      responseJson
          .forEach((absence) => absences.add(Absence.fromJson(absence)));

      return absences;
    } catch (error) {
      print("ERROR: KretaAPI.getAbsences: " + error.toString());
      return null;
    }
  }

  Future<String> getGroups() async {
    try {
      var response = await client.get(
        BaseURL.kreta(instituteCode) + KretaEndpoints.groups,
        headers: {
          "Authorization": "Bearer $accessToken",
          "User-Agent": userAgent
        },
      );

      await checkResponse(response);

      List responseJson = jsonDecode(response.body);
      String uid = responseJson[0]["OktatasNevelesiFeladat"]["Uid"];

      return uid;
    } catch (error) {
      print("ERROR: KretaAPI.getGroups: " + error.toString());
      return null;
    }
  }

  Future<List> getAverages(String groupId) async {
    try {
      var response = await client.get(
        BaseURL.kreta(instituteCode) +
            KretaEndpoints.classAverages +
            "?oktatasiNevelesiFeladatUid=" +
            groupId,
        headers: {
          "Authorization": "Bearer $accessToken",
          "User-Agent": userAgent
        },
      );

      await checkResponse(response);

      List responseJson = jsonDecode(response.body);
      List averages = [];

      responseJson.forEach((average) {
        averages.add([
          Subject.fromJson(average["Tantargy"]),
          average["OsztalyCsoportAtlag"]
        ]);
      });

      return averages;
    } catch (error) {
      print("ERROR: KretaAPI.getAverages: " + error.toString());
      return null;
    }
  }

  Future<List<Note>> getNotes() async {
    try {
      var response = await client.get(
        BaseURL.kreta(instituteCode) + KretaEndpoints.notes,
        headers: {
          "Authorization": "Bearer $accessToken",
          "User-Agent": userAgent,
        },
      );

      await checkResponse(response);

      List<Note> notes = [];

      List responseJson = jsonDecode(response.body);
      responseJson.forEach((json) => notes.add(Note.fromJson(json)));

      return notes;
    } catch (error) {
      print("ERROR: KretaAPI.getNotes: " + error.toString());
      return null;
    }
  }

  Future<List<Event>> getEvents() async {
    try {
      var response = await client.get(
        BaseURL.kreta(instituteCode) + KretaEndpoints.events,
        headers: {
          "Authorization": "Bearer $accessToken",
          "User-Agent": userAgent,
        },
      );
      await checkResponse(response);

      List<Event> events = [];

      List responseJson = jsonDecode(response.body);
      responseJson.forEach((json) => events.add(Event.fromJson(json)));

      return events;
    } catch (error) {
      print("ERROR: KretaAPI.getEvents " + error.toString());
      return null;
    }
  }

  Future<List<Exam>> getExams() async {
    try {
      var response = await client.get(
        BaseURL.kreta(instituteCode) + KretaEndpoints.exams,
        headers: {
          "Authorization": "Bearer $accessToken",
          "User-Agent": userAgent
        },
      );

      await checkResponse(response);

      List responseJson = jsonDecode(response.body);
      List<Exam> exams = [];

      responseJson.forEach((exam) => exams.add(Exam.fromJson(exam)));

      return exams;
    } catch (error) {
      print("ERROR: KretaAPI.getExams: " + error.toString());
      return null;
    }
  }

  Future<List<Homework>> getHomeworks(DateTime from) async {
    try {
      var response = await client.get(
        BaseURL.kreta(instituteCode) +
            KretaEndpoints.homeworks +
            "?datumTol=" +
            from.toUtc().toIso8601String(),
        headers: {
          "Authorization": "Bearer $accessToken",
          "User-Agent": userAgent
        },
      );

      await checkResponse(response);

      List responseJson = jsonDecode(response.body);
      List<Homework> homeworks = [];

      responseJson
          .forEach((homework) => homeworks.add(Homework.fromJson(homework)));

      return homeworks;
    } catch (error) {
      print("ERROR: KretaAPI.getHomeworks: " + error.toString());
      return null;
    }
  }

  Future homeworkSolved(Homework homework, bool state) async {
    try {
      var response = await client.post(
        BaseURL.kreta(instituteCode) + KretaEndpoints.homeworkDone,
        body: '[{"IsMegoldva":$state,"TanarHaziFeladatUid":"${homework.id}"}]',
        headers: {
          "Authorization": "Bearer $accessToken",
          "User-Agent": userAgent,
          "Content-Type": "application/json"
        },
      );

      await checkResponse(response);
    } catch (error) {
      print("ERROR: KretaAPI.homeworkSolved: " + error.toString());
    }
  }

  Future<List<School>> getSchools() async {
    try {
      var response = await http.get(
        Filc.schoolList,
        headers: {"Content-Type": "application/json"},
      );

      checkResponse(response);

      List responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      List<School> schools = [];

      responseJson.forEach((school) => schools.add(School(
          id: school["instituteCode"] ?? "-",
          name: school["name"] ?? "-",
          city: school["city"] ?? "-")));

      return schools;
    } catch (error) {
      print("ERROR: KretaAPI.getSchools: " + error.toString());
      return [];
    }
  }

  Future<List<Message>> getMessages(String type) async {
    try {
      var response = await client.get(
        BaseURL.KRETA_ADMIN + AdminEndpoints.messages(type),
        headers: {
          "Authorization": "Bearer $accessToken",
          "User-Agent": userAgent,
        },
      );

      await checkResponse(response);

      List responseJson = jsonDecode(response.body);
      List<Message> messages = [];

      await Future.forEach(responseJson, (message) async {
        Map msg = await getMessage(message["azonosito"]);
        if (msg != null) messages.add(Message.fromJson(msg));
      });

      return messages;
    } catch (error) {
      print("ERROR: KretaAPI.getMessage: " + error.toString());
      return null;
    }
  }

  Future<Map> getMessage(int id) async {
    try {
      var response = await client.get(
        BaseURL.KRETA_ADMIN + AdminEndpoints.message(id.toString()),
        headers: {
          "Authorization": "Bearer $accessToken",
          "User-Agent": userAgent,
        },
      );

      await checkResponse(response);

      Map responseJson = jsonDecode(response.body);

      return responseJson;
    } catch (error) {
      print("ERROR: KretaAPI.getMessage: " + error.toString());
      return null;
    }
  }

  Future<List<Recipient>> getRecipients() async {
    try {
      var response = await client.get(
        BaseURL.KRETA_ADMIN + AdminEndpoints.recipientsTeacher,
        headers: {
          "Authorization": "Bearer $accessToken",
          "User-Agent": userAgent
        },
      );

      await checkResponse(response);

      List responseJson = jsonDecode(response.body);
      List<Recipient> recipients = [];

      responseJson.forEach((recipient) => recipients.add(Recipient(
          id: 0,
          studentId: recipient["oktatasiAzonosito"],
          name: recipient["nev"] ?? "",
          kretaId: recipient["kretaAzonosito"],
          category: RecipientCategory(
              id: 9,
              code: "TANAR",
              shortName: "Tanár",
              name: "Tanár",
              description: "Tanár"))));

      return recipients;
    } catch (error) {
      print("ERROR: KretaAPI.getRecipients: " + error.toString());
      return null;
    }
  }

  Future<bool> sendMessage({
    List<Recipient> recipients,
    Message message,
  }) async {
    try {
      List recipientsJson = [];
      List attachmentsJson = [];

      recipients.where((r) => r.id != null).forEach((recipient) {
        recipientsJson.add({
          "azonosito": recipient.id,
          "kretaAzonosito": recipient.kretaId,
          "nev": recipient.name,
          "tipus": {
            "azonosito": recipient.category.id,
            "kod": recipient.category.code,
            "rovidNev": recipient.category.shortName,
            "nev": recipient.category.name,
            "leiras": recipient.category.description,
          },
        });
      });
      /*
      List<Attachment> attachments = [];

      for (int i = 0; i < messageContext.attachments.length; i++) {
        //messageContext.attachments[i].id = i;
        Attachment attachment =
            await uploadAttachment(messageContext.attachments[i]);
        if (attachment == null) throw "Failed to upload attachment";
        attachments.add(attachment);
      }

      attachments
          .where((a) => a.fileId != null && a.kretaFilePath != null)
          .forEach((attachment) {
        attachmentsJson.add({
          "fajlNev": attachment.name,
          "azonosito": 0,
          "fajl": {
            "fileHandler": "FileService",
            "utvonal": attachment.kretaFilePath,
            "ideiglenesFajlAzonosito": attachment.fileId,
          },
        });
      });

      print(attachmentsJson);
      */
      Map messageJson = {
        "cimzettLista": recipientsJson,
        "csatolmanyok": attachmentsJson,
        "targy": message.subject,
        "szoveg": message.content,
      };

      if (message.replyId != null)
        messageJson["elozoUzenetAzonosito"] = message.replyId;

      messageJson["kuldesDatum"] =
          DateTime.now().toUtc().toIso8601String().split(".")[0] + "Z";
      messageJson["azonosito"] = 0;
      messageJson["feladoTitulus"] = "";

      var response = await client.post(
        BaseURL.KRETA_ADMIN + AdminEndpoints.sendMessage,
        headers: {
          "Authorization": "Bearer $accessToken",
          "User-Agent": userAgent,
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: jsonEncode(messageJson),
      );

      await checkResponse(response);

      return true;
    } catch (error) {
      print("ERROR: KretaAPI.sendMessage: " + error.toString());
      return false;
    }
  }
  /*
  Future<Attachment> uploadAttachment(Attachment attachment) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(BaseURL.KRETA_FILES + AdminEndpoints.uploadAttachment),
      );
      request.headers["Authorization"] = "Bearer $accessToken";
      request.headers["User-Agent"] = userAgent;
      request.files
          .add(await http.MultipartFile.fromPath('fajl', attachment.file.path));
      var response = await request.send();

      checkResponse(response);

      Map responseJson = jsonDecode(await response.stream.bytesToString());

      attachment.fileId = responseJson["fajlAzonosito"];
      attachment.kretaFilePath = responseJson["utvonal"];

      return attachment;
    } catch (error) {
      print("ERROR: KretaAPI.uploadAttachment: " + error.toString());
      return null;
    }
  }
  */

  Future<Uint8List> downloadAttachment(Attachment attachment) async {
    try {
      var response = await client.get(
        BaseURL.KRETA_ADMIN +
            AdminEndpoints.downloadAttachment(attachment.id.toString()),
        headers: {
          "Authorization": "Bearer $accessToken",
          "User-Agent": userAgent,
        },
      );

      await checkResponse(response);

      return response.bodyBytes;
    } catch (error) {
      print("ERROR: KretaAPI.downloadAttachment: " + error.toString());
      return null;
    }
  }

  Future checkResponse(response, {bool retry = true}) async {
    if (instituteCode != null) {
      if (accessToken == null)
        print("WARNING: accessToken is null. How did this happen?");
      if (refreshToken == null)
        print("WARNING: refreshToken is null. How did this happen?");
    }

    if (response.statusCode == 401) {
      if (retry == true && userId != null)
        await refreshLogin(userId);
      else
        throw "Authorization failed";
    }

    if (response.statusCode == 500) print(response.body);

    if (response.statusCode != 200 && response.statusCode != 204)
      throw "Invalid response: " + response.statusCode.toString();
  }
}
