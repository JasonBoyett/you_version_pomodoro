import 'package:flutter/material.dart';
import 'package:tomato_timer/model/helper_types.dart';
import 'package:tomato_timer/model/settings.dart';

Widget fontPickers(SettingsModel settingsModel) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _fontButton(PomodoroFonts.serrif, settingsModel),
      _fontButton(PomodoroFonts.mono, settingsModel),
      _fontButton(PomodoroFonts.sans, settingsModel),
    ],
  );
}

Widget _fontButton(PomodoroFonts font, SettingsModel settingsModel) {
  return GestureDetector(
    onTap: () {
      settingsModel.setFont(font);
    },
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: 60,
        height: 60,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: settingsModel.themeFont == font
                ? Colors.black
                : const Color.fromARGB(255, 239, 241, 250),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            "Aa",
            style: settingsModel.themeFont == font
                ? _letterStyle(font, Colors.white)
                : _letterStyle(font, Colors.black),
          ),
        ),
      ),
    ),
  );
}

TextStyle _letterStyle(PomodoroFonts font, Color color) {
  var base = font.font;
  return base.merge(TextStyle(
    color: color,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ));
}
