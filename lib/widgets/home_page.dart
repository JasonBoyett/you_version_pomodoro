import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tomato_timer/providers/context.dart';

import 'package:tomato_timer/widgets/center_timer.dart';
import 'package:tomato_timer/widgets/stage_indicator.dart';
import 'package:tomato_timer/widgets/settings_dialog.dart';

final pomodoroProvider = getPomodoroProvider();

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var model = ref.watch(pomodoroProvider);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 33, 63),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(25.0),
            child: Text(
              "pomodoro",
              textScaler: TextScaler.linear(2),
              style: TextStyle(
                  color: Color.fromARGB(255, 215, 224, 255),
                  fontWeight: FontWeight.bold),
            ),
          ),
          stageIndicator(model),
          centerTimer(model),
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: TextButton(
              onPressed: () => showDialog(
                  context: context,
                  builder: (context) {
                    return const SettingsDialog();
                  }),
              child: const Icon(
                Icons.settings,
                color: Color.fromARGB(255, 215, 224, 255),
                size: 40.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
