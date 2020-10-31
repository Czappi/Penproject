import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:penproject/src/Bloc/DiaryPage.dart';
import 'package:penproject/src/Models/Evaluation.dart';
import 'package:penproject/src/Utils/format.dart';
import 'package:penproject/src/Widgets/ErrorWidget.dart';
import 'package:penproject/src/Widgets/Homepage/Body/Pages/Diary/AveragesChart.dart';
import 'package:penproject/src/Widgets/Homepage/Body/Pages/Diary/EvalTable.dart';
import 'package:penproject/src/Widgets/RoutePages/Foundation.dart';
import 'package:penproject/src/Widgets/RoutePages/Title.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DiaryPage extends StatefulWidget {
  DiaryPage();

  @override
  _DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  String id = Get.parameters['id'];
  @override
  void initState() {
    super.initState();
    Get.context.bloc<DiaryPageBloc>().add(Load(id));
  }

  RefreshController refreshController = RefreshController(initialRefresh: true);

  void _onRefresh() async {
    await Get.context.bloc<DiaryPageBloc>().refreshDiaryPage();
    refreshController.refreshCompleted();
    Get.context.bloc<DiaryPageBloc>().add(Load(id));
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
              child: BlocBuilder<DiaryPageBloc, RoutePageState>(
                  builder: (context, state) {
                if (state is Loaded) {
                  if (state.data.containsKey('reloaded') != true) {
                    print(state.data);
                    return DiaryPageBody(
                      averages: state.data['averages'],
                      evals: state.data['evals'],
                      title: state.data['title'],
                      rows: state.data['evaltablerows'],
                    );
                  } else {
                    Get.context.bloc<DiaryPageBloc>().add(Load(id));
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

class DiaryPageBody extends StatelessWidget {
  final List<Evaluation> evals;
  final Map<int, double> averages;
  final List<DataRow> rows;
  final String title;
  const DiaryPageBody({this.evals, this.averages, this.title, this.rows});

  @override
  Widget build(BuildContext context) {
    print(rows);
    return Column(
      children: [
        RoutePageTitle(title: capitalize(title) ?? ""),
        Expanded(
          child: CupertinoScrollbar(
              child: ListView(
            children: [
              SizedBox(
                height: 20.h,
              ),
              AveragesChart(
                averages: averages,
              ),
              SizedBox(
                height: 20.h,
              ),
              EvalTable(printSubject: false, dataRows: rows),
              SizedBox(
                height: 20.h,
              ),
            ],
          )),
        )
      ],
    );
  }
}
