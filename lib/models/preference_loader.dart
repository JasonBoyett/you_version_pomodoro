import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomato_timer/models/helper_types.dart';
import 'package:tomato_timer/models/pomodoro.dart';

class PreferenceLoader {
  final String _workTimeKey = 'workTime';
  final String _breakTimeShortKey = 'breakTimeShort';
  final String _breakTimeLongKey = 'breakTimeLong';
  final String _themeColorKey = 'themeColor';
  final String _themeFontKey = 'themeFont';
  final String _isShowingSecondsKey = 'isShowingSeconds';

  PomodoroModel? retrievedModel;

  Future<PomodoroModel> _load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return PomodoroModel.custom(
      workTime: prefs.getInt(_workTimeKey) ?? 25,
      breakTimeShort: prefs.getInt(_breakTimeShortKey) ?? 5,
      breakTimeLong: prefs.getInt(_breakTimeLongKey) ?? 15,
      themeColor: (() {
        try {
          int result = prefs.getInt(_themeColorKey) ?? 0;
          if (result > PomodoroColors.values.length - 1) {
            return PomodoroColors.cyan;
          }
          return PomodoroColors.values[result];
        } catch (e) {
          return PomodoroColors.cyan;
        }
      })(),
      themeFont: (() {
        try {
          int result = prefs.getInt(_themeFontKey) ?? 0;
          if (result > PomodoroFonts.values.length - 1) {
            return PomodoroFonts.serrif;
          }
          return PomodoroFonts.values[result];
        } catch (e) {
          return PomodoroFonts.serrif;
        }
      })(),
      isShowingSeconds: prefs.getBool(_isShowingSecondsKey) ?? true,
    );
  }

  Future<void> save(PomodoroModel model) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_workTimeKey, model.workTime);
    await prefs.setInt(_breakTimeShortKey, model.breakTimeShort);
    await prefs.setInt(_breakTimeLongKey, model.breakTimeLong);
    await prefs.setInt(_themeColorKey, model.themeColor.index);
    await prefs.setInt(_themeFontKey, model.themeFont.index);
    await prefs.setBool(_isShowingSecondsKey, model.isShowingSeconds);

    retrievedModel = model;
  }

  Future<void> load(PomodoroModel model) async {
    retrievedModel = await _load();
    model.set(
      workTime: retrievedModel!.workTime,
      breakTimeShort: retrievedModel!.breakTimeShort,
      breakTimeLong: retrievedModel!.breakTimeLong,
      color: retrievedModel!.themeColor,
      font: retrievedModel!.themeFont,
      isShowingSeconds: retrievedModel!.isShowingSeconds,
    );
  }
}
