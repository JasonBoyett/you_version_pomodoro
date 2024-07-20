import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';

const int secondsInMinute = 60;

class PomodoroModel extends ChangeNotifier {
  static const int _breaksTillLongBreak = 4;
  PomodoroStages _previousStage = PomodoroStages.preStart;

  int breakTimeShort = 5; //5
  int breakTimelong = 20; //20
  int workTime = 25; //25
  int breakCount = 0;
  int secondsInStage = 0;
  PomodoroStages currentStage = PomodoroStages.preStart;
  PomodoroColors themeColor = PomodoroColors.cyan;
  PomodoroFonts themeFont = PomodoroFonts.serrif;

  PomodoroModel();
  PomodoroModel.withSettings({
    this.breakTimeShort = 5,
    this.breakTimelong = 20,
    this.workTime = 25,
    this.themeColor = PomodoroColors.cyan,
    this.themeFont = PomodoroFonts.serrif,
  });

  /// sets the current pomodoro step to the next in the sequence
  /// if the timer is paused, it will not increment
  void _incrementStage() {
    switch (currentStage) {
      case PomodoroStages.preStart:
        currentStage = PomodoroStages.work;
        secondsInStage = workTime * secondsInMinute;
        _previousStage = PomodoroStages.preStart;
        break;
      case PomodoroStages.work:
        breakCount++;
        if (breakCount >= _breaksTillLongBreak) {
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

  void set(int? workTime, int? breakTimeShort, int? breakTimelong) {
    if (workTime != null) {
      this.workTime = workTime;
    }
    if (breakTimeShort != null) {
      this.breakTimeShort = breakTimeShort;
    }
    if (breakTimelong != null) {
      this.breakTimelong = breakTimelong;
    }
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

  String getTimerString() {
    int seconds = currentStage == PomodoroStages.preStart
        ? workTime * secondsInMinute
        : secondsInStage;
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  /// returns the progress of the current stage as a double between 0 and 1
  double getProgress() {
    if (currentStage == PomodoroStages.preStart) {
      return 1.0;
    }
    int stageMinutes = _evaluateStageTime();
    double stageTime = stageMinutes.toDouble() * secondsInMinute;
    return (secondsInStage / stageTime).clamp(0.0, 1.0);
  }

  int _evaluateStageTime() {
    if (currentStage == PomodoroStages.preStart) {
      return workTime;
    }
    if (currentStage == PomodoroStages.paused) {
      switch (getPreviosStage()) {
        case PomodoroStages.work:
          return workTime;
        case PomodoroStages.shortBreak:
          return breakTimeShort;
        case PomodoroStages.longBreak:
          return breakTimelong;
        default:
          return 0;
      }
    }
    switch (currentStage) {
      case PomodoroStages.work:
        return workTime;
      case PomodoroStages.shortBreak:
        return breakTimeShort;
      case PomodoroStages.longBreak:
        return breakTimelong;
      default:
        return 0;
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
        _incrementStage();
      }
    });
  }

  // The figma spec that this app is based on shows three stages that can be
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
}

enum PomodoroStages { work, shortBreak, longBreak, preStart, paused }

extension PomodoroExtension on PomodoroStages {
  String get name {
    switch (this) {
      case PomodoroStages.work:
        return 'pomodoro';
      case PomodoroStages.shortBreak:
        return 'short break';
      case PomodoroStages.longBreak:
        return 'long break';
      case PomodoroStages.preStart:
        return 'start';
      case PomodoroStages.paused:
        return 'paused';
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
  serrif,
  mono,
  sans;
}

extension PomodoroFontsExstension on PomodoroFonts {
  TextStyle get font {
    switch (this) {
      case PomodoroFonts.serrif:
        return GoogleFonts.robotoSlab();
      case PomodoroFonts.mono:
        return GoogleFonts.spaceMono();
      case PomodoroFonts.sans:
        return GoogleFonts.kumbhSans();
    }
  }
}
