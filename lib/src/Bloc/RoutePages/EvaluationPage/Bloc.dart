import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:penproject/src/Api/client.dart';
import 'package:penproject/src/Bloc/EvaluationPage.dart';
import 'package:connectivity/connectivity.dart';
import 'package:provider/provider.dart';

import 'package:penproject/src/Database/UserDatabase.dart';
import 'package:penproject/src/Database/Database.dart';
import 'package:penproject/src/Database/Extensions.dart';

class EvaluationPageBloc extends Bloc<RoutePageEvent, RoutePageState> {
  EvaluationPageBloc() : super(RoutePageInitial());

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

          var eval = await db.readEvaluationsbyId(event.id);
          var subject = await db.getSubjectbyId(eval.subject.id);

          if (eval != null) {
            yield Loaded({
              'eval': eval,
              'subject': subject,
            });
          } else {
            yield Loaded(await refreshEvaluationPage());
          }
        } else {
          yield LoadError();
        }
      } catch (e) {
        print("RoutePageBloc.EvaluationPage ERROR: $e");
        yield LoadError();
      }
    }
  }

  Future<Map<String, dynamic>> refreshEvaluationPage() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    DatabaseProvider db = DatabaseProvider(client.clientId);

    if (connectivityResult != ConnectivityResult.none) {
      var res = await client.getEvaluations();
      await db.writeEvaluations(res);
    }
    return {'reloaded': true};
  }
}
