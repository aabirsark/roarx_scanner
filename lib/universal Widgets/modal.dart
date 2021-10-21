import 'package:flutter/material.dart';
import 'package:rx_pdf/extension/context_ext.dart';
import 'package:rx_pdf/universal%20Widgets/drag_line.dart';

class Modal extends StatelessWidget {
  const Modal({Key? key, required this.child}) : super(key: key);
  static const Radius _borderRadius = Radius.circular(30.0);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: context.responsive(14)),
      decoration: BoxDecoration(
        color: context.primaryColor == Colors.white
            ? Colors.grey.shade200
            : Colors.grey.shade900,
        borderRadius: BorderRadius.only(
          topLeft: _borderRadius,
          topRight: _borderRadius,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          DragLine(),
          child,
        ],
      ),
    );
  }
}
