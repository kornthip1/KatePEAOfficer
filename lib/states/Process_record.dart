import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:katepeaofficer/models/record_model.dart';
import 'package:katepeaofficer/widgets/show_icon_image.dart';
import 'package:katepeaofficer/widgets/show_title.dart';
import 'package:katepeaofficer/widgets/type2_widget.dart';

class ProcessRecord extends StatefulWidget {
  final List<RecordModel> recordModels;
  final String nameRecord;
  final String idDoc;
  //final String types;
  ProcessRecord({
    @required this.recordModels,
    @required this.nameRecord,
    @required this.idDoc,
    //@required this.idDoc,
  });
  @override
  _ProcessRecordState createState() => _ProcessRecordState();
}

class _ProcessRecordState extends State<ProcessRecord> {
  List<RecordModel> recordModels;
  int amountStep;
  int processStep = 0;
  String nameJob;
  double size;
  String choose;
  String idDoc;

  List<Widget> widgets = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recordModels = widget.recordModels;
    nameJob = widget.nameRecord;
    idDoc = widget.idDoc;
    amountStep = recordModels.length;

    for (var item in recordModels) {
      Widget myWidget = createType(item);
      setState(() {
        widgets.add(myWidget);
      });
    }
  }

  Widget createType(RecordModel recordModel) {
    switch (int.parse(recordModel.type)) {
      case 1:
        return type1(recordModel);
        break;
      case 2:
        return Type2Widget(
          recordModel: recordModel,
          nameJob: nameJob,
          idJob: idDoc,
        );
        break;
      case 3:
        return type3(recordModel);
        break;
      case 4:
        return type4(recordModel);
        break;
      default:
        return type0();
        break;
    }
  }

  Widget type0() => Text('No Job.');
  Widget type1(RecordModel model) => Column(
        children: [
          ShowTitle(
            title: model.menuChecklistName,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Check'),
          ),
        ],
      );

  Widget type3(RecordModel model) => Column(
        children: [
          ShowTitle(
            title: model.menuChecklistName,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildFormRecord(),
            ],
          ),
        ],
      );
  Widget type4(RecordModel model) {
    return Column(
      children: [
        ShowTitle(
          title: model.menuChecklistName,
        ),
        Row(
          children: [
            Container(
              width: 250,
              child: RadioListTile(
                value: '1',
                groupValue: choose,
                onChanged: (value) {
                  setState(() {
                    choose = value;
                  });
                },
                title: ShowTitle(
                  title: model.menuChecklistName,
                ),
              ),
            ),
            Container(
              width: 250,
              child: RadioListTile(
                value: '0',
                groupValue: choose,
                onChanged: (value) {
                  setState(() {
                    choose = value;
                  });
                },
                title: ShowTitle(
                  title: 'ไม่ต้อง ${model.menuChecklistName}',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildFormRecord() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.book_online),
          labelText: 'บันทึกข้อความ :',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: ElevatedButton(
          onPressed: () {
            setState(() {
              if (processStep < amountStep - 1) {
                processStep++;
              }
            });
          },
          child: Text('Next')),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(nameJob),
            Text('Step ${processStep + 1}/$amountStep'),
          ],
        ),
      ),
      body: widgets[processStep],
    );
  }
}
