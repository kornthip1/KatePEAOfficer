import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:katepeaofficer/models/information_model.dart';
import 'package:katepeaofficer/utility/my_constant.dart';
import 'package:katepeaofficer/widgets/check_job.dart';
import 'package:katepeaofficer/widgets/history.dart';
import 'package:katepeaofficer/widgets/record_job.dart';
import 'package:katepeaofficer/widgets/show_man.dart';
import 'package:katepeaofficer/widgets/show_progress.dart';
import 'package:katepeaofficer/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  InformationModel informationModel;
  List<Widget> widgets = [];
  int index = 0;
  List<String> titles = [
    'บันทึกงานใหม่',
    'ประวัติการทำงาน',
    'ตรวจสอบสถานะการทำงาน',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readdata();
  }

  Future<Null> readdata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String employedid = preferences.getString(MyConstant.keyEmployedid);

    String apiInformation =
        'https://wesafe.pea.co.th/webservicejson/api/values/job/$employedid';
    await Dio().get(apiInformation).then((value) {
      print('### value ==> $value');
      for (var item in value.data) {
        setState(() {
          informationModel = InformationModel.fromJson(item);

          widgets.add(RecordJob(
            model: informationModel,
          ));
          widgets.add(History(
            employedid: employedid,
          ));

          widgets.add(CheckJob(
            employedid: employedid,
          ));
        });
        print('### name = ${informationModel.fIRSTNAME}');
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[index]),
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            Column(
              children: [
                buildUserAccountsDrawerHeader(),
                buildMenuRecord(context),
                buildListHistory(context),
                buildMenuCheckJob(context),
              ],
            ),
            buildSignOut(),
          ],
        ),
      ),
      body: informationModel == null ? ShowProgress() : widgets[index],
    );
  }

  ListTile buildMenuRecord(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.date_range,
        size: 36,
        color: MyConstant.primart,
      ),
      title: ShowTitle(
        title: 'บันทึกงานใหม่',
        index: 1,
      ),
      onTap: () {
        setState(() {
          index = 0;
        });
        Navigator.pop(context);
      },
    );
  }

  ListTile buildListHistory(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.dashboard,
        size: 36,
        color: MyConstant.primart,
      ),
      title: ShowTitle(
        title: 'ประวัติการทำงาน',
        index: 1,
      ),
      onTap: () {
        setState(() {
          index = 1;
        });
        Navigator.pop(context);
      },
    );
  }

  ListTile buildMenuCheckJob(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.check_circle_outline,
        size: 36,
        color: MyConstant.primart,
      ),
      title: ShowTitle(
        title: 'ตรวจสอบ',
        index: 1,
      ),
      subtitle: ShowTitle(title: 'ตรวจสอบสถานะงาน/ปิดงาน'),
      onTap: () {
        setState(() {
          index = 2;
        });
        Navigator.pop(context);
      },
    );
  }

  UserAccountsDrawerHeader buildUserAccountsDrawerHeader() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(color: MyConstant.primart),
      currentAccountPicture: ShowMan(),
      accountName: informationModel == null
          ? Text('Name')
          : Text('${informationModel.fIRSTNAME}  ${informationModel.lASTNAME}'),
      accountEmail: informationModel == null
          ? Text('Position')
          : Text('ตำแหน่ง  :  ${informationModel.dEPTNAME}'),
    );
  }

  Column buildSignOut() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListTile(
          onTap: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.clear();

            Navigator.pushNamedAndRemoveUntil(
                context, '/authen', (route) => false);
          },
          tileColor: Colors.red[900],
          leading: Icon(
            Icons.exit_to_app,
            size: 36,
            color: Colors.white,
          ),
          title: ShowTitle(
            title: 'Sign out',
            index: 3,
          ),
        ),
      ],
    );
  }
}
