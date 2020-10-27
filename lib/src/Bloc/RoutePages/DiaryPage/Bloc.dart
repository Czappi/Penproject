import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:penproject/src/Api/client.dart';
import 'package:penproject/src/Bloc/DiaryPage.dart';
import 'package:connectivity/connectivity.dart';
import 'package:penproject/src/Utils/AverageMath.dart';
import 'package:provider/provider.dart';

import 'package:penproject/src/Database/UserDatabase.dart';
import 'package:penproject/src/Database/Database.dart';
import 'package:penproject/src/Database/Extensions.dart';

class DiaryPageBloc extends Bloc<RoutePageEvent, RoutePageState> {
  DiaryPageBloc() : super(RoutePageInitial());

  final UserDatabase db = UserDatabase.db;
  ApiClient client = Get.context.read<ApiClient>();

  @override
  Stream<RoutePageState> mapEventToState(
    RoutePageEvent event,
  ) async* {
    if (event is Load) {
      try {
        yield Loading();

        if (event.id != null) {
          DatabaseProvider db = DatabaseProvider(client.clientId);

          var evals = await db.readEvaluationsbySubjectId(event.id);

          var subject = await db.getSubjectbyId(event.id);

          if (evals != null && subject != null) {
            var averages = getAverages(evals);

            yield Loaded(
                {'averages': averages, 'evals': evals, 'title': subject.name});
          } else {
            yield Loaded(await refreshDiaryPage());
          }
        } else {
          yield LoadError();
        }
      } catch (e) {
        print("RoutePageBloc.DiaryPage ERROR: $e");
        yield LoadError();
      }
    }
  }

  Future<Map<String, dynamic>> refreshDiaryPage() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    DatabaseProvider db = DatabaseProvider(client.clientId);

    if (connectivityResult != ConnectivityResult.none) {
      var res = await client.getEvaluations();
      await db.writeEvaluations(res);
    }
    return {'reloaded': true};
  }
}
