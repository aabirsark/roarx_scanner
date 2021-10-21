import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:rx_pdf/extension/context_ext.dart';

class CustomCameraPreview extends StatelessWidget {
  const CustomCameraPreview({
    Key? key,
    required this.cameraController,
  }) : super(key: key);

  final CameraController cameraController;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: context.responsive(550),
        child: Center(
            child: Container(
                clipBehavior: Clip.antiAlias,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: CameraPreview(cameraController))));
  }
}
