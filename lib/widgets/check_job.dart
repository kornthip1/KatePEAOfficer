import 'package:flutter/material.dart';

class CheckJob extends StatefulWidget {
  final String employedid;
  CheckJob({@required this.employedid});

  @override
  _CheckJobState createState() => _CheckJobState();
}

class _CheckJobState extends State<CheckJob> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('This is Check Job'),
    );
  }
}
