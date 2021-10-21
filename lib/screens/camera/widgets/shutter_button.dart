import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:rx_pdf/screens/camera/widgets/BottomSheetWidgets/image_preview_bottom_sheet.dart';
import 'package:rx_pdf/extension/context_ext.dart';

class ShutterButton extends StatelessWidget {
  ShutterButton({
    Key? key,
    required this.cameraController,
  }) : super(key: key);

  final CameraController cameraController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        XFile image = await cameraController.takePicture();
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => ImgPreviewBottomSheet(image),
        );
      },
      child: Container(
        height: context.responsive(75),
        width: context.responsive(75),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.redAccent,
        ),
        child: Icon(
          Icons.camera,
          color: Colors.white,
          size: context.responsive(30),
        ),
      ),
    );
  }
}
