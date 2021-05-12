import 'package:flutter/material.dart';
import 'package:katepeaofficer/states/authen.dart';
import 'package:katepeaofficer/states/my_service.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/myservice' : (BuildContext context)=> MyService(),
};


String initialRoute;

void main(){
  initialRoute = '/authen';
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: map,
      initialRoute: initialRoute,
      theme: ThemeData(primarySwatch: Colors.yellow),
    );
  }
}