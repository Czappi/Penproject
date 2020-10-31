import 'package:penproject/src/Database/Database.dart';
import 'SubjectExt.dart';
import 'package:penproject/src/Models/Absence.dart';
import 'package:penproject/src/Models/Data.dart';
import 'package:penproject/src/Models/Evaluation.dart';
import 'package:penproject/src/Models/Event.dart';
import 'package:penproject/src/Models/Exam.dart';
import 'package:penproject/src/Models/Homework.dart';
import 'package:penproject/src/Models/Lesson.dart';
import 'package:penproject/src/Models/Note.dart';
import 'package:penproject/src/Models/School.dart';
import 'package:penproject/src/Models/Student.dart';
import 'package:penproject/src/Models/Subject.dart';

import 'package:penproject/src/Utils/StringExt.dart';

extension ParseExt on DatabaseProvider {
  Student getStudentData(Map map) => (map != null)
      ? Student(
          id: map["id"],
          name: map["name"],
          parents: map["parents"].toString().toList(),
          school: School(
              city: map["schoolCity"],
              id: map["schoolId"],
              name: map["schoolName"]),
          birth: DateTime.parse(map["birth"]),
          yearId: map["yearId"],
          address: map["address"],
          groupId: map["groupId"],
        )
      : null;

  /// Async because the Subject object
  Future<Lesson> getLessonDataAsync(Map map) async => (map != null)
      ? Lesson(
          id: map["id"],
          status: Data(
              map["statusId"], map["statusDescription"], map["statusName"]),
          lessonIndex: map["lessonIndex"],
          lessonYearIndex: map["lessonYearIndex"],
          teacher: map["teacher"],
          substituteTeacher: map["substituteTeacher"],
          start: DateTime.parse(map["start"]),
          end: DateTime.parse(map["end"]),
          description: map["description"],
          room: map["room"],
          groupName: map["groupName"],
          subject: await getSubjectbyId(map["subjectId"]),
        )
      : null;

  /// in Subject only id data
  Lesson getLessonData(Map<String, dynamic> map) => (map != null)
      ? Lesson(
          uid: map['uid'],
          id: map["id"],
          status: Data(
              map["statusId"], map["statusDescription"], map["statusName"]),
          type: Data(map["typeId"], map["typeDescription"], map["typeName"]),
          lessonIndex: map["lessonIndex"],
          lessonYearIndex: map["lessonYearIndex"],
          teacher: map["teacher"],
          substituteTeacher: map["substituteTeacher"],
          date: DateTime.parse(map['date'].toString()),
          start: DateTime.parse(map["start"].toString()),
          end: DateTime.parse(map["end"].toString()),
          description: map["description"],
          room: map["room"],
          groupName: map["groupName"],
          name: map['name'],
          subject: Subject(id: map["subjectId"]),
        )
      : null;

  Subject getSubjectData(Map map) => (map != null)
      ? Subject(
          id: map["id"],
          name: map["name"],
          nickname: map["nickname"],
          category: Data(map["categoryId"], map["categoryDescription"],
              map["categoryName"]))
      : null;

  Event getEventData(Map map) => (map != null)
      ? Event(
          id: map["id"],
          title: map["title"],
          start: map["start"],
          end: map['end'],
          content: map['content'])
      : null;

  Exam getExamData(Map m) => (m != null)
      ? Exam(
          id: m['id'],
          date: DateTime.parse(m['date']),
          writeDate: DateTime.parse(m['writeDate']),
          teacher: m['teacher'],
          mode: Data(m['modeId'], m['modeDescription'], m['modeName']),
          description: m['description'],
          group: m['groupName'],
          subjectIndex: m['subjectIndex'],
          subjectName: m['subjectName'])
      : null;

  /// Async because the Subject object
  Future<Absence> getAbsenceDataAsync(Map m) async => (m != null)
      ? Absence(
          id: m['id'],
          date: DateTime.parse(m['date']),
          delay: m['delay'],
          submitDate: DateTime.parse(m['submitDate']),
          teacher: m['teacher'],
          justification: Data(m['justificationId'],
              m['justificationDescription'], m['justificationName']),
          type: Data(m['typeId'], m['typeDescription'], m['typeName']),
          mode: Data(m['modeId'], m['modeDescription'], m['modeName']),
          subject: await getSubjectbyId(m['subjectId']),
          lessonStart: DateTime.parse(m['lessonStart']),
          lessonEnd: DateTime.parse(m['lessonEnd']),
          lessonIndex: m['lessonIndex'],
          group: m['groupName'])
      : null;

  /// in Subject only id data
  Absence getAbsenceData(Map m) => (m != null)
      ? Absence(
          id: m['id'],
          date: DateTime.parse(m['date']),
          delay: m['delay'],
          submitDate: DateTime.parse(m['submitDate']),
          teacher: m['teacher'],
          justification: Data(m['justificationId'],
              m['justificationDescription'], m['justificationName']),
          type: Data(m['typeId'], m['typeDescription'], m['typeName']),
          mode: Data(m['modeId'], m['modeDescription'], m['modeName']),
          subject: Subject(id: m["subjectId"]),
          lessonStart: DateTime.parse(m['lessonStart']),
          lessonEnd: DateTime.parse(m['lessonEnd']),
          lessonIndex: m['lessonIndex'],
          group: m['groupName'])
      : null;

  Evaluation getEvaluationData(Map m) => (m != null)
      ? Evaluation(
          id: m['id'],
          value: EvaluationValue(m['evalValue'], m['evalValueName'],
              m['evalValueShortName'], m['evalValueWeight']),
          date: m['date'] != '' ? DateTime.parse(m['date']) : null,
          teacher: m['teacher'],
          description: m['description'],
          type: Data(m['typeId'], m['typeDescription'], m['typeName']),
          groupId: m['groupId'],
          evaluationType: Data(
              m['evalTypeId'], m['evalTypeDescription'], m["evalTypeName"]),
          mode: Data(m['modeId'], m['modeDescription'], m['modeName']),
          writeDate:
              m['writeDate'] != '' ? DateTime.parse(m['writeDate']) : null,
          seenDate: m['seenDate'] != '' ? DateTime.parse(m['seenDate']) : null,
          form: m['form'],
          subject: Subject(id: m['subjectId']))
      : null;

  Note getNoteData(Map m) => (m != null)
      ? Note(
          id: m['id'],
          title: m['title'],
          date: DateTime.parse(m['date']),
          createDate: DateTime.parse(m['createDate']),
          teacher: m['teacher'],
          seenDate: DateTime.parse(m['seenDate']),
          groupId: m['groupId'],
          content: m['content'],
          type: Data(m['typeId'], m['typeDescription'], m['typeName']),
        )
      : null;

  Homework getHomeworkData(Map m) => (m != null)
      ? Homework(
          id: m['id'],
          date: DateTime.parse(m['date']),
          lessonDate: DateTime.parse(m['lessonDate']),
          deadline: DateTime.parse(m['deadline']),
          teacher: m['teacher'],
          content: m['content'],
          subjectName: m['subjectName'],
          group: m['groupName'],
          attachments: m['attachments'].toString().toList(),
          byTeacher: bool.fromEnvironment(m['byTeacher']),
          homeworkEnabled: bool.fromEnvironment(m['homeworkEnabled']),
          isSolved: bool.fromEnvironment(m['isSolved']),
        )
      : null;
}
