import 'package:flutter/material.dart';
import 'package:tomato_timer/model/helper_types.dart';

import '../model/pomodoro.dart';

Widget stageIndicator(PomodoroModel value) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 22, 25, 50),
        borderRadius: BorderRadius.circular(80),
      ),
      width: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _indicatorCell(value, PomodoroStages.work),
          _indicatorCell(value, PomodoroStages.shortBreak),
          _indicatorCell(value, PomodoroStages.longBreak),
        ],
      ),
    ),
  );
}

Widget _indicatorCell(PomodoroModel value, PomodoroStages stage) {
  return Padding(
    padding: const EdgeInsets.all(2.0),
    child: Container(
      decoration: BoxDecoration(
        color: _determineDisplayStage(value) == stage
            ? value.themeColor.color
            : Colors.transparent,
        borderRadius: BorderRadius.circular(80),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          stage.name,
          style: TextStyle(
            fontFamily: value.themeFont.font.fontFamily,
            color: stage == _determineDisplayStage(value)
                ? const Color.fromARGB(255, 22, 25, 50)
                : const Color.fromARGB(255, 215, 224, 255),
            fontWeight: FontWeight.bold,
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
