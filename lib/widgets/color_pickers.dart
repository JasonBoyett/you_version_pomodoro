import 'package:flutter/material.dart';
import 'package:tomato_timer/model/helper_types.dart';
import 'package:tomato_timer/model/settings.dart';

Widget colorPickers(SettingsModel settingsModel) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _colorButton(PomodoroColors.red, settingsModel),
      _colorButton(PomodoroColors.cyan, settingsModel),
      _colorButton(PomodoroColors.purple, settingsModel),
    ],
  );
}

Widget _colorButton(PomodoroColors color, SettingsModel settingsModel) {
  return GestureDetector(
    onTap: () {
      settingsModel.setColor(color);
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
            color: color.color,
            borderRadius: BorderRadius.circular(100),
          ),
          child: settingsModel.themeColor == color
              ? const Icon(
                  Icons.check,
                  color: Colors.black,
                )
              : null,
        ),
      ),
    ),
  );
}
