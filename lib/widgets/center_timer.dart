import 'package:tomato_timer/model/pomodoro.dart';
import 'package:flutter/material.dart';

Widget centerTimer(PomodoroModel model) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Stack(alignment: Alignment.center, children: [
      _backgroundCircle(),
      SizedBox(
        height: 300,
        width: 300,
        child: CircularProgressIndicator(
          value: model.getProgress(),
          strokeCap: StrokeCap.round,
          strokeWidth: 10,
          color: model.themeColor.color,
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              style: TextStyle(
                color: const Color.fromARGB(255, 215, 224, 255),
                fontFamily: model.themeFont.font.fontFamily,
                fontWeight: FontWeight.bold,
              ),
              model.getTimerString(),
              textScaler: const TextScaler.linear(6.5),
            ),
          ),
          TextButton(
              onLongPress: () {
                model.reset();
              },
              onPressed: () => _centerButtonAction(model),
              child: Text(
                _ditermineDisplayText(model),
                style: TextStyle(
                  letterSpacing: 10,
                  color: const Color.fromARGB(255, 215, 224, 255),
                  fontFamily: model.themeFont.font.fontFamily,
                ),
                textScaler: const TextScaler.linear(1.25),
              )),
        ],
      ),
    ]),
  );
}

void _centerButtonAction(PomodoroModel value) {
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
}

String _ditermineDisplayText(PomodoroModel value) {
  switch (value.currentStage) {
    case PomodoroStages.paused:
      return 'RESUME';
    case PomodoroStages.preStart:
      return 'START';
    default:
      return 'PAUSE';
  }
}

Widget _backgroundCircle() {
  return Stack(alignment: Alignment.center, children: [
    SizedBox(
      width: 365,
      height: 365,
      child: Container(
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topCenter,
              colors: [
                Color.fromARGB(255, 46, 50, 90),
                Color.fromARGB(255, 14, 17, 42),
              ],
            )),
      ),
    ),
    SizedBox(
      width: 330,
      height: 330,
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromARGB(255, 22, 25, 50),
        ),
      ),
    ),
  ]);
}
