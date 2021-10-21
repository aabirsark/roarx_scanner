import 'package:hive/hive.dart';
import 'package:rx_pdf/db/boxes.dart';
import 'package:rx_pdf/model/generated_pdf.dart';

class CRUDoperation {
  // This gonna add the data in db
  static addData(List<String> paths, String name, String pDFpath) {
    final GeneratedPdf pdfData = GeneratedPdf()
      ..path = paths
      ..name = name
      ..pDFpath = pDFpath;

    final Box<GeneratedPdf> box = Boxes.box;

    try {
      box.add(pdfData);
    } catch (e) {
      print(e);
    }
  }

  // this gonna delete the data in db
  static delData(GeneratedPdf box) {
    box.delete();
  }
}
