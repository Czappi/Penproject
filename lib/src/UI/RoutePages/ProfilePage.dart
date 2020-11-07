import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:penproject/src/Bloc/ProfilePage.dart';
import 'package:penproject/src/Models/Student.dart';
import 'package:penproject/src/Utils/format.dart';
import 'package:penproject/src/Widgets/ErrorWidget.dart';
import 'package:penproject/src/Widgets/RoutePages/Foundation.dart';
import 'package:penproject/src/Widgets/RoutePages/ProfilePage/Infobox.dart';
import 'package:penproject/src/Widgets/RoutePages/ProfilePage/LogoutButton.dart';
import 'package:penproject/src/Widgets/RoutePages/Title.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage();

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String id = Get.parameters['id'];
  @override
  void initState() {
    super.initState();
    Get.context.bloc<ProfilePageBloc>().add(Load(id));
  }

  RefreshController refreshController = RefreshController(initialRefresh: true);

  void _onRefresh() async {
    await Get.context.bloc<ProfilePageBloc>().refreshProfilePage();
    refreshController.refreshCompleted();
    Get.context.bloc<ProfilePageBloc>().add(Load(id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
        ),
        backgroundColor: Colors.lightBlueAccent,
        body: RoutePageFoundation(
          child: SmartRefresher(
              controller: refreshController,
              onRefresh: _onRefresh,
              child: BlocBuilder<ProfilePageBloc, RoutePageState>(
                  builder: (context, state) {
                if (state is Loaded) {
                  if (state.data.containsKey('reloaded') != true) {
                    return ProfilePageBody(
                      student: state.data['student'],
                    );
                  } else {
                    Get.context.bloc<ProfilePageBloc>().add(Load(id));
                    return Container();
                  }
                } else if (state is Loading) {
                  return Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LoadError) {
                  return PenErrorWidget();
                } else {
                  return Container();
                }
              })),
        ));
  }
}

class ProfilePageBody extends StatelessWidget {
  final Student student;
  const ProfilePageBody({this.student});

  @override
  Widget build(BuildContext context) {
    //print(rows);
    return Column(
      children: [
        RoutePageTitle(title: capitalize(student.name) ?? ""),
        Expanded(
          child: CupertinoScrollbar(
              child: ListView(
            children: [
              SizedBox(
                height: 20.h,
              ),
              ProfilePageInfobox(student),
              SizedBox(
                height: 20.h,
              ),
              ProfilePageLogoutButton()
            ],
          )),
        )
      ],
    );
  }
}
