import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tomato_timer/model/settings.dart';

import '../model/helper_types.dart';

Widget timePicker(PomodoroStages stage, SettingsModel settingsModel) {
  return Container(
    padding: const EdgeInsets.all(8),
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
                color: const Color.fromARGB(255, 30, 33, 63),
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
          color: const Color.fromARGB(255, 239, 241, 250),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 80.0),
                child: Text(
                  settingsModel.getStageTime(stage).toString(),
                  style: TextStyle(
                    color: const Color.fromARGB(255, 30, 33, 63),
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

Widget _pickerButtons({
  required PomodoroStages stage,
  required SettingsModel settingsModel,
}) {
  return Row(
    children: [
      Column(
        children: [
          _arrowButton(Icons.keyboard_arrow_up, () {
            settingsModel.incrementStageTime(stage);
          }),
          _arrowButton(Icons.keyboard_arrow_down, () {
            settingsModel.decrementStageTime(stage);
          }),
        ],
      ),
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
      color: const Color.fromARGB(75, 30, 33, 63),
      size: 20,
      icon,
    ),
  );
}
