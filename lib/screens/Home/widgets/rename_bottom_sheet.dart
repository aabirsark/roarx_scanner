import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rx_pdf/model/generated_pdf.dart';
import 'package:rx_pdf/screens/Home/widgets/input_field.dart';
import 'package:rx_pdf/universal%20Widgets/modal.dart';
import 'package:rx_pdf/extension/context_ext.dart';
import 'package:rx_pdf/utils/path_providerss.dart';

class RenameBottomSheet extends StatefulWidget {
  const RenameBottomSheet({Key? key, required this.db}) : super(key: key);

  final GeneratedPdf db;

  @override
  State<RenameBottomSheet> createState() => _RenameBottomSheetState();
}

class _RenameBottomSheetState extends State<RenameBottomSheet> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController(text: widget.db.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets.bottom;
    final safeAreaBottom = MediaQuery.of(context).padding.bottom;
    return Modal(
      child: Flexible(
        child: Padding(
            padding: EdgeInsets.only(
              left: 26,
              right: 26,
              top: context.responsive(14),
              bottom: context.responsive(14) + viewInsets + safeAreaBottom,
            ),
            child: BottomSheetForm(
                textEditingController: _textEditingController, widget: widget)),
      ),
    );
  }
}

class BottomSheetForm extends StatelessWidget {
  const BottomSheetForm({
    Key? key,
    required TextEditingController textEditingController,
    required this.widget,
  })  : _textEditingController = textEditingController,
        super(key: key);

  final TextEditingController _textEditingController;
  final RenameBottomSheet widget;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Row(
        children: [
          InputContainer(controller: _textEditingController).expanded,
          SizedBox(
            width: 10,
          ),
          Container(
            height: 20,
            width: 1,
            color: Colors.grey.shade500,
          ),
          SizedBox(
            width: 10,
          ),
          IconButton(
              onPressed: () async {
                var sepData = widget.db;
                if (_textEditingController.text != "") {
                  final path = await localPath;
                  sepData..name = _textEditingController.text;

                  sepData.save();

                  File newFile = File(sepData.pDFpath!).renameSync(
                      "$path/${_textEditingController.text.replaceAll(" ", "_")}.pdf");

                  sepData..pDFpath = newFile.path;

                  sepData.save();
                }
                Navigator.pop(context);
              },
              icon: Icon(Icons.edit_outlined))
        ],
      ),
    );
  }

  void rename() async {
    
  }
}
