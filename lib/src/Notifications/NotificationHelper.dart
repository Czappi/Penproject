import 'dart:math';

import 'package:background_fetch/background_fetch.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:penproject/src/Api/client.dart';
import 'package:penproject/src/Bloc/Navigation.dart';
import 'package:penproject/src/Database/Database.dart';
import 'package:penproject/src/Database/UserDatabase.dart';
import 'package:penproject/src/Models/Evaluation.dart';
import 'package:penproject/src/Models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';
import 'package:supercharged/supercharged.dart';
import 'package:penproject/src/Database/Extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationHelper {
  NotificationHelper();

  UserDatabase udb = UserDatabase.db;
  var notificationPlugin = AndroidFlutterLocalNotificationsPlugin();
  ApiClient client = ApiClient();

  static const EVAL_GROUP = "pen.evaluationgroup";
  static const ABSENCE_GROUP = "pen.absencegroup";
  static const SUBTITUTION_GROUP = "pen.subtitutiongroup";

  static var _random = Random.secure();

  int evalId() => 100000 + _random.nextInt(99999);
  int absenceId() => 200000 + _random.nextInt(99999);
  int subtitutionId() => 300000 + _random.nextInt(99999);

  void payloadRoute(String payload, {String page, String code}) {
    if (payload.allBefore("//") == code) {
      String id = payload.allAfter("//");
      Get.toNamed("/$page/$id");
    }
  }

  void payloadNavigation(String payload, {NavigationEvent page, String code}) {
    if (payload.allBefore("//") == code) {
      Get.context.bloc<NavigationBloc>().add(page);
    }
  }

  Future<User> getUser() async {
    var lastLoggedIn = await udb.getUserbyLastLoggedIn();
    return lastLoggedIn;
  }

  Future<Map<String, dynamic>> getSettings() async {
    String onlywifi = "notif.onlywifi"; // bool
    String interval = "notif.interval"; // int (ms)
    String lastrefresh = "notif.last"; // int (timestamp)

    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> map = {};

    map.addAll({
      "onlywifi": (prefs.containsKey(onlywifi) ? prefs.getBool(onlywifi) : true)
    });
    map.addAll({
      "interval": (prefs.containsKey(interval)
          ? prefs.getInt(interval)
          : 1800000) // if not contains the key: 30 min
    });
    map.addAll({
      "last": (prefs.containsKey(lastrefresh)
          ? DateTime.fromMillisecondsSinceEpoch(prefs.getInt(lastrefresh))
          : DateTime.now())
    });

    return map;
  }

  Future<bool> init(SelectNotificationCallback onSelectNotification) async {
    try {
      await notificationPlugin.initialize(
        AndroidInitializationSettings("ic_notification"),
        onSelectNotification: onSelectNotification,
      );

      await notificationPlugin
          .createNotificationChannel(AndroidNotificationChannel(
        EVAL_GROUP,
        "Értékelések",
        "Értékelések jelzése értesítésekben",
      ));
      /*
      notificationPlugin.createNotificationChannel(AndroidNotificationChannel(
        ABSENCE_GROUP,
        "Hiányzások",
        "Hiányzások jelzése értesítésekben",
      ));
      notificationPlugin.createNotificationChannel(AndroidNotificationChannel(
        SUBTITUTION_GROUP,
        "Helyettesítések",
        "Helyettesítések jelzése értesítésekben",
      ));
      */
      return true;
    } catch (e) {
      print("NotificationHelper.init: $e");
      return false;
    }
  }

  Future<bool> backgroundTask() async {
    try {
      var settings = await getSettings();
      var user = await getUser();
      var con = await Connectivity().checkConnectivity();

      if (settings["onlywifi"]
          ? con == ConnectivityResult.wifi
          : con != ConnectivityResult.none) {
        if (await client.login(user)) {
          DatabaseProvider db = DatabaseProvider(client.clientId);
          evaluations(db, settings["last"]);
        }
      }

      BackgroundFetch.scheduleTask(TaskConfig(
          taskId: "com.czappi.notification",
          delay: settings["interval"],
          startOnBoot: true,
          periodic: false,
          forceAlarmManager: true,
          stopOnTerminate: false,
          enableHeadless: true));
      return true;
    } catch (e) {
      print("NotificationHelper.backgroundTask: $e");
      return false;
    }
  }

  Future<bool> evaluations(DatabaseProvider db, DateTime last) async {
    try {
      List<Evaluation> evals = await client.getEvaluations();
      var newEvals =
          evals.where((element) => element.date.isAfter(last)).toList();
      await db.writeEvaluations(newEvals);
      if (newEvals.isNotEmpty) {
        for (var i = 0; i <= newEvals.length - 1; i++) {
          var eval = newEvals[i];

          notificationPlugin.show(evalId(), "Új értékelés",
              "Új értékelést (${eval.value.value.toString()}) kaptál ${eval.subject.name} tantárgyból",
              notificationDetails: AndroidNotificationDetails(
                EVAL_GROUP,
                "Értékelések",
                "Értékelések jelzése értesítésekben",
              ),
              payload: "eval//${eval.id}");
        }
      }
      return true;
    } catch (e) {
      print("NotificationHelper.evaluations: $e");
      return false;
    }
  }
}

void backgroundFetchHeadlessTask(String taskId) async {
  var notifhelper = NotificationHelper();
  //await notifhelper.init((payload) => null);

  await notifhelper.backgroundTask().then((_) {
    BackgroundFetch.finish(taskId);
  });
}
