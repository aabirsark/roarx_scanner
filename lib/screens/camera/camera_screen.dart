import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';
import 'package:rx_pdf/core/providers.dart';
import 'package:rx_pdf/screens/camera/widgets/camera_preview_box.dart';
import 'package:rx_pdf/screens/camera/widgets/shutter_row.dart';
import 'package:rx_pdf/screens/preview/xFilePreview/xFilePreview.dart';
import 'package:rx_pdf/utils/constant.dart';
import 'package:rx_pdf/extension/context_ext.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  // ? Camera Controller
  late CameraController cameraController;

  @override
  void initState() {
    cameraController = CameraController(
      CameraUtility.cameras![0],
      ResolutionPreset.medium,
    );
    cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    cameraController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Camera",
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(
              CupertinoIcons.left_chevron,
              color: Colors.black,
            ),
            onPressed: () {
              context.read<CameraImages>().resetValue();
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                if (context.read<CameraImages>().cameraImages.isNotEmpty) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => XFilePreview(),
                      ));
                }
              },
              icon: Icon(Icons.done),
              color: Colors.black,
            )
          ],
        ),
        body: !cameraController.value.isInitialized
            ? Container()
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child:
                        CustomCameraPreview(cameraController: cameraController),
                  ),
                  ShutterRow(
                    cameraController: cameraController,
                  ).expanded
                ],
              ));
  }
}
