import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tomato_timer/providers/providers.dart';

Widget booleanPicker({
  required void Function(bool) onToggle,
  required bool value,
  required String text,
  required Color color,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Center(
        child: SizedBox(
          width: 150,
          child: Text(
            text,
            style: TextStyle(
              fontStyle: GoogleFonts.kumbhSans().fontStyle,
              fontWeight: FontWeight.bold,
              color: PomodoroUI.textMidDark,
            ),
          ),
        ),
      ),
      Switch(
        value: value,
        onChanged: onToggle,
        activeColor: color,
      ),
    ],
  );
}
