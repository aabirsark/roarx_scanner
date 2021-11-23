import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:rx_pdf/extension/context_ext.dart';

class PreviewImageCard extends StatelessWidget {
  const PreviewImageCard({
    Key? key,
    required this.file,
  }) : super(key: key);

  final XFile file;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(top: context.responsive(10)),
      height: context.responsive(600),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: FadeInImage(
          placeholder: AssetImage("assets/logo.png"),
          image: FileImage(File(file.path))),
    );
  }
}
