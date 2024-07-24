import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
              color: const Color.fromARGB(255, 30, 33, 63),
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
