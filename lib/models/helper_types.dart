import 'package:flutter/material.dart';
import 'package:tomato_timer/providers/ui.dart';

enum PomodoroColors {
  purple,
  cyan,
  red;
}

extension PomodoroColorsExtension on PomodoroColors {
  Color get color {
    switch (this) {
      case PomodoroColors.purple:
        return PomodoroUI.purple;
      case PomodoroColors.cyan:
        return PomodoroUI.cyan;
      case PomodoroColors.red:
        return PomodoroUI.salmon;
    }
  }
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
        return PomodoroUI.serif;
      case PomodoroFonts.mono:
        return PomodoroUI.mono;
      case PomodoroFonts.sans:
        return PomodoroUI.sans;
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
