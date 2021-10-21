import 'package:camera/camera.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:rx_pdf/core/providers.dart';
import 'package:rx_pdf/extension/context_ext.dart';
import 'package:rx_pdf/screens/camera/widgets/BottomSheetWidgets/process_button.dart';

class ProcessArea extends StatelessWidget {
  const ProcessArea({Key? key, required this.file}) : super(key: key);

  final XFile file;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ProcessButton(
          color: Colors.transparent,
          onTap: () {
            Navigator.pop(context);
          },
          child: Text(
            "Retake",
            style: TextStyle(
                color: Colors.redAccent, fontSize: context.responsive(18)),
          ),
        ),
        ProcessButton(
          color: Colors.green,
          onTap: () {
            context.read<CameraImages>().addValue(file);
            Navigator.pop(context);
          },
          child: Text(
            "Continue",
            style: TextStyle(
              color: Colors.white,
              fontSize: context.responsive(18),
            ),
          ),
        ),
      ],
    );
  }
}
