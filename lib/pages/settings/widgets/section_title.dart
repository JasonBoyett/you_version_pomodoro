import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tomato_timer/providers/providers.dart';

class SectionTitle extends StatelessWidget {
  final bool center;
  final String title;
  const SectionTitle(this.title, {this.center = false, super.key});

  @override
  Widget build(BuildContext context) {
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
}
