import 'package:flutter/material.dart';
import 'dart:async';

const int secondsInMinute = 60;

class PomodoroModel extends ChangeNotifier {
  int breakTimeShort = 5;
  int breakTimelong = 20;
  int workTime = 25;
  int breakCount = 0;
  int breaksTillLongBreak = 4;
  int secondsInStage = 0;
  PomodoroStages currentStage = PomodoroStages.preStart;
  PomodoroStages _previousStage = PomodoroStages.preStart;
  PomodoroColors themeColor = PomodoroColors.blue;
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
        return 'Work';
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
  purple(Colors.purple),
  blue(Colors.blue),
  red(Colors.red);

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
