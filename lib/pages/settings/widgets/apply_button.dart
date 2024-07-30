import 'package:flutter/material.dart';
import 'package:tomato_timer/models/models.dart';
import 'package:tomato_timer/providers/providers.dart';

Widget applyButton({
  required BuildContext context,
  required SettingsModel settingsModel,
  required PomodoroModel pomodoroModel,
  required PreferenceLoader loader,
}) {
  return Positioned.fill(
    child: Align(
      alignment: Alignment.bottomCenter,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: settingsModel.themeColor.color,
          foregroundColor: Colors.white,
          fixedSize: PomodoroUI.applyButtonSize,
        ),
        onPressed: () {
          pomodoroModel.setWorkTime(
            settingsModel.getStageTime(
              PomodoroStages.work,
            ),
          );
          pomodoroModel.setBreakTimeLong(
            settingsModel.getStageTime(
              PomodoroStages.longBreak,
            ),
          );
          pomodoroModel.setBreakTimeShort(
            settingsModel.getStageTime(
              PomodoroStages.shortBreak,
            ),
          );
          pomodoroModel.setIsShowingSeconds(
            settingsModel.isShowingSeconds,
          );
          pomodoroModel.setThemeColor(settingsModel.themeColor);
          pomodoroModel.setThemeFont(settingsModel.themeFont);
          loader.save(pomodoroModel);
          Navigator.of(context).pop();
        },
        onLongPress: () {
          settingsModel.hardReset();
          pomodoroModel.preferencesReset();
          loader.save(pomodoroModel);
          Navigator.of(context).pop();
        },
        child: Text(
          "Apply",
          style: TextStyle(
            fontStyle: PomodoroUI.sans.fontStyle,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            shadows: const [
              Shadow(
                color: Colors.black,
                blurRadius: 1,
                offset: Offset(0.2, 0.2),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
