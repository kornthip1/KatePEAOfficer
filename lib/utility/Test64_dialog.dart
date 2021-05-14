import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:katepeaofficer/widgets/show_image.dart';
import 'package:katepeaofficer/widgets/show_title.dart';

Future<Null> test64Dialog(
    BuildContext context, String title, String base64Str) async {
  Uint8List uint8list = base64Decode(base64Str);

  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: ListTile(
        leading: ShowImage(),
        title: ShowTitle(
          title: 'title',
          index: 0,
        ),
        subtitle: ShowTitle(title: 'message', index: 1),
      ),
      children: [
        Image.memory(uint8list),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('OK'),
        )
      ],
    ),
  );
}
