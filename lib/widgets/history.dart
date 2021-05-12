import 'package:flutter/material.dart';

class History extends StatefulWidget {
  final String employedid;
  History({@required this.employedid});

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  String employedid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    employedid = widget.employedid;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('This is History  employedid ==> $employedid'),
    );
  }
}
