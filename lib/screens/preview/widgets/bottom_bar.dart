import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rx_pdf/screens/preview/widgets/icon_text_button.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key, required this.deleteOnTap}) : super(key: key);

  final void Function() deleteOnTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // IconTextButton(iconData: CupertinoIcons.refresh_bold, text: "Retake"),
        InkWell(
            onTap: deleteOnTap,
            child:
                IconTextButton(iconData: CupertinoIcons.delete, text: "Delete"))
      ],
    );
  }
}
