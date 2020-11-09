import 'package:penproject/src/Database/Database.dart';
import 'package:penproject/src/Models/Absence.dart';
import 'package:penproject/src/Models/Evaluation.dart';
import 'package:penproject/src/Models/Event.dart';
import 'package:penproject/src/Models/Exam.dart';
import 'package:penproject/src/Models/Homework.dart';
import 'package:penproject/src/Models/Lesson.dart';
import 'package:penproject/src/Models/Note.dart';
import 'package:penproject/src/Models/Student.dart';
import 'package:penproject/src/Models/Subject.dart';

extension ValuesExt on DatabaseProvider {
  Map<String, dynamic> getStudentValues(Student student) => {
        "id": student.id,
        "name": student.name,
        "parents": student.parents.toString(),
        "schoolId": student.school.id,
        "schoolCity": student.school.city,
        "schoolName": student.school.name,
        "birth": student.birth.toUtc().toIso8601String(),
        "yearId": student.yearId,
        "address": student.address,
        "groupId": student.groupId
      };

  Map<String, dynamic> getLessonValues(Lesson lesson) => {
        "uid": lesson.uid ?? null,
        "id": lesson.id ?? null,
        "statusId": lesson.status.id ?? null,
        "statusDescription": lesson.status.description ?? null,
        "statusName": lesson.status.name ?? null,
        "typeId": lesson.type.id ?? null,
        "typeDescription": lesson.type.description ?? null,
        "typeName": lesson.type.name ?? null,
        "lessonIndex": lesson.lessonIndex ?? null,
        "lessonYearIndex": lesson.lessonYearIndex ?? null,
        "teacher": lesson.teacher ?? null,
        "substituteTeacher": lesson.substituteTeacher ?? null,
        "date": lesson.date.toUtc().toIso8601String() ?? null,
        "start": lesson.start.toUtc().toIso8601String() ?? null,
        "end": lesson.end.toUtc().toIso8601String() ?? null,
        "description": lesson.description ?? null,
        "room": lesson.room ?? null,
        "groupName": lesson.groupName ?? null,
        "name": lesson.name ?? null,
        "subjectId": (lesson.subject != null) ? lesson.subject.id : null
      };
  Map<String, dynamic> getSubjectValues(Subject subject) => {
        "id": subject.id ?? null,
        "name": subject.name ?? null,
        "nickname": subject.nickname ?? null,
        "categoryId": subject.category.id ?? null,
        "categoryDescription": subject.category.description ?? null,
        "categoryName": subject.category.name ?? null,
      };
  Map<String, dynamic> getEventValues(Event event) => {
        "id": event.id,
        "title": event.title,
        "start": event.start.toUtc().toIso8601String(),
        "end": event.end.toUtc().toIso8601String(),
        "content": event.content
      };
  Map<String, dynamic> getExamValues(Exam exam) => {
        "id": exam.id,
        "date": exam.date.toUtc().toIso8601String(),
        "writeDate": exam.writeDate.toUtc().toIso8601String(),
        "teacher": exam.teacher,
        "modeId": exam.mode.id,
        "modeDescription": exam.mode.description,
        "modeName": exam.mode.name,
        "description": exam.description,
        "groupName": exam.group,
        "subjectIndex": exam.subjectIndex,
        "subjectName": exam.subjectName
      };
  Map<String, dynamic> getAbsenceValues(Absence absence) => {
        "id": absence.id,
        "date": absence.date.toUtc().toIso8601String(),
        "delay": absence.delay,
        "submitDate": absence.submitDate.toUtc().toIso8601String(),
        "teacher": absence.teacher,
        "justificationId":
            (absence.justification != null) ? absence.justification.id : "null",
        "justificationDescription": (absence.justification != null)
            ? absence.justification.description
            : "null",
        "justificationName": (absence.justification != null)
            ? absence.justification.name
            : "null",
        "typeId": absence.type.id,
        "typeDescription": absence.type.description,
        "typeName": absence.type.name,
        "modeId": absence.mode.id,
        "modeDescription": absence.mode.description,
        "modeName": absence.mode.name,
        "subjectId": absence.subject.id,
        "lessonStart": absence.lessonStart.toUtc().toIso8601String(),
        "lessonEnd": absence.lessonEnd.toUtc().toIso8601String(),
        "lessonIndex": absence.lessonIndex,
        "groupName": absence.group,
      };
  Map<String, dynamic> getEvaluationValues(Evaluation eval) => {
        "id": eval.id,
        "evalValue": eval.value.value,
        "evalValueShortName": eval.value.shortName,
        "evalValueName": eval.value.valueName,
        "evalValueWeight": eval.value.weight,
        "date": eval.date != null ? eval.date.toUtc().toIso8601String() : '',
        "teacher": eval.teacher,
        "description": eval.description,
        "typeId": eval.type.id,
        "typeDescription": eval.type.description,
        "typeName": eval.type.name,
        "groupId": eval.groupId,
        "subjectId": eval.subject.id,
        "evalTypeId": eval.evaluationType.id,
        "evalTypeDescription": eval.evaluationType.description,
        "evalTypeName": eval.evaluationType.name,
        "modeId": eval.mode.id,
        "modeDescription": eval.mode.description,
        "modeName": eval.mode.name,
        "writeDate": eval.writeDate != null
            ? eval.writeDate.toUtc().toIso8601String()
            : '',
        "seenDate": eval.seenDate != null
            ? eval.seenDate.toUtc().toIso8601String()
            : '',
        "form": eval.form,
      };
  Map<String, dynamic> getNoteValues(Note note) => {
        "id": note.id,
        "title": note.title,
        "date": note.date.toUtc().toIso8601String(),
        "createDate": note.createDate.toUtc().toIso8601String(),
        "teacher": note.teacher,
        "seenDate": note.seenDate.toUtc().toIso8601String(),
        "groupId": note.groupId,
        "content": note.content,
        "typeId": note.type.id,
        "typeDescription": note.type.description,
        "typeName": note.type.name
      };
  Map<String, dynamic> getHomeworkValues(Homework homework) => {
        "id": homework.id,
        "date": homework.date.toUtc().toIso8601String(),
        "lessonDate": homework.lessonDate.toUtc().toIso8601String(),
        "deadline": homework.deadline.toUtc().toIso8601String(),
        "teacher": homework.teacher,
        "content": homework.content,
        "subjectName": homework.subjectName,
        "groupName": homework.group,
        "attachments": homework.attachments.toString(),
        "byTeacher": homework.byTeacher.toString(),
        "homeworkEnabled": homework.homeworkEnabled,
        "isSolved": homework.isSolved,
      };
}
