import 'dart:convert';
import 'dart:io' as Io;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:katepeaofficer/models/record_model.dart';
import 'package:katepeaofficer/utility/dialog.dart';
import 'package:katepeaofficer/widgets/show_icon_image.dart';
import 'package:katepeaofficer/widgets/show_title.dart';

class Type2Widget extends StatefulWidget {
  final RecordModel recordModel;
  final String nameJob;
  final String idJob;
  Type2Widget({
    @required this.recordModel,
    @required this.nameJob,
    @required this.idJob,
  });
  @override
  _Type2WidgetState createState() => _Type2WidgetState();
}

class _Type2WidgetState extends State<Type2Widget> {
  RecordModel model;
  List<File> files = [];
  int amountPic;
  String nameJob ,idJob;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = widget.recordModel;
    amountPic = model.quantityImg;
    nameJob = widget.nameJob;
    idJob = widget.idJob;
    print('########## idJob ===> $idJob ');
    for (var i = 0; i < amountPic; i++) {
      files.add(null);
    }
  }

  Future<Null> createImage(int index, ImageSource source) async {
    try {
      var object = await ImagePicker().getImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );

      setState(() {
        files[index] = File(object.path);
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShowTitle(
              title: model.menuChecklistName,
            ),
            ShowTitle(
              title: 'จำนวนรูป : $amountPic  รูป',
            ),
            Divider(
              thickness: 1,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: files.length,
              itemBuilder: (context, index) => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('${index + 1}'),
                      Container(
                        width: 120,
                        height: 120,
                        child: files[index] == null
                            ? ShowIconImage()
                            : Image.file(files[index]),
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.add_a_photo),
                            onPressed: () =>
                                createImage(index, ImageSource.camera),
                          ),
                          IconButton(
                            icon: Icon(Icons.add_photo_alternate),
                            onPressed: () =>
                                createImage(index, ImageSource.gallery),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                  ),
                ],
              ),
            ),
            buildUpload(),
          ],
        ),
      ),
    );
  }

  ElevatedButton buildUpload() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: Colors.lightBlue),
      onPressed: () {
        if (files[0] == null) {
          normalDialog(context, 'กรุณาบันทึกรูปที่ 1 ก่อน', 'รูปที่ 1 ต้องมี');
        } else {
          List<String> base64Strs = [];
          for (var item in files) {
            if (item != null) {
              List<int> imageBytes = Io.File(item.path).readAsBytesSync();
              String base64Str = base64Encode(imageBytes);
              // normalDialog(context, 'aaa', '$base64Str');
              //test64Dialog(context, 'teset', base64Str);
              base64Strs.add(base64Str);
            }
          }

          print('### base64Strs.length === > ${base64Strs.length}');
        }
      },
      child: Text('Upload Data'),
    );
  }
}
