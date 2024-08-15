import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tomato_timer/providers/providers.dart';

import '../widgets/widgets.dart';
import 'package:tomato_timer/pages/settings/settings.dart';

final pomodoroProvider = getPomodoroProvider();

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: PomodoroUI.textMidDark,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text(
              "🍅",
              textScaler: const TextScaler.linear(2),
              style: TextStyle(
                color: PomodoroUI.textLight,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const StageIndicator(),
          const CenterTimer(),
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
