import 'package:flutter/material.dart';
import 'package:rx_pdf/extension/context_ext.dart';

class InputContainer extends StatelessWidget {
  const InputContainer({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: TextFormField(
        validator: (value) {
          if (value == null || value == "" || value == " ") {
            return "Field can't be empty";
          }
        },
        controller: controller,
        autofocus: true,
        style: TextStyle(fontSize: context.responsive(22)),
        cursorColor: Colors.redAccent,
        decoration:
            InputDecoration(hintText: "File Name...", border: InputBorder.none),
      ),
    );
  }
}
