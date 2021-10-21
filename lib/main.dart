import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:rx_pdf/core/providers.dart';
import 'package:rx_pdf/db/boxes.dart';
import 'package:rx_pdf/model/generated_pdf.dart';
import 'package:rx_pdf/screens/Home/home.dart';
import 'package:camera/camera.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rx_pdf/utils/constant.dart';
import 'package:rx_pdf/utils/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  CameraUtility.cameras = await availableCameras();

  await Hive.initFlutter();
  Hive.registerAdapter<GeneratedPdf>(GeneratedPdfAdapter());
  await Hive.openBox<GeneratedPdf>(Boxes.boxName);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => CameraImages(),
      ),
      ChangeNotifierProvider(
        create: (context) => MediaImages(),
      )
    ],
    child: const RxPDF(),
  ));
}

class RxPDF extends StatelessWidget {
  const RxPDF({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Roarx PDF",
      debugShowCheckedModeBanner: false,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      themeMode: ThemeMode.dark,
      home: Home(),
    );
  }
}
