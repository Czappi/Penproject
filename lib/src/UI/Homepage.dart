import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:penproject/src/UI/Homepage/Body.dart';
import 'package:penproject/src/UI/Homepage/Drawer.dart';
import 'package:penproject/src/Widgets/Homepage/Appbar/Menu.dart';
import 'package:penproject/src/Widgets/OfflineIndicator.dart';
import 'package:penproject/src/Widgets/ProfileIcon.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:penproject/src/Bloc/Navigation.dart';

class Homepage extends StatefulWidget {
  Homepage({Key key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  final StreamController<bool> streamController = StreamController.broadcast();

  @override
  void initState() {
    super.initState();
    final QuickActions quickActions = QuickActions();
    quickActions.initialize((shortcutType) {
      if (shortcutType == 'action_timetable') {
        Get.context.bloc<NavigationBloc>().add(Timetable());
      } else if (shortcutType == 'action_diary') {
        Get.context.bloc<NavigationBloc>().add(Diary());
      } else if (shortcutType == 'action_homework') {
        Get.context.bloc<NavigationBloc>().add(Diary());
      } else if (shortcutType == 'action_absences') {
        Get.context.bloc<NavigationBloc>().add(Diary());
      }
    });

    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(
        type: 'action_timetable',
        localizedTitle: 'Órarend',
        icon: 'ic_calendar',
      ),
      const ShortcutItem(
          type: 'action_diary', localizedTitle: 'Napló', icon: 'ic_book'),
      const ShortcutItem(
          type: 'action_homework',
          localizedTitle: 'Házi feladatok',
          icon: 'ic_folder'),
      const ShortcutItem(
          type: 'action_absences',
          localizedTitle: 'Hiányzások',
          icon: 'ic_x_circle'),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
        connectivityBuilder: (context, connectivity, widget) {
          print((connectivity == ConnectivityResult.none));
          return Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height:
                        (connectivity == ConnectivityResult.none) ? 20.h : 0,
                  ),
                  Expanded(
                      child: Scaffold(
                          appBar: AppBar(
                            brightness:
                                (connectivity == ConnectivityResult.none)
                                    ? Brightness.light
                                    : Get.isDarkMode
                                        ? Brightness.dark
                                        : Brightness.light,
                            elevation: 0,
                            leading: HomepageAppbarMenu(
                              opened: streamController.stream,
                              onClose: () =>
                                  _innerDrawerKey.currentState.close(),
                              onOpen: () => _innerDrawerKey.currentState.open(),
                            ),
                            actions: [
                              // TODO: profil oldal
                              ProfileIcon(),
                            ],
                          ),
                          body: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: Get.isDarkMode
                                            ? Colors.black87
                                            : Colors.grey[300]))),
                            child: InnerDrawer(
                              scaffold: Scaffold(
                                body: widget,
                              ),
                              key: _innerDrawerKey,
                              colorTransitionChild: Colors.transparent,
                              colorTransitionScaffold: Colors.transparent,
                              boxShadow: [],
                              innerDrawerCallback: (o) {
                                streamController.add(o);
                              },
                              leftChild: HomepageDrawer(
                                close: () =>
                                    _innerDrawerKey.currentState.close(),
                              ),
                              leftAnimationType: InnerDrawerAnimation.linear,
                            ),
                          )))
                ],
              ),
              OfflineIndicator(connectivity),
            ],
          );
        },
        child: HomepageBody());
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }
}
