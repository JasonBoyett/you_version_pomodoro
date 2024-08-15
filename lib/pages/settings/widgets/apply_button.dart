import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tomato_timer/models/models.dart';
import 'package:tomato_timer/pages/home/home.dart';
import 'package:tomato_timer/pages/settings/settings.dart';
import 'package:tomato_timer/providers/providers.dart';

class ApplyButton extends ConsumerWidget {
  const ApplyButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var pomodoroModel = ref.watch(pomodoroProvider);
    var settingsModel = ref.watch(settingsProvider);
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
}
