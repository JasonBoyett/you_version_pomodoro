import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tomato_timer/model/pomodoro.dart';
import 'package:tomato_timer/providers/context.dart';
import 'package:tomato_timer/providers/ui.dart';

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
      backgroundColor: PomodoroUI.textMidDark,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text(
              "pomodoro",
              textScaler: const TextScaler.linear(2),
              style: TextStyle(
                color: PomodoroUI.textLight,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          stageIndicator(model, context),
          centerTimer(model),
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: TextButton(
              onPressed: () => showDialog(
                  context: context,
                  builder: (context) {
                    return const SettingsDialog();
                  }),
              child: Icon(
                Icons.settings,
                color: PomodoroUI.textLight,
                size: 40.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
