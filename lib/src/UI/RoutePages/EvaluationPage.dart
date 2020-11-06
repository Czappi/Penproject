import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:penproject/src/Bloc/EvaluationPage.dart';
import 'package:penproject/src/Models/Evaluation.dart';
import 'package:penproject/src/Models/Subject.dart';
import 'package:penproject/src/Widgets/ErrorWidget.dart';
import 'package:penproject/src/Widgets/RoutePages/EvaluationPage/Infobox.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:penproject/src/Widgets/RoutePages/Foundation.dart';

class EvaluationPage extends StatefulWidget {
  final bool asPage;

  EvaluationPage({
    @required this.asPage,
  });

  @override
  _EvaluationPageState createState() => _EvaluationPageState();
}

class _EvaluationPageState extends State<EvaluationPage> {
  String id = Get.arguments ?? Get.parameters['id'];
  @override
  void initState() {
    super.initState();
    Get.context.bloc<EvaluationPageBloc>().add(Load(id));
  }

  @override
  Widget build(BuildContext context) {
    return foundation(
      child: BlocBuilder<EvaluationPageBloc, RoutePageState>(
          builder: (context, state) {
        if (state is Loaded) {
          if (state.data.containsKey('reloaded') != true) {
            return EvaluationPageBody(
              eval: state.data['eval'],
              subject: state.data['subject'],
            );
          } else {
            Get.context.bloc<EvaluationPageBloc>().add(Load(id));
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
      }),
    );
  }

  Widget foundation({Widget child}) {
    if (widget.asPage) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.lightBlueAccent,
          ),
          backgroundColor: Colors.lightBlueAccent,
          body: RoutePageFoundation(child: child));
    } else {
      return Ink(
          padding: EdgeInsets.all(8.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.sp),
            color: Get.theme.cardColor,
          ),
          child: child);
    }
  }
}

class EvaluationPageBody extends StatelessWidget {
  final Evaluation eval;
  final Subject subject;

  const EvaluationPageBody({
    this.eval,
    this.subject,
  });

  @override
  Widget build(BuildContext context) {
    //print(rows);
    return EvaluationPageInfobox(eval, subject);
  }
}
