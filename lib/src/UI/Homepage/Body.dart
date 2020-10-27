import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:penproject/src/Bloc/Navigation.dart';

import 'package:penproject/src/UI/Homepage/Pages/Absences.dart';
import 'package:penproject/src/UI/Homepage/Pages/Diary.dart';
import 'package:penproject/src/UI/Homepage/Pages/Home.dart';
import 'package:penproject/src/UI/Homepage/Pages/Homework.dart';
import 'package:penproject/src/UI/Homepage/Pages/Messages.dart';
import 'package:penproject/src/UI/Homepage/Pages/Settings.dart';
import 'package:penproject/src/UI/Homepage/Pages/Timetable.dart';

class HomepageBody extends StatelessWidget {
  const HomepageBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
      if (state is HomeState) {
        return HomepageHome();
      } else if (state is TimetableState) {
        return HomepageTimetable();
      } else if (state is DiaryState) {
        return HomepageDiary();
      } else if (state is AbsencesState) {
        return HomepageAbsences();
      } else if (state is HomeworkState) {
        return HomepageHomework();
      } else if (state is MessagesState) {
        return HomepageMessages();
      } else if (state is SettingsState) {
        return HomepageSettings();
      } else {
        return Container();
      }
    });
  }
}
