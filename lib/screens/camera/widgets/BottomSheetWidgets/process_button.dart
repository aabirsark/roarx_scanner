import 'package:flutter/material.dart';
import 'package:rx_pdf/extension/context_ext.dart';

class ProcessButton extends StatelessWidget {
  const ProcessButton(
      {Key? key, required this.color, required this.child, required this.onTap})
      : super(key: key);

  final Color color;

  final Widget child;

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: context.responsive(170),
        height: context.responsive(50),
        margin: EdgeInsets.symmetric(vertical: context.responsive(16)),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: color == Colors.transparent
                    ? Colors.redAccent
                    : Colors.transparent)),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
