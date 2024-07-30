import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tomato_timer/providers/providers.dart';

Widget sectionTitle(String title, {bool? center}) {
  center ??= false;
  return center
      ? Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              title.toUpperCase(),
              style: TextStyle(
                letterSpacing: 5,
                color: PomodoroUI.backgroundColor,
                fontStyle: GoogleFonts.kumbhSans().fontStyle,
                fontWeight: FontWeight.bold,
              ),
              textScaler: const TextScaler.linear(1),
            ),
          ),
        )
      : Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              letterSpacing: 5,
              color: PomodoroUI.backgroundColor,
              fontStyle: GoogleFonts.kumbhSans().fontStyle,
              fontWeight: FontWeight.bold,
            ),
            textScaler: const TextScaler.linear(1),
          ),
        );
}
