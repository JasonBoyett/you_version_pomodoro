import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tomato_timer/model/settings.dart';

import '../model/pomodoro.dart';

ChangeNotifierProvider<PomodoroModel> getPomodoroProvider() {
  return ChangeNotifierProvider<PomodoroModel>((ref) => PomodoroModel());
}

ChangeNotifierProvider<SettingsModel> getSettingsProvider() {
  return ChangeNotifierProvider<SettingsModel>((ref) => SettingsModel());
}
