import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData get darkTheme => ThemeData(
      primaryColor: Color(0xFF000000),
      backgroundColor: Color(0xFF000000),
      scaffoldBackgroundColor: Color(0xFF000000),
      bottomAppBarColor: Color(0xFF131313),
      cardColor: Colors.grey[900],
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(elevation: 0, brightness: Brightness.dark),
      textTheme: TextTheme(
        button: GoogleFonts.roboto(color: Colors.white),
        headline6: GoogleFonts.roboto(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        headline5: GoogleFonts.roboto(
            color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
        subtitle2: GoogleFonts.roboto(
            color: Colors.blueGrey[300],
            fontWeight: FontWeight.bold,
            fontSize: 12),
        bodyText2: GoogleFonts.roboto(color: Color(0xFFE6E6E6)),
      ),
      buttonColor: Color(0xff6c5dd3),
      disabledColor: Colors.grey,
      dividerColor: Colors.transparent,
    );

ThemeData get lightTheme => ThemeData(
    primaryColor: Color(0xfff4f5f9),
    backgroundColor: Color(0xFFf4f5f9),
    scaffoldBackgroundColor: Color(0xFFf4f5f9),
    cardColor: Colors.white,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(elevation: 0, brightness: Brightness.light),
    bottomAppBarColor: Colors.white,
    textTheme: TextTheme(
      button: GoogleFonts.roboto(color: Colors.white),
      headline6: GoogleFonts.roboto(
          color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 20),
      headline5: GoogleFonts.roboto(
          color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 16),
      subtitle2: GoogleFonts.roboto(
          color: Colors.blueGrey[300],
          fontWeight: FontWeight.bold,
          fontSize: 12),
      bodyText2: GoogleFonts.roboto(color: Colors.black54),
    ),
    buttonColor: Color(0xFF6c5dd3),
    disabledColor: Colors.grey,
    dividerColor: Colors.transparent);
