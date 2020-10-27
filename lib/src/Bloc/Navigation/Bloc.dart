import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penproject/src/Bloc/Navigation.dart';
import 'package:penproject/src/Database/UserDatabase.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(HomeState());

  final UserDatabase db = UserDatabase.db;

  @override
  Stream<NavigationState> mapEventToState(
    NavigationEvent event,
  ) async* {
    if (event is Home) {
      yield HomeState();
    } else if (event is Diary) {
      yield DiaryState();
    } else if (event is Timetable) {
      yield TimetableState();
    } else if (event is Absences) {
      yield AbsencesState();
    } else if (event is Homework) {
      yield HomeworkState();
    } else if (event is Messages) {
      yield MessagesState();
    } else if (event is Settings) {
      yield SettingsState();
    }
  }
}
