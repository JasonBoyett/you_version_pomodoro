import 'pomodoroProps.dart';

String displayMinutesTimer(int seconds) {
  int minutes = seconds ~/ 60;
  int remainingSeconds = seconds % 60;
  return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
}
