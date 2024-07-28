import 'package:flutter/material.dart';
import 'package:tomato_timer/models/models.dart';
import 'package:tomato_timer/providers/providers.dart';

Widget stageIndicator(PomodoroModel value, BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(top: 12, bottom: 12, left: 2, right: 2),
    padding: const EdgeInsets.only(top: 12, bottom: 12, left: 2, right: 2),
    decoration: BoxDecoration(
      color: PomodoroUI.backgroundColor,
      borderRadius: BorderRadius.circular(80),
    ),
    width: 400,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _indicatorCell(value, PomodoroStages.work, context),
        _indicatorCell(value, PomodoroStages.shortBreak, context),
        _indicatorCell(value, PomodoroStages.longBreak, context),
      ],
    ),
  );
}

Widget _indicatorCell(
  PomodoroModel value,
  PomodoroStages stage,
  BuildContext context,
) {
  return Padding(
    padding: const EdgeInsets.all(1.0),
    child: GestureDetector(
      onTap: () {
        if (value.currentStage != PomodoroStages.preStart) {
          value.setStage(stage);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: _determineDisplayStage(value) == stage
              ? value.themeColor.color
              : Colors.transparent,
          borderRadius: BorderRadius.circular(80),
        ),
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Text(
            stage.name,
            textScaler: PomodoroUI.stageIndicatorFontScaler(context),
            style: TextStyle(
              fontFamily: value.themeFont.font.fontFamily,
              color: stage == _determineDisplayStage(value)
                  ? PomodoroUI.textDark
                  : PomodoroUI.textLight,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  );
}

PomodoroStages _determineDisplayStage(PomodoroModel value) {
  if (value.currentStage == PomodoroStages.preStart) {
    return PomodoroStages.work;
  }
  if (value.currentStage == PomodoroStages.paused) {
    return value.getPreviosStage();
  }
  return value.currentStage;
}
