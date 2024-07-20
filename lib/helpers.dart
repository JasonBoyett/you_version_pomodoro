import 'package:tomato_timer/model/pomodoro.dart';

String displayMinutesTimer(int seconds) {
  int minutes = seconds ~/ 60;
  int remainingSeconds = seconds % 60;
  return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
}

double evaluateProgress(PomodoroModel model) {
  int stageMinutes = _evaluateStageTime(model);
  double stageTime = stageMinutes.toDouble() * secondsInMinute;
  return (model.secondsInStage / stageTime).clamp(0.0, 1.0);
}

int _evaluateStageTime(PomodoroModel model) {
  if (model.currentStage == PomodoroStages.paused) {
    switch (model.getPreviosStage()) {
      case PomodoroStages.work:
        return model.workTime;
      case PomodoroStages.shortBreak:
        return model.breakTimeShort;
      case PomodoroStages.longBreak:
        return model.breakTimelong;
      default:
        return 0;
    }
  }
  switch (model.currentStage) {
    case PomodoroStages.work:
      return model.workTime;
    case PomodoroStages.shortBreak:
      return model.breakTimeShort;
    case PomodoroStages.longBreak:
      return model.breakTimelong;
    default:
      return 0;
  }
}
