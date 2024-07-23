import 'package:flutter/material.dart';
import 'dart:async';
import 'package:tomato_timer/model/helper_types.dart';

const int secondsInMinute = 60;

class PomodoroModel extends ChangeNotifier {
  static const int _breaksTillLongBreak = 4;
  PomodoroStages _previousStage = PomodoroStages.preStart;
  int _breakCount = 0;
  Duration _remainingTime = const Duration(seconds: 0);
  Timer _timer = Timer(Duration.zero, () {});

  int _breakTimeShortAdjusted = 5;
  int _breakTimeLongAdjusted = 20;
  int _workTimeAdjusted = 25;

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
    _remainingTime = (() {
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

  Future _backgroundUpdateWorkTime(int minutes) async {
    while (currentStage != PomodoroStages.work) {
      await Future.delayed(const Duration(seconds: 1));
      if (currentStage == PomodoroStages.work) {
        break;
      }
    }
    workTime = minutes;
  }

  Future _backgroundUpdateShortBreakTime(int minutes) async {
    while (currentStage != PomodoroStages.shortBreak) {
      await Future.delayed(const Duration(seconds: 1));
      if (currentStage == PomodoroStages.shortBreak) {
        break;
      }
    }
    breakTimeShort = minutes;
  }

  Future _backgroundUpdateLongBreakTime(int minutes) async {
    while (currentStage != PomodoroStages.longBreak) {
      await Future.delayed(const Duration(seconds: 1));
      if (currentStage == PomodoroStages.longBreak) {
        break;
      }
    }
    breakTimeLong = minutes;
  }

  void setWorkTime(int minutes) {
    if (minutes < 1) {
      throw Exception();
    }
    if (minutes == workTime) {
      return;
    }
    if (currentStage == PomodoroStages.work) {
      _backgroundUpdateWorkTime(minutes);
      notifyListeners();
      return;
    }
    _workTimeAdjusted = minutes;
    workTime = minutes;
    notifyListeners();
  }

  void setBreakTimeShort(int minutes) {
    if (minutes < 1) {
      throw Exception();
    }
    if (minutes == breakTimeShort) {
      return;
    }
    if (currentStage == PomodoroStages.shortBreak) {
      _backgroundUpdateShortBreakTime(minutes);
      return;
    }
    _breakTimeShortAdjusted = minutes;
    breakTimeShort = minutes;
    notifyListeners();
    return;
  }

  void setBreakTimeLong(int minutes) async {
    if (minutes < 1) {
      throw Exception();
    }
    if (minutes == breakTimeLong) {
      return;
    }
    if (currentStage == PomodoroStages.longBreak) {
      _backgroundUpdateLongBreakTime(minutes);
      return;
    }
    _breakTimeLongAdjusted = minutes;
    breakTimeLong = minutes;
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
  Duration getRemainingtime() => _remainingTime;

  String getTimerString() {
    if (currentStage == PomodoroStages.preStart) {
      return '$workTime:${'00'.padLeft(2, '0')}';
    }
    if (_remainingTime.inSeconds < 0) {
      throw Exception('Timer reached Negative value');
    }
    int minutes = _remainingTime.inMinutes;
    int remainingSeconds = _remainingTime.inSeconds.remainder(secondsInMinute);
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  /// returns the progress of the current stage as a double between 0 and 1
  double getProgress() {
    if (currentStage == PomodoroStages.preStart) {
      return 1.0;
    }
    int stageMinutes = _evaluateStageTime();
    double stageTime = stageMinutes.toDouble() * secondsInMinute;
    return (_remainingTime.inSeconds / stageTime).clamp(0.0, 1.0);
  }

  int _evaluateStageTime() {
    if (currentStage == PomodoroStages.preStart) {
      return workTime;
    }
    if (currentStage == PomodoroStages.paused) {
      switch (getPreviosStage()) {
        case PomodoroStages.work:
          return _workTimeAdjusted;
        case PomodoroStages.shortBreak:
          return _breakTimeShortAdjusted;
        case PomodoroStages.longBreak:
          return _breakTimeLongAdjusted;
        default:
          return 0;
      }
    }
    switch (currentStage) {
      case PomodoroStages.work:
        return _workTimeAdjusted;
      case PomodoroStages.shortBreak:
        return _breakTimeShortAdjusted;
      case PomodoroStages.longBreak:
        return _breakTimeLongAdjusted;
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
        _remainingTime = Duration(minutes: workTime);
        _previousStage = PomodoroStages.preStart;
        break;
      case PomodoroStages.work:
        _breakCount++;
        if (_breakCount >= _breaksTillLongBreak) {
          currentStage = PomodoroStages.longBreak;
          _remainingTime = Duration(minutes: breakTimeLong);
          _previousStage = PomodoroStages.work;
          _breakCount = 0;
        } else {
          currentStage = PomodoroStages.shortBreak;
          _previousStage = PomodoroStages.work;
          _remainingTime = Duration(minutes: breakTimeShort);
        }
        break;
      case PomodoroStages.shortBreak:
        currentStage = PomodoroStages.work;
        _remainingTime = Duration(minutes: workTime);
        _previousStage = PomodoroStages.shortBreak;
        break;
      case PomodoroStages.longBreak:
        currentStage = PomodoroStages.work;
        _remainingTime = Duration(minutes: workTime);
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
    _remainingTime = const Duration(seconds: 0);
    currentStage = PomodoroStages.preStart;
    _workTimeAdjusted = workTime;
    _breakTimeShortAdjusted = breakTimeShort;
    _breakTimeLongAdjusted = breakTimeLong;
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
      if (_remainingTime.inSeconds > 0) {
        _remainingTime -= const Duration(seconds: 1);
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
