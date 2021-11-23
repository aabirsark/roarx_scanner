import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rx_pdf/extension/context_ext.dart';
import 'package:rx_pdf/utils/colors.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _compresserON = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        title: Text(
          "Settings",
          // style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () {
              context.navigateBack();
            },
            icon: Icon(
              CupertinoIcons.left_chevron,
              // color: Colors.black,
            )),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
            onTap: () {
              setState(() {
                _compresserON = !_compresserON;
              });
            },
            title: Text("Image Compresser"),
            subtitle: Text(
                "Note : Turning off the compresser may increase the file size"),
            trailing: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  color: _compresserON ? Colors.green : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: _compresserON ? Colors.white : Colors.red)),
            ),
          ),
          Spacer(),
          Text(
            "App designed and made by Aabir Sarkar",
            style: TextStyle(color: Colors.white38),
            textScaleFactor: .9,
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
