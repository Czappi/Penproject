import 'package:flutter/material.dart';

class EvalTile extends StatelessWidget {
  final String value, id;
  const EvalTile({@required this.value, this.id});

  @override
  Widget build(BuildContext context) {
    return Text(value);
  }
}
