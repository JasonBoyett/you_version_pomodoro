import 'package:flutter/material.dart';
import 'package:tomato_timer/models/models.dart';
import 'package:tomato_timer/providers/providers.dart';

Widget fontPickers(SettingsModel settingsModel, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _fontButton(PomodoroFonts.serrif, settingsModel, context),
      _fontButton(PomodoroFonts.mono, settingsModel, context),
      _fontButton(PomodoroFonts.sans, settingsModel, context),
    ],
  );
}

Widget _fontButton(
  PomodoroFonts font,
  SettingsModel settingsModel,
  BuildContext context,
) {
  return GestureDetector(
    onTap: () {
      settingsModel.setFont(font);
    },
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: PomodoroUI.circularPickerSize,
        height: PomodoroUI.circularPickerSize,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: settingsModel.themeFont == font
                ? PomodoroUI.black
                : PomodoroUI.grey,
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
