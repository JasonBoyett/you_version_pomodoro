import 'package:flutter/material.dart';
import 'package:tomato_timer/model/helper_types.dart';
import 'package:tomato_timer/model/pomodoro.dart';

class SettingsModel extends ChangeNotifier {
  int breakTimeShort = 5;
  int breakTimeLong = 20;
  int workTime = 25;
  bool isShowingSeconds = true;
  PomodoroColors themeColor = PomodoroColors.cyan;
  PomodoroFonts themeFont = PomodoroFonts.serrif;

  // constructor
  SettingsModel({
    this.breakTimeShort = 5,
    this.breakTimeLong = 20,
    this.workTime = 25,
    this.themeColor = PomodoroColors.cyan,
    this.themeFont = PomodoroFonts.serrif,
    this.isShowingSeconds = true,
  });

  // setters
  void setWorkTime(int minutes) {
    if (minutes < 1) {
      return;
    }
    workTime = minutes;
    notifyListeners();
  }

  void setBreakTimeShort(int minutes) {
    if (minutes < 1) {
      return;
    }
    breakTimeShort = minutes;
    notifyListeners();
  }

  void setBreakTimeLong(int minutes) {
    if (minutes < 1) {
      return;
    }
    breakTimeLong = minutes;
    notifyListeners();
  }

  void setColor(PomodoroColors color) {
    themeColor = color;
    notifyListeners();
  }

  void setFont(PomodoroFonts font) {
    themeFont = font;
    notifyListeners();
  }

  void setIsShowingSeconds(bool value) {
    isShowingSeconds = value;
    notifyListeners();
  }

  void setFromPomodorModel(PomodoroModel model) {
    workTime = model.workTime;
    breakTimeShort = model.breakTimeShort;
    breakTimeLong = model.breakTimeLong;
    themeColor = model.themeColor;
    themeFont = model.themeFont;
    isShowingSeconds = model.isShowingSeconds;
    notifyListeners();
  }

  // getters
  int getStageTime(PomodoroStages stage) {
    switch (stage) {
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

  // control methods

  void incrementStageTime(PomodoroStages stage) {
    switch (stage) {
      case PomodoroStages.work:
        workTime++;
        break;
      case PomodoroStages.shortBreak:
        breakTimeShort++;
        break;
      case PomodoroStages.longBreak:
        breakTimeLong++;
        break;
      default:
        break;
    }
    notifyListeners();
  }

  void decrementStageTime(PomodoroStages stage) {
    switch (stage) {
      case PomodoroStages.work:
        setWorkTime(workTime - 1);
        break;
      case PomodoroStages.shortBreak:
        setBreakTimeShort(breakTimeShort - 1);
        break;
      case PomodoroStages.longBreak:
        setBreakTimeLong(breakTimeLong - 1);
        break;
      default:
        break;
    }
  }
}
