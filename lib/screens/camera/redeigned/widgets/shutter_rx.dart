import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:rx_pdf/core/providers.dart';
import 'package:rx_pdf/extension/context_ext.dart';
import 'package:provider/provider.dart';
import 'package:rx_pdf/screens/camera/redeigned/camera_redisgned.dart';
import 'package:rx_pdf/screens/camera/widgets/BottomSheetWidgets/image_preview_bottom_sheet.dart';

class ShutterRx extends StatelessWidget {
  const ShutterRx({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        context.read<CameraImages>().visibleState();
        try {
          final ControllerInherited _inhertied =
              ControllerInherited.of(context);
          XFile img = await _inhertied.controller.takePicture();
          print(img.path);
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => ImgPreviewBottomSheet(img),
          );
          context.read<CameraImages>().visibleState();
        } catch (e) {
          print(e);
        }
      },
      child: Container(
        height: 85,
        width: 85,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 7)),
      ),
    );
  }
}
