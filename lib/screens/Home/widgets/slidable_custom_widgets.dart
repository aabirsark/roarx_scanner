import 'package:flutter/material.dart';
import 'package:rx_pdf/extension/context_ext.dart';

class SlidableCustomWidget extends StatelessWidget {
  const SlidableCustomWidget({Key? key, required this.iconData})
      : super(key: key);

  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: context.primaryColor == Colors.black
              ? Colors.grey.shade700
              : Colors.grey.shade300,
          shape: BoxShape.circle,
        ),
        child: Center(child: Icon(iconData)));
  }
}
