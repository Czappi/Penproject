import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penproject/src/Bloc/Auth/Bloc.dart';
import 'package:penproject/src/Bloc/Auth/Event.dart';
import 'package:penproject/src/Models/School.dart';
import 'package:penproject/src/Models/User.dart';
import 'package:penproject/src/Utils/SchoolController.dart';
import 'package:penproject/src/Widgets/Auth/Login/SchoolSelect.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreenLoginForm extends StatefulWidget {
  final String username, password;
  final School school;
  AuthScreenLoginForm({this.username, this.password, this.school});

  @override
  _AuthScreenLoginFormState createState() => _AuthScreenLoginFormState();
}

class _AuthScreenLoginFormState extends State<AuthScreenLoginForm> {
  final _formKey = GlobalKey<FormState>();
  SchoolController schoolController = Get.find();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool schoolred = false;

  @override
  void initState() {
    schoolController.select(widget.school);
    if (widget.username != null) usernameController.text = widget.username;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: usernameController,
            //initialValue: widget.username ?? null,
            obscureText: false,
            decoration: InputDecoration(labelText: "username".tr),
            /*
            onChanged: (s) {
              username = s;
            },
            validator: (s) {
              if (s.isEmpty) {
                return 'loginempty'.tr;
              }
              return null;
            },*/
          ),
          TextFormField(
            controller: passwordController,
            //initialValue: widget.password ?? null,
            obscureText: true,
            decoration: InputDecoration(labelText: "password".tr),
            /*onChanged: (s) {
              password = s;
            },
            validator: (s) {
              if (s.isEmpty) {
                return 'loginempty'.tr;
              }
              return null;
            },*/
          ),
          SizedBox(
            height: 10.h,
          ),
          FlatButton(
              onPressed: () {
                Get.to(SchoolSelect());
              },
              child: Text(
                schoolController.school != null
                    ? schoolController.school.name
                    : 'schoolselect'.tr,
                style: schoolred == false
                    ? Get.textTheme.bodyText2
                    : Get.textTheme.bodyText2.apply(
                        color: Colors.redAccent,
                      ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )),
          SizedBox(
            height: 10.h,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: FlatButton(
                shape: RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                color: Colors.blue,
                padding: EdgeInsets.all(10.0),
                splashColor: Colors.blueAccent,
                onPressed: () {
                  var validate = _formKey.currentState.validate();
                  if (validate && schoolController.school != null) {
                    var username = usernameController.text;
                    var password = passwordController.text;
                    print(
                        "$username - $password - ${schoolController.school.id}");
                    Get.context.bloc<AuthBloc>().add(LoginAuth(User(
                        username: username,
                        password: password,
                        instituteCode: schoolController.school.id)));
                  } else if (schoolController.school == null) {
                    setState(() {
                      schoolred = true;
                    });
                  }
                },
                child: Text(
                  'login'.tr,
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .apply(fontSizeFactor: 1.2),
                )),
          )
        ],
      ),
    );
  }
}
