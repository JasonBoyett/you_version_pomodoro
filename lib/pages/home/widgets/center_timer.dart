import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tomato_timer/models/models.dart';
import 'package:flutter/material.dart';
import 'package:tomato_timer/pages/home/view/home_page.dart';
import 'package:tomato_timer/providers/providers.dart';

import 'background_circle.dart';

class CenterTimer extends ConsumerWidget {
  const CenterTimer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var model = ref.watch(pomodoroProvider);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Stack(alignment: Alignment.center, children: [
        const BackgroundCircle(),
        SizedBox(
          height: 300,
          width: 300,
          child: CircularProgressIndicator(
            value: model.getProgress(),
            strokeCap: StrokeCap.round,
            strokeWidth: 10,
            color: model.themeColor.color,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                style: TextStyle(
                  color: PomodoroUI.textLight,
                  fontFamily: model.themeFont.font.fontFamily,
                  fontWeight: FontWeight.bold,
                ),
                model.getTimerString(),
                textScaler: const TextScaler.linear(6.5),
              ),
            ),
            TextButton(
                key: const Key('startButton'),
                onLongPress: () {
                  model.reset();
                },
                onPressed: () => _centerButtonAction(model),
                child: Text(
                  _ditermineDisplayText(model),
                  style: TextStyle(
                    letterSpacing: 15,
                    color: PomodoroUI.textLight,
                    fontFamily: model.themeFont.font.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                  textScaler: const TextScaler.linear(1.25),
                )),
          ],
        ),
      ]),
    );
  }
}

// helper functions

void _centerButtonAction(PomodoroModel value) {
  switch (value.currentStage) {
    case PomodoroStages.paused:
      value.resume();
      break;
    case PomodoroStages.preStart:
      {
        value.start();
        break;
      }
    default:
      {
        value.pause();
        break;
      }
  }
}

String _ditermineDisplayText(PomodoroModel value) {
  switch (value.currentStage) {
    case PomodoroStages.paused:
      return 'RESUME';
    case PomodoroStages.preStart:
      return 'START';
    default:
      return 'PAUSE';
  }
}
