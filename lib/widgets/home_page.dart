import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tomato_timer/model/pomodoro.dart';
import 'package:tomato_timer/widgets/center_timer.dart';
import 'package:tomato_timer/widgets/stage_indicator.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var value = ref.watch(pomodoroProvider);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 33, 63),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(25.0),
            child: Text(
              "pomodoro",
              textScaler: TextScaler.linear(2.5),
              style: TextStyle(
                  color: Color.fromARGB(255, 215, 224, 255),
                  fontWeight: FontWeight.bold),
            ),
          ),
          stageIndicator(value),
          Center(child: centerTimer(value)),
        ],
      ),
    );
  }
}

final pomodoroProvider =
    ChangeNotifierProvider<PomodoroModel>((ref) => PomodoroModel());
