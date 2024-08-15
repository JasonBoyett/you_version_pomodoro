import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tomato_timer/models/models.dart';
import 'package:tomato_timer/pages/home/home.dart';
import 'package:tomato_timer/providers/providers.dart';

class StageIndicator extends ConsumerWidget {
  const StageIndicator({super.key});
  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    var gap = const EdgeInsets.only(top: 12, bottom: 12, left: 2, right: 2);
    return Container(
      margin: gap,
      padding: gap,
      decoration: BoxDecoration(
        color: PomodoroUI.backgroundColor,
        borderRadius: BorderRadius.circular(80),
      ),
      width: 400,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IndicatorCell(PomodoroStages.work),
          IndicatorCell(PomodoroStages.shortBreak),
          IndicatorCell(PomodoroStages.longBreak),
        ],
      ),
    );
  }
}

class IndicatorCell extends ConsumerWidget {
  final PomodoroStages stage;
  const IndicatorCell(this.stage, {super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    PomodoroModel model = ref.watch(pomodoroProvider);
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: GestureDetector(
        onTap: () {
          if (model.currentStage != PomodoroStages.preStart) {
            model.setStage(stage);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: _determineDisplayStage(model) == stage
                ? model.themeColor.color
                : Colors.transparent,
            borderRadius: BorderRadius.circular(80),
          ),
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Text(
              stage.name,
              textScaler: PomodoroUI.stageIndicatorFontScaler(context),
              style: TextStyle(
                fontFamily: model.themeFont.font.fontFamily,
                color: stage == _determineDisplayStage(model)
                    ? PomodoroUI.textDark
                    : PomodoroUI.textLight,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  PomodoroStages _determineDisplayStage(PomodoroModel value) {
    if (value.currentStage == PomodoroStages.preStart) {
      return PomodoroStages.work;
    }
    if (value.currentStage == PomodoroStages.paused) {
      return value.getPreviosStage();
    }
    return value.currentStage;
  }
}
