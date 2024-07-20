import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum PomodoroColors {
  purple(Color.fromARGB(255, 216, 129, 248)),
  cyan(Color.fromARGB(255, 112, 243, 248)),
  red(Color.fromARGB(255, 248, 112, 112));

  const PomodoroColors(this.color);
  final Color color;
}

enum PomodoroFonts {
  serrif,
  mono,
  sans;
}

extension PomodoroFontsExstension on PomodoroFonts {
  TextStyle get font {
    switch (this) {
      case PomodoroFonts.serrif:
        return GoogleFonts.robotoSlab();
      case PomodoroFonts.mono:
        return GoogleFonts.spaceMono();
      case PomodoroFonts.sans:
        return GoogleFonts.kumbhSans();
    }
  }
}