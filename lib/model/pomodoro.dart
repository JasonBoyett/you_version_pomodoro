import 'package:flutter/material.dart';
import 'dart:async';

const int secondsInMinute = 60;

class PomodoroModel extends ChangeNotifier {
  int breakTimeShort = 5;
  int breakTimelong = 20;
  int workTime = 1;
  int breakCount = 0;
  int breaksTillLongBreak = 4;
  int secondsInStage = 0;
  PomodoroStages currentStage = PomodoroStages.preStart;
  PomodoroStages _previousStage = PomodoroStages.preStart;
  PomodoroColors themeColor = PomodoroColors.red;
  PomodoroFonts themeFont = PomodoroFonts.sans;

  PomodoroModel();

  /// sets the current pomodoro step to the next in the sequence
  /// if the timer is paused, it will not increment
  void incrementStage() {
    switch (currentStage) {
      case PomodoroStages.preStart:
        currentStage = PomodoroStages.work;
        secondsInStage = workTime * secondsInMinute;
        _previousStage = PomodoroStages.preStart;
        break;
      case PomodoroStages.work:
        breakCount++;
        if (breakCount >= breaksTillLongBreak) {
          currentStage = PomodoroStages.longBreak;
          secondsInStage = breakTimelong * secondsInMinute;
          _previousStage = PomodoroStages.work;
          breakCount = 0;
        } else {
          currentStage = PomodoroStages.shortBreak;
          _previousStage = PomodoroStages.work;
          secondsInStage = breakTimeShort * secondsInMinute;
        }
        break;
      case PomodoroStages.shortBreak:
        currentStage = PomodoroStages.work;
        secondsInStage = workTime * secondsInMinute;
        _previousStage = PomodoroStages.shortBreak;
        break;
      case PomodoroStages.longBreak:
        currentStage = PomodoroStages.work;
        secondsInStage = workTime * secondsInMinute;
        _previousStage = PomodoroStages.longBreak;
        break;
      case PomodoroStages.paused:
        break;
    }
    notifyListeners();
  }

  //setters for the timer state and settings
  void setStage(PomodoroStages stage) {
    currentStage = stage;
    notifyListeners();
  }

  void setWorkTime(int minutes) {
    workTime = minutes;
    notifyListeners();
  }

  setBreakTimeShort(int minutes) {
    breakTimeShort = minutes;
    notifyListeners();
  }

  setBreakTimeLong(int minutes) {
    breakTimelong = minutes;
    notifyListeners();
  }

  setBreaksTillLongBreak(int breaks) {
    breaksTillLongBreak = breaks;
    notifyListeners();
  }

  //setters for the theme state and settings
  void setThemeColor(PomodoroColors color) {
    themeColor = color;
    notifyListeners();
  }

  void setThemeFont(PomodoroFonts font) {
    themeFont = font;
    notifyListeners();
  }

  //getters
  PomodoroStages getPreviosStage() => _previousStage;

  // The figma model that this app is based on shows three stages that can be
  // displayed: work, short break, and long break. But the model I am using to
  // control the state of the app has five stages, the same as above plus preStart
  // and paused. This function maps the five stages to the three stages that can
  // be displayed in the UI.
  PomodoroStages getDisplayedStage(PomodoroModel pomProps) {
    switch (pomProps.currentStage) {
      case PomodoroStages.work:
        return PomodoroStages.work;
      case PomodoroStages.shortBreak:
        return PomodoroStages.shortBreak;
      case PomodoroStages.longBreak:
        return PomodoroStages.longBreak;
      case PomodoroStages.preStart:
        return PomodoroStages.work;
      case PomodoroStages.paused:
        return pomProps.getPreviosStage();
    }
  }

  // control functions
  void reset() {
    breakCount = 0;
    secondsInStage = 0;
    currentStage = PomodoroStages.preStart;
    notifyListeners();
  }

  void pause() {
    _previousStage = currentStage;
    currentStage = PomodoroStages.paused;
    notifyListeners();
  }

  void resume() {
    currentStage = _previousStage;
    _previousStage = PomodoroStages.paused;
    notifyListeners();
  }

  void start() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (currentStage == PomodoroStages.paused) {
        return;
      }
      if (secondsInStage > 0) {
        secondsInStage--;
        notifyListeners();
      } else {
        incrementStage();
      }
    });
  }
}

enum PomodoroStages { work, shortBreak, longBreak, preStart, paused }

extension PomodoroExtension on PomodoroStages {
  String get name {
    switch (this) {
      case PomodoroStages.work:
        return 'Pomodoro';
      case PomodoroStages.shortBreak:
        return 'Short Break';
      case PomodoroStages.longBreak:
        return 'Long Break';
      case PomodoroStages.preStart:
        return 'Start';
      case PomodoroStages.paused:
        return 'Paused';
    }
  }
}

enum PomodoroColors {
  purple(Color.fromARGB(255, 216, 129, 248)),
  cyan(Color.fromARGB(255, 112, 243, 248)),
  red(Color.fromARGB(255, 248, 112, 112));

  const PomodoroColors(this.color);
  final Color color;
}

enum PomodoroFonts {
  serrif('Roboto Slab'),
  mono('Space Mono'),
  sans('Kumbh Sans');

  const PomodoroFonts(this.font);
  final String font;
}
