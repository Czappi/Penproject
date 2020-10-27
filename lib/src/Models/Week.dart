import 'package:equatable/equatable.dart';
import 'package:penproject/src/Models/Day.dart';

class Week extends Equatable {
  Week({this.start, this.end, this.days});

  final DateTime start;
  final DateTime end;
  final List<Day> days;

  @override
  List<Object> get props => [start, end, days];

  @override
  bool get stringify => false;
}
/*
class User extends Equatable {
  const User({});


  @override
  List<Object> get props =>
      [];

  @override
  bool get stringify => false;
} */
