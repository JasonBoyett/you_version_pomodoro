import 'package:tomato_timer/model/pomodoro.dart';
import 'package:tomato_timer/helpers.dart';
import 'package:flutter/material.dart';

Widget centerTimer(PomodoroModel value) {
  return Padding(
    padding: const EdgeInsets.all(40.0),
    child: Stack(alignment: Alignment.center, children: [
      SizedBox(
        height: 250,
        width: 250,
        child: CircularProgressIndicator(
          value: evaluateProgress(value),
          strokeCap: StrokeCap.round,
          strokeWidth: 8,
          color: value.themeColor.color,
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            style: TextStyle(
              color: const Color.fromARGB(255, 215, 224, 255),
              fontFamily: value.themeFont.font.fontFamily,
              fontWeight: FontWeight.bold,
            ),
            displayMinutesTimer(value.secondsInStage),
            textScaler: const TextScaler.linear(5.5),
          ),
          TextButton(
              onPressed: () {
                switch (value.currentStage) {
                  case PomodoroStages.paused:
                    value.resume();
                    break;
                  case PomodoroStages.preStart:
                    {
                      value.start();
                      break;
                    }
                  default:
                    {
                      value.pause();
                      break;
                    }
                }
              },
              child: Text(
                (() {
                  switch (value.currentStage) {
                    case PomodoroStages.paused:
                      return 'RESUME';
                    case PomodoroStages.preStart:
                      return 'START';
                    default:
                      return 'PAUSE';
                  }
                })(),
                style: TextStyle(
                  letterSpacing: 10,
                  color: const Color.fromARGB(255, 215, 224, 255),
                  fontFamily: value.themeFont.font.fontFamily,
                ),
                textScaler: const TextScaler.linear(1.25),
              )),
        ],
      ),
    ]),
  );
}
