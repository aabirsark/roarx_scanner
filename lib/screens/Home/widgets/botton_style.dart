import 'package:flutter/material.dart';

class ProcessButton extends StatelessWidget {
  ProcessButton(
      {Key? key, required this.label, required this.title, required this.onTap})
      : super(key: key);

  final Icon label;
  final String title;

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Center(
          child: Row(
            children: [label, SizedBox(width: 5), Text(title)],
          ),
        ),
      ),
    );
  }
}
