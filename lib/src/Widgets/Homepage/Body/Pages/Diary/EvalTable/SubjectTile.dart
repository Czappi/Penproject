import 'package:flutter/material.dart';

class SubjectTile extends StatelessWidget {
  final String value, id;
  const SubjectTile({@required this.value, this.id});

  @override
  Widget build(BuildContext context) {
    return Text(value);
  }
}
