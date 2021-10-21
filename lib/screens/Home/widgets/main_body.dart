import 'dart:io';

import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rx_pdf/db/boxes.dart';
import 'package:rx_pdf/model/generated_pdf.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rx_pdf/screens/Home/widgets/rename_bottom_sheet.dart';
import 'package:rx_pdf/screens/Home/widgets/slidable_custom_widgets.dart';
import 'package:share/share.dart';
import 'package:open_file/open_file.dart';
import 'package:rx_pdf/extension/context_ext.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MainBody extends StatelessWidget {
  const MainBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40, left: 20),
          child: Text(
            "My Documents",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        ValueListenableBuilder<Box<GeneratedPdf>>(
          valueListenable: Boxes.box.listenable(),
          builder: (context, value, child) {
            List<GeneratedPdf> data =
                value.values.cast<GeneratedPdf>().toList().reversed.toList();
            return RootWidget(data: data);
          },
        ).expanded,
      ],
    );
  }
}

class RootWidget extends StatelessWidget {
  const RootWidget({Key? key, required this.data}) : super(key: key);

  final List<GeneratedPdf> data;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: data.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        GeneratedPdf sepData = data.elementAt(index);
        return Slidable(
            key: Key(sepData.key.toString()),
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.18,
            secondaryActions: [
              SlideAction(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) => RenameBottomSheet(
                        db: sepData,
                      ),
                    );
                  },
                  child: SlidableCustomWidget(iconData: Icons.edit_outlined)),
              SlideAction(
                child: SlidableCustomWidget(iconData: CupertinoIcons.delete),
                onTap: () {
                  File(sepData.pDFpath!).deleteSync();
                  sepData.delete();
                },
              ),
              SlideAction(
                child: SlidableCustomWidget(iconData: CupertinoIcons.share),
                onTap: () {
                  Share.shareFiles(
                    [sepData.pDFpath!],
                  );
                },
              ),
            ],
            child: Tile(sepData: sepData));
      },
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
        child: Container(
          height: 1,
          decoration: ShapeDecoration(
            shape: StadiumBorder(),
            // color: Colors.white38,
          ),
          width: double.infinity,
        ),
      ),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.sepData,
  }) : super(key: key);

  final GeneratedPdf sepData;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () {
          OpenFile.open(sepData.pDFpath!);
        },
        leading: CircleAvatar(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          radius: 23,
          child: Text(
            sepData.name!.substring(0, 1).toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        title: Text(
          sepData.name ?? "",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
            "${sepData.path!.length} ${sepData.path!.length == 1 ? "Page" : "Pages"}"),
        trailing: Text(DateFormat("dd/MM/yy").format(sepData.dateTime)));
  }
}
