import 'package:equatable/equatable.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object> get props => [];
}

class NavigationInitial extends NavigationState {}

class HomeState extends NavigationState {}

class DiaryState extends NavigationState {} // napló

class TimetableState extends NavigationState {}

class AbsencesState extends NavigationState {}

class HomeworkState extends NavigationState {}

class MessagesState extends NavigationState {}

class SettingsState extends NavigationState {}
