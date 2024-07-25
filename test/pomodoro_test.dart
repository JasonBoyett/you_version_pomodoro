import 'package:flutter_test/flutter_test.dart';
import 'package:tomato_timer/model/helper_types.dart';
import 'package:tomato_timer/model/pomodoro.dart';
import 'package:fake_async/fake_async.dart';

void main() {
  group('Basic actions', () {
    test('PomodoroModel can be created', () {
      var model = PomodoroModel();
      expect(model, isNotNull);
    });

    test('PomodoroModel can be created with custom values', () {
      var model = PomodoroModel.custom(
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

    test('PomodoroModel can set the work time', () {
      var model = PomodoroModel();
      model.setWorkTime(30);
      expect(model.workTime, 30);
    });

    test('PomodoroModel can set the short break time', () {
      var model = PomodoroModel();
      model.setBreakTimeShort(10);
      expect(model.breakTimeShort, 10);
    });

    test('PomodoroModel can set the long break time', () {
      var model = PomodoroModel();
      model.setBreakTimeLong(30);
      expect(model.breakTimeLong, 30);
    });

    test('PomodoroModel can set the stage to work with correct time', () {
      var model = PomodoroModel.custom(workTime: 1);
      model.setStage(PomodoroStages.work);
      expect(model.currentStage, PomodoroStages.work);
      expect(model.getRemainingtime(), const Duration(minutes: 1));
    });

    test('PomodoroModel can set the stage to short break with correct time',
        () {
      var model = PomodoroModel.custom(breakTimeShort: 1);
      model.setStage(PomodoroStages.shortBreak);
      expect(model.currentStage, PomodoroStages.shortBreak);
      expect(model.getRemainingtime(), const Duration(minutes: 1));
    });

    test('PomodoroModel can set the stage to long break with correct time', () {
      var model = PomodoroModel.custom(breakTimeLong: 1);
      model.setStage(PomodoroStages.longBreak);
      expect(model.currentStage, PomodoroStages.longBreak);
      expect(model.getRemainingtime(), const Duration(minutes: 1));
    });
  });

  group('Complex actions', () {
    test('PomodoroModel pause behavior functions correctly', () {
      var model = PomodoroModel.custom(workTime: 1);
      model.setStage(PomodoroStages.work);
      model.pause();
      expect(model.currentStage, PomodoroStages.paused);
      expect(model.getRemainingtime(), const Duration(minutes: 1));
    });

    test('PomodoroModel resume behavior functions correctly for work stage',
        () {
      var model = PomodoroModel.custom(workTime: 1);
      model.setStage(PomodoroStages.work);
      model.pause();
      model.resume();
      expect(model.currentStage, PomodoroStages.work);
      expect(model.getRemainingtime(), const Duration(minutes: 1));
    });

    test(
        'PomodoroModel resume behavior functions correctly for short break stage',
        () {
      var model = PomodoroModel.custom(breakTimeShort: 1);
      model.setStage(PomodoroStages.shortBreak);
      model.pause();
      model.resume();
      expect(model.currentStage, PomodoroStages.shortBreak);
      expect(model.getRemainingtime(), const Duration(minutes: 1));
    });

    test(
        'PomodoroModel resume behavior functions correctly for long break stage',
        () {
      var model = PomodoroModel.custom(breakTimeLong: 1);
      model.setStage(PomodoroStages.longBreak);
      model.pause();
      model.resume();
      expect(model.currentStage, PomodoroStages.longBreak);
      expect(model.getRemainingtime(), const Duration(minutes: 1));
    });

    test('PomodoroModel resume behavior functions correctly for preStart stage',
        () {
      var model = PomodoroModel.custom(workTime: 1);
      model.setStage(PomodoroStages.preStart);
      model.pause();
      model.resume();
      expect(model.currentStage, PomodoroStages.preStart);
      expect(model.getRemainingtime(), const Duration(minutes: 0));
    });
  });

  group('Invalid state and edge cases', () {
    test('PomodoroModel throws error when setting work time to less than 0',
        () {
      var model = PomodoroModel();
      expect(() => model.setWorkTime(0), throwsException);
    });

    test(
        'PomodoroModel throws error when setting short break time to less than 0',
        () {
      var model = PomodoroModel();
      expect(() => model.setBreakTimeShort(0), throwsException);
    });

    test(
        'PomodoroModel throws error when setting long break time to less than 0',
        () {
      var model = PomodoroModel();
      expect(() => model.setBreakTimeLong(0), throwsException);
    });
  });

  group('Time based tests', () {
    test('PomodoroModel switches state from work to short break correctly', () {
      var model = PomodoroModel.custom(workTime: 1, breakTimeShort: 1);
      model.setStage(PomodoroStages.work);
      model.setTestEnvironment(true);
      fakeAsync((async) {
        model.start();
        async.elapse(const Duration(minutes: 1, seconds: 1));
        expect(model.currentStage, PomodoroStages.shortBreak);
        expect(model.getRemainingtime(), const Duration(minutes: 1));
      });
    });

    test('PomodoroModel switches state from short break to work correctly', () {
      var model = PomodoroModel.custom(workTime: 1, breakTimeShort: 1);
      model.setStage(PomodoroStages.shortBreak);
      model.setTestEnvironment(true);
      fakeAsync((async) {
        model.start();
        async.elapse(const Duration(minutes: 1, seconds: 1));
        expect(model.currentStage, PomodoroStages.work);
        expect(model.getRemainingtime(), const Duration(minutes: 1));
      });
    });

    test('PomodoroModel switches state from work to long break correctly', () {
      var model = PomodoroModel.custom(
        workTime: 1,
        breakTimeShort: 1,
        breakTimeLong: 1,
      );
      model.setTestEnvironment(true);
      model.setStage(PomodoroStages.work);
      fakeAsync((async) {
        model.start();

        for (var i = 0; i < 3; i++) {
          async.elapse(const Duration(minutes: 1, seconds: 1));
          expect(model.currentStage, PomodoroStages.shortBreak);
          async.elapse(const Duration(minutes: 1, seconds: 1));
          expect(model.currentStage, PomodoroStages.work);
        }

        async.elapse(const Duration(minutes: 1, seconds: 1));

        expect(model.currentStage, PomodoroStages.longBreak);
        expect(model.getRemainingtime(), const Duration(minutes: 1));
      });
    });

    test('PomodoroModel switches state from long break to work correctly', () {
      var model = PomodoroModel.custom(
        workTime: 1,
        breakTimeShort: 1,
        breakTimeLong: 1,
      );
      model.setTestEnvironment(true);
      model.setStage(PomodoroStages.longBreak);
      fakeAsync((async) {
        model.start();

        async.elapse(const Duration(minutes: 1, seconds: 1));
        expect(model.currentStage, PomodoroStages.work);
        expect(model.getRemainingtime(), const Duration(minutes: 1));
      });
    });

    test('PomodoroModel returns proper timerString for given time', () {
      var model = PomodoroModel.custom(workTime: 3, breakTimeShort: 2);
      model.setTestEnvironment(true);
      fakeAsync((async) {
        model.start();
        // I'm offsetting by 1 second because the timer
        // won't have time to update the last time before the assert is called
        async.elapse(const Duration(minutes: 2, seconds: 31));
        expect(model.getTimerString(), '0:30');
        async.elapse(const Duration(minutes: 1, seconds: 31));
        expect(model.getTimerString(), '1:00');
      });
    });
  });
}
