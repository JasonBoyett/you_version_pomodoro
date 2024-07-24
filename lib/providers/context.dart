import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tomato_timer/model/preference_loader.dart';
import 'package:tomato_timer/model/settings.dart';

import '../model/pomodoro.dart';

ChangeNotifierProvider<PomodoroModel> getPomodoroProvider() {
  return ChangeNotifierProvider<PomodoroModel>((ref) {
    var model = PomodoroModel();
    var loader = PreferenceLoader();

    loader.load(model).then((value) {
      model.set(
        workTime: loader.retrievedModel!.workTime,
        breakTimeShort: loader.retrievedModel!.breakTimeShort,
        breakTimeLong: loader.retrievedModel!.breakTimeLong,
        color: loader.retrievedModel!.themeColor,
        font: loader.retrievedModel!.themeFont,
        isShowingSeconds: loader.retrievedModel!.isShowingSeconds,
      );
    });
    return model;
  });
}

ChangeNotifierProvider<SettingsModel> getSettingsProvider() {
  return ChangeNotifierProvider<SettingsModel>((ref) => SettingsModel());
}
