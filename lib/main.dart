import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart'
    show MultiBlocProvider, BlocProvider;
import 'package:penproject/src/Api/client.dart';
import 'package:penproject/src/Bloc/Home.dart';
import 'package:penproject/src/UI/RoutePages/DiaryPage.dart';
import 'package:penproject/src/UI/RoutePages/EvaluationPage.dart';
import 'package:penproject/src/UI/RoutePages/TimetablePage.dart';
import 'package:penproject/src/Utils/SettingsProvider.dart';
import 'package:penproject/src/Widgets/RestartWidget.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:penproject/src/UI/AuthScreen.dart';

import 'package:penproject/src/Utils/Constants/Themes.dart';
import 'package:penproject/src/Internationalization/Translation.dart';

import 'package:penproject/src/Bloc/Absences.dart';
import 'package:penproject/src/Bloc/Diary.dart';
import 'package:penproject/src/Bloc/DiaryPage.dart';
import 'package:penproject/src/Bloc/EvaluationPage.dart';
import 'package:penproject/src/Bloc/Navigation.dart';
import 'package:penproject/src/Bloc/Auth.dart';
import 'package:penproject/src/Bloc/Student.dart';
import 'package:penproject/src/Bloc/Timetable.dart';
import 'package:penproject/src/Bloc/TimetablePage.dart';

void main() {
  runApp(RestartWidget(
    child: Main(),
  ));
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => NavigationBloc()),
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => TimetableBloc()),
        BlocProvider(create: (context) => DiaryBloc()),
        BlocProvider(create: (context) => StudentBloc()),
        BlocProvider(create: (context) => AbsencesBloc()),
        BlocProvider(create: (context) => TimetablePageBloc()),
        BlocProvider(create: (context) => DiaryPageBloc()),
        BlocProvider(create: (context) => EvaluationPageBloc()),
      ],
      child: MultiProvider(
          providers: [
            Provider(
              create: (context) => ApiClient(),
            ),
            Provider(
              create: (context) => SettingsProvider(),
            ),
            FutureProvider(
              create: (context) => SettingsProvider().initProvider(),
            ),
            //Provider(create: (context) => UserProvider()),
          ],
          child: Builder(builder: (context) {
            return FutureBuilder(
              future: context.watch<SettingsProvider>().initProvider(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var themeMode = context.watch<SettingsProvider>().themeMode;
                  return RefreshConfiguration(
                      headerBuilder: () => MaterialClassicHeader(
                            color: Get.theme.buttonColor,
                            backgroundColor: Get.theme.cardColor,
                          ),
                      child: GetMaterialApp(
                        debugShowCheckedModeBanner: false,
                        title: "Pen",

                        theme: lightTheme,
                        darkTheme: darkTheme,
                        themeMode: themeMode,
                        defaultTransition: Transition.downToUp,
                        //initialRoute: "/",
                        getPages: [
                          //GetPage(name: "/", page: null),
                          //GetPage(name: "/homepage", page: null),
                          //GetPage(name: "/login", page: null),
                          //GetPage(name: "/lesson", page: null),
                          GetPage(
                              name: "/DiaryPage/:id", page: () => DiaryPage()),
                          GetPage(
                              name: "/EvalPage/:id",
                              page: () => EvaluationPage(
                                    asPage: true,
                                  )),
                          GetPage(
                              name: "/TimetablePage/:id",
                              page: () => TimetablePage()),
                        ],
                        translations: Translation(), // your translations
                        locale: Locale('hu', 'HU'),
                        fallbackLocale: Locale('en', 'US'),
                        home: AuthScreen(),
                      ));
                } else
                  return Container();
              },
            );
          })),
    );
  }
}
