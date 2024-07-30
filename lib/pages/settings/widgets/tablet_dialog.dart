import 'package:flutter/material.dart';
import 'package:tomato_timer/models/models.dart';
import 'package:tomato_timer/pages/settings/widgets/widgets.dart';
import 'package:tomato_timer/providers/providers.dart';

Widget tabletDialog({
  required PomodoroModel pomodoroModel,
  required SettingsModel settingsModel,
  required BuildContext context,
  required void Function(bool) openSetter,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      color: Colors.white,
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                top: 8.0,
              ),
              child: Center(
                  child: Text(
                "Settings",
                style: TextStyle(
                  color: PomodoroUI.textDark,
                  fontStyle: PomodoroUI.sans.fontStyle,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 4.0,
                bottom: 4.0,
              ),
              child: sectionTitle("time (minutes)", center: false),
            ),
            Row(
              children: [
                timePicker(
                  PomodoroStages.work,
                  settingsModel,
                  isTablet: true,
                ),
                timePicker(
                  PomodoroStages.shortBreak,
                  settingsModel,
                  isTablet: true,
                ),
                timePicker(
                  PomodoroStages.longBreak,
                  settingsModel,
                  isTablet: true,
                ),
              ],
            ),
          ],
        ),
        Divider(
          color: PomodoroUI.dividerColor,
          thickness: 2,
          indent: 25,
          endIndent: 25,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 4.0,
            bottom: 4.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              sectionTitle("font"),
              fontPickers(settingsModel, context),
            ],
          ),
        ),
        Divider(
          color: PomodoroUI.dividerColor,
          thickness: 2,
          indent: 25,
          endIndent: 25,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 4.0,
            bottom: 4.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              sectionTitle("color"),
              colorPickers(settingsModel, context),
            ],
          ),
        ),
        Divider(
          color: PomodoroUI.dividerColor,
          thickness: 2,
          indent: 25,
          endIndent: 25,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 4.0,
            bottom: 4.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sectionTitle("display", center: false),
              booleanPicker(
                value: settingsModel.isShowingSeconds,
                isTablet: true,
                onToggle: (value) {
                  settingsModel.setIsShowingSeconds(value);
                },
                color: settingsModel.themeColor.color,
                text: "Show seconds",
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
