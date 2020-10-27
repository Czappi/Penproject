import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:penproject/src/Bloc/Navigation.dart';
import 'package:penproject/src/Bloc/Navigation/Event.dart';
import 'package:penproject/src/Widgets/Homepage/Drawer/Button.dart';

class HomepageDrawer extends StatelessWidget {
  final Function close;
  const HomepageDrawer({this.close});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Get.theme.backgroundColor,
            border: Border(
                right: BorderSide(
                    color: Get.isDarkMode ? Colors.black87 : Colors.grey[300],
                    width: 1))),
        //color: Colors.black,
        child: BlocBuilder<NavigationBloc, NavigationState>(
            builder: (context, state) {
          return Column(
            children: [
              HomepageDrawerButton(
                  icon: Feather.home,
                  text: "homepage".tr,
                  selected: state is HomeState,
                  onTap: () {
                    context.bloc<NavigationBloc>().add(Home());
                    close.call();
                  }),
              HomepageDrawerButton(
                icon: Feather.book,
                text: "diary".tr,
                selected: state is DiaryState,
                onTap: () {
                  context.bloc<NavigationBloc>().add(Diary());
                  close.call();
                },
              ),
              HomepageDrawerButton(
                icon: Feather.calendar,
                text: "timetable".tr,
                selected: state is TimetableState,
                onTap: () {
                  context.bloc<NavigationBloc>().add(Timetable());
                  close.call();
                },
              ),
              HomepageDrawerButton(
                icon: Feather.x_circle,
                text: "absences".tr,
                selected: state is AbsencesState,
                onTap: () {
                  context.bloc<NavigationBloc>().add(Absences());
                  close.call();
                },
              ),
              HomepageDrawerButton(
                disabled: true,
                icon: Feather.folder,
                text: "homeworks".tr,
                selected: state is HomeworkState,
                onTap: () {
                  context.bloc<NavigationBloc>().add(Homework());
                  close.call();
                },
              ),
              HomepageDrawerButton(
                disabled: true,
                icon: Feather.inbox,
                text: "messages".tr,
                selected: state is MessagesState,
                onTap: () {
                  context.bloc<NavigationBloc>().add(Messages());
                  close.call();
                },
              ),
              Flexible(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 0),
                      child: HomepageDrawerButton(
                        icon: Feather.settings,
                        text: "settings".tr,
                        selected: state is SettingsState,
                        onTap: () {
                          context.bloc<NavigationBloc>().add(Settings());
                          close.call();
                        },
                      ),
                    )),
              )
            ],
          );
        }));
  }
}

/*
HomepageDrawerButton(
                icon: Feather.home,
                text: "Főoldal",
                selected: state is ,
              ), */
