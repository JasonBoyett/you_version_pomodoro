import 'package:flutter/material.dart';
import 'package:tomato_timer/models/models.dart';
import 'package:tomato_timer/pages/settings/widgets/widgets.dart';
import 'package:tomato_timer/providers/providers.dart';

Widget mobileDialog({
  required PomodoroModel pomodoroModel,
  required SettingsModel settingsModel,
  required BuildContext context,
  required void Function(bool) openSetter,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Center(
                  child: Text(
                "Settings",
                style: TextStyle(
                  color: PomodoroUI.textDark,
                  fontStyle: PomodoroUI.sans.fontStyle,
                  fontWeight: FontWeight.bold,
                ),
                textScaler: const TextScaler.linear(1.5),
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: IconButton(
                color: PomodoroUI.textMidDark,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
              ),
            ),
          ],
        ),
        Divider(
          color: PomodoroUI.dividerColor,
          thickness: 2,
        ),
        sectionTitle("time (minutes)"),
        timePicker(PomodoroStages.work, settingsModel),
        timePicker(PomodoroStages.shortBreak, settingsModel),
        timePicker(PomodoroStages.longBreak, settingsModel),
        Divider(
          color: PomodoroUI.dividerColor,
          thickness: 2,
          indent: 25,
          endIndent: 25,
        ),
        sectionTitle("font"),
        Center(child: fontPickers(settingsModel, context)),
        Divider(
          color: PomodoroUI.dividerColor,
          thickness: 2,
          indent: 25,
          endIndent: 25,
        ),
        sectionTitle("color"),
        Center(child: colorPickers(settingsModel, context)),
        Divider(
          color: PomodoroUI.dividerColor,
          thickness: 2,
          indent: 25,
          endIndent: 25,
        ),
        sectionTitle("display"),
        booleanPicker(
          value: settingsModel.isShowingSeconds,
          onToggle: (value) {
            settingsModel.setIsShowingSeconds(value);
          },
          color: settingsModel.themeColor.color,
          text: "Show seconds",
        ),
      ],
    ),
  );
}
