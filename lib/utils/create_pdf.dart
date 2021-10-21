import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:images_picker/images_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:rx_pdf/extension/context_ext.dart';
import 'package:provider/provider.dart';
import 'package:rx_pdf/core/providers.dart';
import 'package:rx_pdf/db/crud_operation.dart';
import 'package:rx_pdf/utils/path_providerss.dart';

void createPdfFromMedia(
    List<Media> medias, String title, BuildContext context) async {
  context.read<MediaImages>().resetValue();
  context.navigateBack();
  final pdf = pw.Document();
  List<String> paths = [];

  //
  for (var i in medias) {
    paths.add(i.path);
    final image = pw.MemoryImage(
      File(i.path).readAsBytesSync(),
    );

    final dec = pw.BoxDecoration(
        image: pw.DecorationImage(image: image, fit: pw.BoxFit.contain));

    // ? Adding {Page}
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.zero,
        build: (pw.Context context) {
          return pw.Column(children: [
            pw.Expanded(
              child: pw.Center(
                  child: pw.Container(
                      decoration: dec,
                      height: double.infinity,
                      width: double.infinity)),
            ),
            pw.SizedBox(height: 5),
            pw.Text("Scanned by RoarX scanner",
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.Text("App designed and made by Aabir Sarkar",
                style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColor.fromInt(0xFF616161),
                    fontSize: 8)),
            pw.SizedBox(height: 5),
          ]); // Center
        }));
  }

  final path = await localPath;
  final file = File("$path/${title.replaceAll(" ", "_")}.pdf");
  await file.writeAsBytes(await pdf.save());
  print(file.path);
  CRUDoperation.addData(paths, title, file.path);
  print("completed");
}

void createPDFfromXFile(
    List<XFile> files, String title, BuildContext context) async {
  context.read<CameraImages>().resetValue();
  context.navigateBack();
  final pdf = pw.Document();
  List<String> paths = [];

  for (var i in files) {
    paths.add(i.path);
    final image = pw.MemoryImage(
      File(i.path).readAsBytesSync(),
    );

    final dec = pw.BoxDecoration(
        image: pw.DecorationImage(image: image, fit: pw.BoxFit.contain));

    // ? Adding {Page}
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.zero,
        build: (pw.Context context) {
          return pw.Column(children: [
            pw.Expanded(
              child: pw.Center(
                  child: pw.Container(
                      decoration: dec,
                      height: double.infinity,
                      width: double.infinity)),
            ),
            pw.SizedBox(height: 5),
            pw.Text("Scanned by RoarX scanner",
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.Text("App designed and made by Aabir Sarkar",
                style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColor.fromInt(0xFF616161),
                    fontSize: 8)),
            pw.SizedBox(height: 5),
          ]);
          // Center
        }));
  }

  final path = await localPath;
  final file = File("$path/${title.replaceAll(" ", "_")}.pdf");
  await file.writeAsBytes(await pdf.save());
  print(file.path);
  CRUDoperation.addData(paths, title, file.path);
}
