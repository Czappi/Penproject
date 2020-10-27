import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:penproject/src/Bloc/Timetable.dart';
import 'package:penproject/src/Models/Week.dart';
import 'package:penproject/src/Utils/TimetableBuilder.dart';
import 'package:penproject/src/Widgets/ErrorWidget.dart';
import 'package:penproject/src/Widgets/Homepage/Body/Pages/Timetable/DateTile.dart';
import 'package:penproject/src/Widgets/Homepage/Body/Pages/Timetable/LessonTile.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomepageTimetable extends StatefulWidget {
  HomepageTimetable({Key key}) : super(key: key);

  @override
  _HomepageTimetableState createState() => _HomepageTimetableState();
}

class _HomepageTimetableState extends State<HomepageTimetable> {
  RefreshController refreshController;

  @override
  void initState() {
    super.initState();
    refreshController = RefreshController(initialRefresh: true);
    Get.context.bloc<TimetableBloc>().add(Load());
  }

  void _onRefresh() async {
    await Get.context.bloc<TimetableBloc>().refreshTimetable();
    refreshController.refreshCompleted();
    Get.context.bloc<TimetableBloc>().add(Load());
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        controller: refreshController,
        onRefresh: _onRefresh,
        physics: BouncingScrollPhysics(),
        child:
            BlocBuilder<TimetableBloc, LoaderState>(builder: (context, state) {
          if (state is Loaded) {
            if (state.data.containsKey('week') == true) {
              Week week = state.data['week'];
              if (week.days.isNotEmpty) {
                return HomepageTimetableBody(
                  week: week,
                );
              } else {
                return Container(
                  alignment: Alignment.center,
                  child: Text('nodata'.tr),
                );
              }
            } else {
              Get.context.bloc<TimetableBloc>().add(Load());
              return Container();
            }
          } else if (state is Loading) {
            return Container(
              //color: Colors.red,
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (state is LoadError) {
            return PenErrorWidget();
          }
          return Container();
        }));
  }
}

class HomepageTimetableBody extends StatefulWidget {
  final Week week;
  HomepageTimetableBody({this.week});

  @override
  _HomepageTimetableBodyState createState() => _HomepageTimetableBodyState();
}

class _HomepageTimetableBodyState extends State<HomepageTimetableBody> {
  int dayindex;
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    dayindex = TimetableBuilder().today(widget.week.days.length);
  }

  @override
  Widget build(BuildContext context) {
    var week = widget.week;
    return Column(
      children: [
        SizedBox(
          height: 10.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(week.days.length, (index) {
            return TimetableDateTile(
                selected: dayindex == index,
                date: week.days[index].date,
                onTap: () {
                  setState(() {
                    dayindex = index;
                  });
                });
          }),
        ),
        SizedBox(
          height: 10.h,
        ),
        Expanded(
            child: CupertinoScrollbar(
          controller: scrollController,
          child: ListView.builder(
              controller: scrollController,
              itemCount: week.days[dayindex].lessons.length,
              itemBuilder: (context, index) {
                var lesson = week.days[dayindex].lessons[index];
                return TimetableLessonTile(lesson);
              }),
        )),
      ],
    );
  }
}
