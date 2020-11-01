import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart'
    show MultiBlocProvider, BlocProvider;
import 'package:penproject/src/Api/client.dart';
import 'package:penproject/src/Bloc/Home.dart';
import 'package:penproject/src/UI/RoutePages/DiaryPage.dart';
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
import 'package:penproject/src/Bloc/Navigation.dart';
import 'package:penproject/src/Bloc/Auth.dart';
import 'package:penproject/src/Bloc/Student.dart';
import 'package:penproject/src/Bloc/Timetable.dart';
import 'package:penproject/src/Bloc/TimetablePage.dart';
import 'package:theme_provider/theme_provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //systemNavigationBarColor: Colors.blue, // navigation bar color
    statusBarColor: Colors.transparent, // status bar color
  ));
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
        ],
        child: MultiProvider(
            providers: [
              Provider(
                create: (context) => ApiClient(),
              ),
              //Provider(create: (context) => UserProvider()),
            ],
            child: ThemeProvider(
                saveThemesOnChange: true,
                loadThemeOnInit: true,
                defaultThemeId: "lighttheme",
                themes: [
                  AppTheme(
                      id: "lighttheme",
                      description: "Light mode",
                      data: lightTheme),
                  AppTheme(
                      id: "darktheme",
                      description: "Dark mode",
                      data: darkTheme)
                ],
                child: ThemeConsumer(
                  child: Builder(
                      builder: (context) => RefreshConfiguration(
                          headerBuilder: () => MaterialClassicHeader(
                                color: ThemeProvider.themeOf(context)
                                    .data
                                    .buttonColor,
                              ),
                          child: GetMaterialApp(
                            debugShowCheckedModeBanner: false,
                            title: "Pen",
                            theme: ThemeProvider.themeOf(context).data,
                            darkTheme: ThemeProvider.themeOf(context).data,
                            themeMode: ThemeMode.light, //ThemeMode.system,
                            defaultTransition: Transition.downToUp,
                            //initialRoute: "/",
                            getPages: [
                              //GetPage(name: "/", page: null),
                              //GetPage(name: "/homepage", page: null),
                              //GetPage(name: "/login", page: null),
                              //GetPage(name: "/lesson", page: null),
                              GetPage(
                                  name: "/DiaryPage/:id",
                                  page: () => DiaryPage())
                            ],
                            translations: Translation(), // your translations
                            locale: Locale('hu', 'HU'),
                            fallbackLocale: Locale('en', 'US'),
                            home: AuthScreen(),
                          ))),
                ))));
  }
}
