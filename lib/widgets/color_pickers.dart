import 'package:flutter/material.dart';
import 'package:tomato_timer/model/helper_types.dart';
import 'package:tomato_timer/model/settings.dart';
import 'package:tomato_timer/providers/ui.dart';

Widget colorPickers(SettingsModel settingsModel, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _colorButton(PomodoroColors.red, settingsModel, context),
      _colorButton(PomodoroColors.cyan, settingsModel, context),
      _colorButton(PomodoroColors.purple, settingsModel, context),
    ],
  );
}

Widget _colorButton(
  PomodoroColors color,
  SettingsModel settingsModel,
  BuildContext context,
) {
  return GestureDetector(
    onTap: () {
      settingsModel.setColor(color);
    },
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: PomodoroUI.circularPickerSize(context),
        height: PomodoroUI.circularPickerSize(context),
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
