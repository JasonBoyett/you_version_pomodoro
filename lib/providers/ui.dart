import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

@immutable
class PomodoroUI {
  // ui colors
  static Color backgroundColor = const Color.fromARGB(255, 22, 25, 50);
  static Color textLight = const Color.fromARGB(255, 215, 224, 255);
  static Color textDark = const Color.fromARGB(255, 22, 25, 50);
  static Color textMidDark = const Color.fromARGB(255, 30, 33, 63);
  static Color dividerColor = const Color.fromRGBO(227, 225, 225, 1);
  static Color cyan = const Color.fromARGB(255, 112, 243, 248);
  static Color red = const Color.fromARGB(255, 248, 112, 112);
  static Color purple = const Color.fromARGB(255, 216, 129, 248);
  static Color white = const Color.fromARGB(255, 255, 255, 255);
  static Color grey = const Color.fromARGB(255, 239, 241, 250);
  static Color black = const Color.fromARGB(255, 0, 0, 0);

  // fonts
  static TextStyle sans = GoogleFonts.kumbhSans();
  static TextStyle mono = GoogleFonts.spaceMono();
  static TextStyle serif = GoogleFonts.robotoSlab();

  // sizes
  static double circularPickerSize = 40;

  static TextScaler stageIndicatorFontScaler(BuildContext context) =>
      MediaQuery.of(context).size.width < 400
          ? const TextScaler.linear(0.9)
          : const TextScaler.linear(1);

  // complex ui styles

  static BoxShadow timerShadow = const BoxShadow(
    color: Color.fromARGB(125, 29, 44, 90),
    offset: Offset(-50, -50),
    blurRadius: 50,
  );

  static LinearGradient timerGradient = const LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topCenter,
    colors: [
      Color.fromARGB(255, 46, 50, 90),
      Color.fromARGB(255, 14, 17, 42),
    ],
  );

  static settingsDialogSizeOuter(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Size(width * 0.8, height * 0.8);
  }
}
