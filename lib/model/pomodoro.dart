import 'package:flutter/material.dart';
import 'dart:async';
import 'package:tomato_timer/model/helper_types.dart';
import 'package:tomato_timer/model/settings.dart';

const int secondsInMinute = 60;

class PomodoroModel extends ChangeNotifier {
  static const int _breaksTillLongBreak = 4;
  PomodoroStages _previousStage = PomodoroStages.preStart;
  int _breakCount = 0;
  Duration _timerDuration = const Duration(seconds: 0);
  Timer _timer = Timer(Duration.zero, () {});

  int breakTimeShort = 5;
  int breakTimeLong = 20;
  int workTime = 25;
  PomodoroStages currentStage = PomodoroStages.preStart;
  PomodoroColors themeColor = PomodoroColors.cyan;
  PomodoroFonts themeFont = PomodoroFonts.serrif;

  // constructors
  PomodoroModel();
  PomodoroModel.custom({
    this.breakTimeShort = 5,
    this.breakTimeLong = 20,
    this.workTime = 25,
    this.themeColor = PomodoroColors.cyan,
    this.themeFont = PomodoroFonts.serrif,
  });

  // setters for the timer state
  void setStage(PomodoroStages stage) {
    currentStage = stage;
    _timerDuration = (() {
      switch (stage) {
        case PomodoroStages.work:
          return Duration(minutes: workTime);
        case PomodoroStages.longBreak:
          return Duration(minutes: breakTimeLong);
        case PomodoroStages.shortBreak:
          return Duration(minutes: breakTimeShort);
        default:
          return const Duration(seconds: 0);
      }
    })();

    notifyListeners();
  }

  void setWorkTime(int minutes) {
    workTime = minutes;
    if (currentStage == PomodoroStages.work) {
      _timerDuration = Duration(minutes: minutes);
    }
    notifyListeners();
  }

  setBreakTimeShort(int minutes) {
    breakTimeShort = minutes;
    if (currentStage == PomodoroStages.shortBreak) {
      _timerDuration = Duration(minutes: minutes);
    }
    notifyListeners();
  }

  setBreakTimeLong(int minutes) {
    breakTimeLong = minutes;
    if (currentStage == PomodoroStages.longBreak) {
      _timerDuration = Duration(minutes: minutes);
    }
    notifyListeners();
  }

  // setters for the theme state
  void setThemeColor(PomodoroColors color) {
    themeColor = color;
    notifyListeners();
  }

  void setThemeFont(PomodoroFonts font) {
    themeFont = font;
    notifyListeners();
  }

  // chonky boi setter for everything at once
  void set(int? workTime, int? breakTimeShort, int? breakTimelong,
      PomodoroColors? color, PomodoroFonts? font) {
    if (workTime != null) {
      setWorkTime(workTime);
    }
    if (breakTimeShort != null) {
      setBreakTimeShort(breakTimeShort);
    }
    if (breakTimelong != null) {
      setBreakTimeLong(breakTimelong);
    }
    if (color != null) {
      setThemeColor(color);
    }
    if (font != null) {
      setThemeFont(font);
    }
    notifyListeners();
  }

  // getters
  PomodoroStages getPreviosStage() => _previousStage;

  String getTimerString() {
    if (currentStage == PomodoroStages.preStart) {
      return '$workTime:${'00'.padLeft(2, '0')}';
    }
    int minutes = _timerDuration.inMinutes;
    int remainingSeconds = _timerDuration.inSeconds.remainder(secondsInMinute);
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  /// returns the progress of the current stage as a double between 0 and 1
  double getProgress() {
    if (currentStage == PomodoroStages.preStart) {
      return 1.0;
    }
    int stageMinutes = _evaluateStageTime();
    double stageTime = stageMinutes.toDouble() * secondsInMinute;
    return (_timerDuration.inSeconds / stageTime).clamp(0.0, 1.0);
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
          return breakTimeLong;
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
        return breakTimeLong;
      default:
        return 0;
    }
  }

  // control functions

  /// sets the current pomodoro step to the next in the sequence
  /// if the timer is paused, it will not increment
  void _incrementStage() {
    switch (currentStage) {
      case PomodoroStages.preStart:
        currentStage = PomodoroStages.work;
        _timerDuration = Duration(minutes: workTime);
        _previousStage = PomodoroStages.preStart;
        break;
      case PomodoroStages.work:
        _breakCount++;
        if (_breakCount >= _breaksTillLongBreak) {
          currentStage = PomodoroStages.longBreak;
          _timerDuration = Duration(minutes: breakTimeLong);
          _previousStage = PomodoroStages.work;
          _breakCount = 0;
        } else {
          currentStage = PomodoroStages.shortBreak;
          _previousStage = PomodoroStages.work;
          _timerDuration = Duration(minutes: breakTimeShort);
        }
        break;
      case PomodoroStages.shortBreak:
        currentStage = PomodoroStages.work;
        _timerDuration = Duration(minutes: workTime);
        _previousStage = PomodoroStages.shortBreak;
        break;
      case PomodoroStages.longBreak:
        currentStage = PomodoroStages.work;
        _timerDuration = Duration(minutes: workTime);
        _previousStage = PomodoroStages.longBreak;
        break;
      case PomodoroStages.paused:
        break;
    }
    notifyListeners();
  }

  void reset() {
    _timer.cancel();
    _breakCount = 0;
    _timerDuration = const Duration(seconds: 0);
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
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (currentStage == PomodoroStages.paused) {
        return;
      }
      if (_timerDuration.inSeconds > 0) {
        _timerDuration -= const Duration(seconds: 1);
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
