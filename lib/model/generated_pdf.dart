import 'package:hive/hive.dart';

part 'generated_pdf.g.dart';

@HiveType(typeId: 0)
class GeneratedPdf extends HiveObject {
  @HiveField(0)
  List<String>? path;

  @HiveField(1)
  String? name;

  @HiveField(2)
  DateTime dateTime = DateTime.now();

  @HiveField(3)
  String? pDFpath;
}
