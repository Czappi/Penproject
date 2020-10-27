import 'package:equatable/equatable.dart';
import 'package:penproject/src/Models/Lesson.dart';

class Day extends Equatable {
  Day({this.date, this.lessons});

  final DateTime date;
  final List<Lesson> lessons;

  @override
  List<Object> get props => [date, lessons];

  @override
  bool get stringify => false;
}
