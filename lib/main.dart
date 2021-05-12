import 'package:flutter/material.dart';
import 'package:katepeaofficer/states/authen.dart';
import 'package:katepeaofficer/states/my_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/myservice' : (BuildContext context)=> MyService(),
};


String initialRoute;

Future<Null> main()async{
  
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();  // ประกาศเครื่องมือที่จะใช้
  String employedid = preferences.getString('employedid'); // ฝั่งค่าไว้บน แอป 
  if (employedid == null) {
    initialRoute = '/authen';
    runApp(MyApp());
  } else {
    initialRoute = '/myservice';
    runApp(MyApp());
  }


}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: map,
      initialRoute: initialRoute,
      theme: ThemeData(primarySwatch: Colors.purple),
    );
  }
}