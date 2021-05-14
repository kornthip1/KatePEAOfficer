import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:katepeaofficer/models/information_model.dart';
import 'package:katepeaofficer/models/user_model.dart';
import 'package:katepeaofficer/utility/dialog.dart';
import 'package:katepeaofficer/utility/my_constant.dart';
import 'package:katepeaofficer/widgets/show_image.dart';
import 'package:katepeaofficer/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  double size;
  bool remember = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildImage(),
                buildAppName(),
                buildUser(),
                buildPassword(),
                buildRemember(),
                buildLogin(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildLogin() {
    return Container(
      width: size * 0.6,
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState.validate()) {
            print('NO Space');
            checkAuthen(userController.text, passwordController.text);
          }
        },
        child: Text('123'),
      ),
    );
  }

  Future<Null> checkAuthen(String user, String password) async {
    print('## user = $user , password = $password');
    String api =
        'https://wesafe.pea.co.th/webservicejson/api/values/GetUser/$user';
        print('############  api ===>> $api');
    await Dio().get(api).then(
      (value) async {
        
        print('###  value = $value');
        for (var item in value.data) {
            UserModel model = UserModel.fromMap(item);
            if (password == model.password) {
              print('### Remember  $remember');
              if (remember) {
                //Temporary  wait Real API Login
                String path =
                    'https://wesafe.pea.co.th/webservicejson/api/values/job/${model.employedid}';
                print('######  path ===>> $path');
                await Dio().get(path).then((value) async {
                  print('###### value ====>>>  $value');
                  for (var item in value.data) {
                    InformationModel informationModel =
                        InformationModel.fromJson(item);
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    preferences.setString(
                        MyConstant.keyFIRSTNAME, informationModel.fIRSTNAME);
                    preferences.setString(
                        MyConstant.keyLASTNAME, informationModel.lASTNAME);
                    preferences.setString(
                        MyConstant.keyEmployedid, informationModel.eMPLOYEEID);
                    preferences.setString(
                        MyConstant.keyDEPTNAME, informationModel.dEPTNAME);
                    preferences.setString(
                        MyConstant.keyREGIONCODE, informationModel.rEGIONCODE);
                    preferences.setString(
                        MyConstant.keyTEAM, informationModel.tEAM);

                    routeToService();
                  }
                });
              } else {
                routeToService();
              }
            } else {
              normalDialog(context, 'password False',
                  'Please try again Password False!');
            }
          }//end for
      },
    ).catchError((onError)=>normalDialog(context, 'User False', 'try again'));
  }

  void routeToService() {
    Navigator.pushNamedAndRemoveUntil(context, '/myservice', (route) => false);
  }

  Container buildRemember() {
    return Container(
      width: size * 0.6,
      child: CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        title: ShowTitle(
          title: 'Remember Me',
          index: 1,
        ),
        value: remember,
        onChanged: (value) {
          setState(() {
            remember = value;
            print('#### remember = $remember');
          });
        },
      ),
    );
  }

  Container buildUser() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: size * 0.6,
      child: TextFormField(
        controller: userController,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please fill User';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.perm_identity),
          labelText: 'User :',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Container buildPassword() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: size * 0.6,
      child: TextFormField(
        controller: passwordController,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please fill password';
          } else {
            return null;
          }
        },
        obscureText: true,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock_outline),
          labelText: 'Password :',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  ShowTitle buildAppName() => ShowTitle(
        title: MyConstant.appName,
        index: 0,
      );

  Container buildImage() {
    return Container(
      width: size * 0.6,
      child: ShowImage(),
    );
  }
}
