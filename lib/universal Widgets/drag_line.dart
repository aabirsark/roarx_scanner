import 'package:flutter/material.dart';
import 'package:rx_pdf/extension/context_ext.dart';

class DragLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = context.screenSize.width * 0.2;

    return Container(
      width: width,
      height: context.responsive(3),
      decoration: ShapeDecoration(
        shape: StadiumBorder(),
        color: context.primaryColor == Colors.white
            ? Colors.black45
            : Colors.white38,
      ),
    );
  }
}
