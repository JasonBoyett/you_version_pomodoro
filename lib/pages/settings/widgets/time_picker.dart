import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tomato_timer/models/models.dart';
import 'package:tomato_timer/providers/providers.dart';

Widget timePicker(PomodoroStages stage, SettingsModel settingsModel,
    {bool? isTablet}) {
  isTablet ??= false;
  return isTablet
      ? Column(
          children: [
            Center(
              child: SizedBox(
                width: 100,
                child: Text(
                  _ditermineStageText(stage),
                  style: TextStyle(
                    fontStyle: GoogleFonts.kumbhSans().fontStyle,
                    fontWeight: FontWeight.bold,
                    color: PomodoroUI.textMidDark,
                  ),
                ),
              ),
            ),
            _picker(
              stage: stage,
              settingsModel: settingsModel,
            )
          ],
        )
      : Padding(
          padding: const EdgeInsets.only(left: 20.0, bottom: 6.0),
          child: Row(
            children: [
              Center(
                child: SizedBox(
                  width: 100,
                  child: Text(
                    _ditermineStageText(stage),
                    style: TextStyle(
                      fontStyle: GoogleFonts.kumbhSans().fontStyle,
                      fontWeight: FontWeight.bold,
                      color: PomodoroUI.textMidDark,
                    ),
                  ),
                ),
              ),
              _picker(
                stage: stage,
                settingsModel: settingsModel,
              )
            ],
          ),
        );
}

Widget _picker({
  required PomodoroStages stage,
  required SettingsModel settingsModel,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 40),
    child: SizedBox(
      height: 40,
      width: 140,
      child: Container(
        decoration: BoxDecoration(
          color: PomodoroUI.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 80.0),
                child: Text(
                  settingsModel.getStageTime(stage).toString(),
                  style: TextStyle(
                    color: PomodoroUI.textDark,
                    fontStyle: GoogleFonts.kumbhSans().fontStyle,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            _pickerButtons(
              stage: stage,
              settingsModel: settingsModel,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _pickerButtons({
  required PomodoroStages stage,
  required SettingsModel settingsModel,
}) {
  return Column(
    children: [
      _arrowButton(Icons.keyboard_arrow_up, () {
        settingsModel.incrementStageTime(stage);
      }),
      _arrowButton(Icons.keyboard_arrow_down, () {
        settingsModel.decrementStageTime(stage);
      }),
    ],
  );
}

// IconButton wasn't playing nice with the row allignment so I made a custom
// implementation simmilar to IconButton. I'm guessing it's much simpler than the
// version that ships with materail design and therefore it doesn't
// have whatever junk is causing the allignment issues.
Widget _arrowButton(IconData icon, void Function() onPressed) {
  return GestureDetector(
    onTap: onPressed,
    child: Icon(
      color: PomodoroUI.textMidDark,
      size: 20,
      icon,
    ),
  );
}

// helper functions

String _ditermineStageText(PomodoroStages stage) {
  switch (stage) {
    case PomodoroStages.work:
      return "pomodoro";
    case PomodoroStages.shortBreak:
      return "short break";
    case PomodoroStages.longBreak:
      return "long break";
    default:
      return "Work";
  }
}
