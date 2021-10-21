import 'package:hive/hive.dart';
import 'package:rx_pdf/model/generated_pdf.dart';

class Boxes {
  static String boxName = "history";

  static Box<GeneratedPdf> get box => Hive.box<GeneratedPdf>(boxName);
}
