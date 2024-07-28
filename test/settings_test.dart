import 'package:flutter_test/flutter_test.dart';
import 'package:tomato_timer/models/helper_types.dart';
import 'package:tomato_timer/models/settings.dart';
import 'package:tomato_timer/models/pomodoro.dart';

void main() {
  group('Basic behaviors', () {
    test('SettingsModel can be created', () {
      var model = SettingsModel();
      expect(model, isNotNull);
    });

    test('SettingsModel can be created with custom values', () {
      var model = SettingsModel(
        breakTimeShort: 10,
        breakTimeLong: 30,
        workTime: 50,
        themeColor: PomodoroColors.red,
        themeFont: PomodoroFonts.sans,
      );
      expect(model, isNotNull);
      expect(model.breakTimeShort, 10);
      expect(model.breakTimeLong, 30);
      expect(model.workTime, 50);
      expect(model.themeColor, PomodoroColors.red);
      expect(model.themeFont, PomodoroFonts.sans);
    });

    test('SettingsModel can set the work time', () {
      var model = SettingsModel();
      model.setWorkTime(30);
      expect(model.workTime, 30);
    });

    test('SettingsModel can set the short break time', () {
      var model = SettingsModel();
      model.setBreakTimeShort(10);
      expect(model.breakTimeShort, 10);
    });

    test('SettingsModel can set the long break time', () {
      var model = SettingsModel();
      model.setBreakTimeLong(30);
      expect(model.breakTimeLong, 30);
    });

    test('SettingsModel can set the color', () {
      var model = SettingsModel();
      model.setColor(PomodoroColors.red);
      expect(model.themeColor, PomodoroColors.red);
    });

    test('SettingsModel can set the font', () {
      var model = SettingsModel();
      model.setFont(PomodoroFonts.sans);
      expect(model.themeFont, PomodoroFonts.sans);
    });
  });

  group('edge cases', () {
    test('SettingsModel will not set work time to less than 1', () {
      var model = SettingsModel();
      model.setWorkTime(0);
      expect(model.workTime, 25);
    });

    test('SettingsModel will not set short break time to less than 1', () {
      var model = SettingsModel();
      model.setBreakTimeShort(0);
      expect(model.breakTimeShort, 5);
    });

    test('SettingsModel will not set long break time to less than 1', () {
      var model = SettingsModel();
      model.setBreakTimeLong(0);
      expect(model.breakTimeLong, 20);
    });
  });

  group('Intigration with PomodoroModel', () {
    test('SettingsModel can be set from PomodoroModel', () {
      var pomodoroModel = PomodoroModel.custom(
        breakTimeShort: 10,
        breakTimeLong: 30,
        workTime: 50,
        themeColor: PomodoroColors.red,
        themeFont: PomodoroFonts.sans,
      );
      var settingsModel = SettingsModel();
      settingsModel.setFromPomodorModel(pomodoroModel);
      expect(settingsModel.breakTimeShort, 10);
      expect(settingsModel.breakTimeLong, 30);
      expect(settingsModel.workTime, 50);
      expect(settingsModel.themeColor, PomodoroColors.red);
      expect(settingsModel.themeFont, PomodoroFonts.sans);
    });
  });
}
