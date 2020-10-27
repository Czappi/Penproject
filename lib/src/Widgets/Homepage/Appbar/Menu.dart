import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class HomepageAppbarMenu extends StatefulWidget {
  final Stream<bool> opened;
  final Function onClose;
  final Function onOpen;
  HomepageAppbarMenu({this.opened, this.onClose, this.onOpen});

  @override
  _HomepageAppbarMenuState createState() => _HomepageAppbarMenuState();
}

class _HomepageAppbarMenuState extends State<HomepageAppbarMenu> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.opened,
        initialData: false,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          return IconButton(
              iconSize: 26,
              color: Get.isDarkMode ? Colors.grey[100] : Colors.black87,
              icon:
                  snapshot.data == false ? Icon(Feather.menu) : Icon(Feather.x),
              onPressed:
                  snapshot.data == true ? widget.onClose : widget.onOpen);
        });
  }
}
