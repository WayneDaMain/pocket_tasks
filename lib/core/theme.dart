import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightTheme = ThemeData.light(useMaterial3: true).copyWith(
  textTheme: GoogleFonts.aBeeZeeTextTheme(ThemeData.light().textTheme),
);
final darkTheme = ThemeData.dark(
  useMaterial3: true,
).copyWith(textTheme: GoogleFonts.aBeeZeeTextTheme(ThemeData.dark().textTheme));
