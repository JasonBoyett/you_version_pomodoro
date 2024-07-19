import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'helpers.dart';
import 'package:tomato_timer/model/pomodoro.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var value = ref.watch(pomodoroProvider);
    return Scaffold(
      body: Center(
          child: Stack(alignment: Alignment.center, children: [
        SizedBox(
          height: 300,
          width: 300,
          child: CircularProgressIndicator(
            value: evaluateProgress(value),
            strokeCap: StrokeCap.round,
            strokeWidth: 8,
            color: value.themeColor.color,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              displayMinutesTimer(value.secondsInStage),
              textScaler: const TextScaler.linear(5.5),
            ),
            Text(
              value.currentStage.name,
              textScaler: const TextScaler.linear(2.5),
            ),
          ],
        ),
      ])),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          switch (value.currentStage) {
            case PomodoroStages.paused:
              ref.read(pomodoroProvider).resume();
              break;
            case PomodoroStages.preStart:
              {
                ref.read(pomodoroProvider).start();
                break;
              }
            default:
              {
                ref.read(pomodoroProvider).pause();
                break;
              }
          }
        },
        child: value.currentStage == PomodoroStages.paused ||
                value.currentStage == PomodoroStages.preStart
            ? const Icon(Icons.play_arrow)
            : const Icon(Icons.pause),
      ),
    );
  }
}

final pomodoroProvider =
    ChangeNotifierProvider<PomodoroModel>((ref) => PomodoroModel());
