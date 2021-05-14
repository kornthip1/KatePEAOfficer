import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:katepeaofficer/models/job_model.dart';
import 'package:katepeaofficer/models/record_model.dart';
import 'package:katepeaofficer/states/Process_record.dart';
import 'package:katepeaofficer/utility/my_constant.dart';
import 'package:katepeaofficer/widgets/show_icon_image.dart';
import 'package:katepeaofficer/widgets/show_image.dart';
import 'package:katepeaofficer/widgets/show_progress.dart';
import 'package:katepeaofficer/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecordNewJob extends StatefulWidget {
  final JobModel jobModel;
  RecordNewJob({@required this.jobModel});
  @override
  _RecordNewJobState createState() => _RecordNewJobState();
}

class _RecordNewJobState extends State<RecordNewJob> {
  //ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.arrow_downward), label: Text('Next'),),

  JobModel jobModel;
  bool load = true;
  double size;
  TextEditingController jobController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  List<RecordModel> recordModels = [];
  String deptName, dateTimeNow;
  List<String> chooses = [];
  int indexChoose = -1;

  String namejob;
  List<bool> vidibles = [];
  int indexVisible = 0;
  List<int> indexVisibles = [];
  String idDoc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jobModel = widget.jobModel;
    readData();
  }



  Future<Null> readData() async {
    SharedPreferences peferences = await SharedPreferences.getInstance();
    deptName = peferences.getString(MyConstant.keyDEPTNAME);
    DateTime dateTime = DateTime.now();
    dateTimeNow = dateTime.toString();

    String api =
        'https://wesafe.pea.co.th/webservicejson/api/values/Select_WorkCheckList/${jobModel.menuMainID},${jobModel.menuSubID}';
    await Dio().get(api).then((value) {
      for (var item in value.data) {
        RecordModel model = RecordModel.fromJson(item);

        setState(() {
          recordModels.add(model);
          load = false;
        });
      }

      indexVisible++;

      print('#### visible ===> $vidibles');
      setState(() {
        load = false;
      });
    });
  }

  Widget buildJob() {
    int i = Random().nextInt(100000);
    idDoc = 'pea$i';
    return Column(
      children: [
        Text('Test Id => $idDoc'),
        Form(
          key: formkey,
          child: Container(
            margin: EdgeInsets.only(top: 16),
            width: size * 0.6,
            child: TextFormField(
              controller: jobController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please fill Job';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.work_outline),
                labelText: 'New Job :',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(right: 30),
              child: ElevatedButton.icon(
                onPressed: () {
                  if (formkey.currentState.validate()) {
                    namejob = jobController.text;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProcessRecord(
                          recordModels: recordModels,
                          nameRecord: namejob,
                          idDoc: idDoc,
                        ),
                      ),
                    );
                  }
                },
                icon: Icon(Icons.arrow_right),
                label: Text('Next'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(jobModel.menuMainName),
      ),
      body: load ? ShowProgress() : buildContent(),
    );
  }

  Widget buildContent() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildHead(),
            buildSecond(),
            buildJob(),
            // namejob == null
            //     ? buildJob()
            //     : ShowTitle(
            //         title: 'Name Job => $namejob',
            //       ),
            // buildListView(),
          ],
        ),
      ),
    );
  }

  // Widget buildListView() {
  //   return Container(
  //     margin: EdgeInsets.all(16),
  //     child: ListView.builder(
  //       shrinkWrap: true,
  //       physics: ScrollPhysics(),
  //       itemCount: recordModels.length,
  //       itemBuilder: (context, index) => Card(
  //         child: Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               ShowTitle(
  //                 title: recordModels[index].menuChecklistName,
  //                 index: 1,
  //               ),
  //               createType(recordModels[index]),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Column buildSecond() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ShowTitle(
          title: deptName,
          index: 1,
        ),
        ShowTitle(
          title: dateTimeNow,
          index: 1,
        ),
      ],
    );
  }

  ShowTitle buildHead() {
    return ShowTitle(
      title: jobModel.menuSubName,
      index: 1,
    );
  }

 
  
  

  

  Widget type4(RecordModel model, int indexChooseType) {
    chooses.add(null);

    return Column(
      children: [
        ShowTitle(
          title: model.menuChecklistName,
        ),
        Row(
          children: [
            Container(
              width: size * 0.4,
              child: RadioListTile(
                value: '1',
                groupValue: chooses[indexChoose],
                onChanged: (value) {
                  setState(() {
                    chooses[indexChoose] = value;
                  });
                },
                title: ShowTitle(
                  title: model.menuChecklistName,
                ),
              ),
            ),
            Container(
              width: size * 0.4,
              child: RadioListTile(
                value: '0',
                groupValue: chooses[indexChoose],
                onChanged: (value) {
                  setState(() {
                    chooses[indexChoose] = value;
                  });
                },
                title: ShowTitle(
                  title: 'ไม่ต้อง ${model.menuChecklistName}',
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.arrow_downward),
              label: Text('Next'),
            ),
          ],
        ),
      ],
    );
  }

  int indexChooseType = -1;

  
}
