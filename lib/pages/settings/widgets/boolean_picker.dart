import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tomato_timer/providers/providers.dart';

Widget booleanPicker({
  required void Function(bool) onToggle,
  required bool value,
  required String text,
  required Color color,
  bool? isTablet,
}) {
  isTablet ??= false;
  return isTablet
      ? _tabletPicker(
          onToggle: onToggle,
          value: value,
          text: text,
          color: color,
        )
      : _mobilePicker(
          onToggle: onToggle,
          value: value,
          text: text,
          color: color,
        );
}

Widget _mobilePicker({
  required void Function(bool) onToggle,
  required bool value,
  required String text,
  required Color color,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
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
      Switch(
        value: value,
        onChanged: onToggle,
        activeColor: color,
      ),
    ],
  );
}

Widget _tabletPicker({
  required void Function(bool) onToggle,
  required bool value,
  required String text,
  required Color color,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                fontStyle: GoogleFonts.kumbhSans().fontStyle,
                fontWeight: FontWeight.bold,
                color: PomodoroUI.textMidDark,
              ),
            ),
            Switch(
              value: value,
              onChanged: onToggle,
              activeColor: color,
            ),
          ],
        ),
      ),
    ],
  );
}
