import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rx_pdf/extension/context_ext.dart';
import 'package:provider/provider.dart';
import 'package:rx_pdf/core/providers.dart';
import 'package:rx_pdf/screens/camera/redeigned/widgets/overlay_Buttons.dart';
import 'package:rx_pdf/screens/camera/widgets/BottomSheetWidgets/image_preview_bottom_sheet.dart';
import 'package:rx_pdf/screens/preview/xFilePreview/xFilePreview.dart';
import 'package:rx_pdf/utils/constant.dart';

class CameraRx extends StatefulWidget {
  CameraRx({Key? key}) : super(key: key);

  @override
  _CameraRxState createState() => _CameraRxState();
}

class _CameraRxState extends State<CameraRx> {
  late CameraController _cameraController;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  _initializeController() {
    _cameraController =
        CameraController(CameraUtility.cameras![0], ResolutionPreset.veryHigh);
    _cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {
        print(_cameraController.value.aspectRatio);
      });
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  double getPerfectAspectRatio(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var camera = _cameraController.value;

    var scale = size.aspectRatio * camera.aspectRatio;

    // to prevent scaling down, invert the value
    if (scale < 1) scale = 1 / scale;

    return scale;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Center(
                child: Stack(
              alignment: Alignment.center,
              children: [
                _cameraController.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: 1 / _cameraController.value.aspectRatio,
                        child: CameraPreview(_cameraController))
                    : Container(),
                ControllerInherited(
                    controller: _cameraController, child: OverlayButtons())
              ],
            )),
          ],
        ));
  }
}

class ControllerInherited extends InheritedWidget {
  ControllerInherited(
      {Key? key, required this.controller, required Widget child})
      : super(key: key, child: child);

  final CameraController controller;

  static ControllerInherited of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ControllerInherited>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
