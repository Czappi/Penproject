import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:penproject/src/Bloc/TimetablePage.dart';
import 'package:penproject/src/Models/Lesson.dart';
import 'package:penproject/src/Models/Subject.dart';
import 'package:penproject/src/Utils/format.dart';
import 'package:penproject/src/Widgets/ErrorWidget.dart';
import 'package:penproject/src/Widgets/Homepage/Body/Pages/Diary/AveragesChart.dart';
import 'package:penproject/src/Widgets/Homepage/Body/Pages/Diary/EvalTable.dart';
import 'package:penproject/src/Widgets/RoutePages/Foundation.dart';
import 'package:penproject/src/Widgets/RoutePages/TimetablePage/Infobox.dart';
import 'package:penproject/src/Widgets/RoutePages/Title.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimetablePage extends StatefulWidget {
  TimetablePage();

  @override
  _TimetablePageState createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  String id = Get.parameters['id'];
  @override
  void initState() {
    super.initState();
    Get.context.bloc<TimetablePageBloc>().add(Load(id));
  }

  RefreshController refreshController = RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
      ),
      backgroundColor: Colors.lightBlueAccent,
      body: RoutePageFoundation(child:
          BlocBuilder<TimetablePageBloc, RoutePageState>(
              builder: (context, state) {
        if (state is Loaded) {
          if (state.data.containsKey('reloaded') != true) {
            return TimetablePageBody(
              averages: state.data['averages'],
              rows: state.data['evaltablerows'],
              lesson: state.data['lesson'],
              subject: state.data['subject'],
            );
          } else {
            Get.context.bloc<TimetablePageBloc>().add(Load(id));
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
    );
  }
}

class TimetablePageBody extends StatelessWidget {
  final Lesson lesson;
  final Subject subject;
  final Map<int, double> averages;
  final List<DataRow> rows;
  const TimetablePageBody({
    this.averages,
    this.rows,
    this.lesson,
    this.subject,
  });

  @override
  Widget build(BuildContext context) {
    //print(rows);
    return Column(
      children: [
        RoutePageTitle(title: capitalize(lesson.name) ?? ""),
        Expanded(
          child: CupertinoScrollbar(
              child: ListView(
            children: [
              SizedBox(
                height: 20.h,
              ),
              TimetablePageInfobox(lesson, subject),
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
