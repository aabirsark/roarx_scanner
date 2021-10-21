import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyThemes {
  static ThemeData get lightTheme => ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      canvasColor: Colors.black,
      primarySwatch: Colors.red,
      fontFamily: GoogleFonts.ptSans().fontFamily,
      appBarTheme: AppBarTheme(
          elevation: 0.0, color: Colors.transparent, centerTitle: true),
      primaryColorLight: Colors.white54);

  static ThemeData get darkTheme => ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      primarySwatch: Colors.red,
      canvasColor: Colors.white,
      fontFamily: GoogleFonts.ptSans().fontFamily,
      appBarTheme: AppBarTheme(
          elevation: 0.0, color: Colors.transparent, centerTitle: true),
      primaryColorLight: Colors.black54);
}
