import 'package:flutter/material.dart';
import 'package:tomato_timer/model/helper_types.dart';
import 'package:tomato_timer/model/pomodoro.dart';

class SettingsModel extends ChangeNotifier {
  int breakTimeShort = 5;
  int breakTimeLong = 20;
  int workTime = 25;
  PomodoroColors themeColor = PomodoroColors.cyan;
  PomodoroFonts themeFont = PomodoroFonts.serrif;

  // constructor
  SettingsModel({
    this.breakTimeShort = 5,
    this.breakTimeLong = 20,
    this.workTime = 25,
    this.themeColor = PomodoroColors.cyan,
    this.themeFont = PomodoroFonts.serrif,
  });

  // setters
  void setWorkTime(int minutes) {
    workTime = minutes;
    notifyListeners();
  }

  void setBreakTimeShort(int minutes) {
    breakTimeShort = minutes;
    notifyListeners();
  }

  void setBreakTimeLong(int minutes) {
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

  void setFromPomodorModel(PomodoroModel model) {
    workTime = model.workTime;
    breakTimeShort = model.breakTimeShort;
    breakTimeLong = model.breakTimeLong;
    themeColor = model.themeColor;
    themeFont = model.themeFont;
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
        workTime--;
        break;
      case PomodoroStages.shortBreak:
        breakTimeShort--;
        break;
      case PomodoroStages.longBreak:
        breakTimeLong--;
        break;
      default:
        break;
    }
    notifyListeners();
  }
}
