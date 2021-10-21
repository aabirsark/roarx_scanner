import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rx_pdf/core/providers.dart';
import 'package:rx_pdf/extension/context_ext.dart';
import 'package:provider/provider.dart';

class PreviewRow extends StatelessWidget {
  const PreviewRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: context.watch<CameraImages>().previewRowVisible,
      child: Container(
          height: 60,
          width: context.width - 20,
          // color: Colors.black,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              var img =
                  context.watch<CameraImages>().cameraImages.elementAt(index);
              if (index == 7) {
                return Container(
                  width: 60,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      color: context.secondryColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      "+${context.watch<CameraImages>().cameraImages.length - 7}",
                      textScaleFactor: 2,
                    ),
                  ),
                );
              }

              return Container(
                  clipBehavior: Clip.antiAlias,
                  width: 60,
                  decoration: BoxDecoration(
                      color: context.secondryColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Image.file(File(img.path), fit: BoxFit.cover));
            },
            itemCount: context.watch<CameraImages>().cameraImages.length < 8
                ? context.watch<CameraImages>().cameraImages.length
                : 8,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 5,
              );
            },
          )),
    );
  }
}
