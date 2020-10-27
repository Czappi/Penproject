import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:penproject/src/Api/client.dart';
import 'package:penproject/src/Bloc/TimetablePage.dart';
import 'package:provider/provider.dart';

import 'package:penproject/src/Database/UserDatabase.dart';
import 'package:penproject/src/Database/Database.dart';
import 'package:penproject/src/Database/Extensions.dart';

class TimetablePageBloc extends Bloc<RoutePageEvent, RoutePageState> {
  TimetablePageBloc() : super(RoutePageInitial());

  final UserDatabase db = UserDatabase.db;
  ApiClient client = Get.context.read<ApiClient>();

  @override
  Stream<RoutePageState> mapEventToState(
    RoutePageEvent event,
  ) async* {
    if (event is Load) {
      try {
        yield Loading();
      } catch (e) {
        print("RoutePageBloc.{$event} ERROR: $e");
        yield LoadError();
      }
    }
  }
}
