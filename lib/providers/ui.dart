import 'package:device_type/device_type.dart';
import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
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

  static Size applyButtonSize = const Size(140, 53);

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
    var device = DeviceType.getDeviceType(context);
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    // The library I'm using returns raw strings to represent the device type.
    // Let it be known that I hate this and that I wish it returned an enum.
    return device == 'Tablet'
        ? Size(
            width * 0.703,
            // TODO: the commented out line below is the original value. Change it back once tablet UI is set up
            // height * 0.479,
            height * 0.623,
          )
        : Size(
            width * 0.872,
            height * 0.862,
          );
  }

  static settingsDialogSizeInner(BuildContext context) {
    var device = DeviceType.getDeviceType(context);
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    // enums are a thing library authors.
    return device == 'Tablet'
        ? Size(
            width * 0.703,
            // TODO: the commented out line below is the original value. Change it back once tablet UI is set up
            // height * 0.453,
            height * 0.6,
          )
        : Size(
            width * 0.872,
            height * 0.823,
          );
  }

  // ui functions
  static bool isTablet(BuildContext context) {
    var device = DeviceType.getDeviceType(context);
    // Again, I hate this.
    // Library authors, please use enums.
    // If this library was on GitHub, I'd make a PR to fix this madness.
    return device == 'Tablet';
  }
}
