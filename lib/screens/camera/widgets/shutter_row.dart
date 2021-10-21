import 'dart:io';

import 'package:camera/camera.dart';
import 'package:provider/provider.dart';
import 'package:rx_pdf/core/providers.dart';
import 'package:rx_pdf/extension/context_ext.dart';

import 'package:flutter/material.dart';
import 'package:rx_pdf/screens/camera/widgets/shutter_button.dart';

class ShutterRow extends StatelessWidget {
  ShutterRow({
    Key? key,
    required this.cameraController,
  }) : super(key: key);

  final CameraController cameraController;

  @override
  Widget build(BuildContext context) {
    var list = context.watch<CameraImages>().cameraImages;
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: context.responsive(8.0),
          horizontal: context.responsive(25.0, axis: Axis.horizontal)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SmallPreviewImage(list: list),
          ShutterButton(cameraController: cameraController),
          Container(
              height: context.responsive(20), width: context.responsive(45))
        ],
      ),
    );
  }
}

class SmallPreviewImage extends StatelessWidget {
  const SmallPreviewImage({
    Key? key,
    required this.list,
  }) : super(key: key);

  final List<XFile> list;

  @override
  Widget build(BuildContext context) {
    return context.watch<CameraImages>().cameraImages.isNotEmpty
        ? Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(File(list[list.length - 1].path)))),
            height: context.responsive(45),
            width: context.responsive(45))
        : Container(
            height: context.responsive(20), width: context.responsive(45));
  }
}
