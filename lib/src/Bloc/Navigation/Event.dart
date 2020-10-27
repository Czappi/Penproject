import 'package:equatable/equatable.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class Home extends NavigationEvent {}

class Diary extends NavigationEvent {} // napló

class Timetable extends NavigationEvent {}

class Absences extends NavigationEvent {}

class Homework extends NavigationEvent {}

class Messages extends NavigationEvent {}

class Settings extends NavigationEvent {}
