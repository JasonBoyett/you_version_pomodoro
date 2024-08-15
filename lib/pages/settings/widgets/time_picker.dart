import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tomato_timer/models/models.dart';
import 'package:tomato_timer/pages/settings/settings.dart';
import 'package:tomato_timer/providers/providers.dart';

class TimePicker extends StatelessWidget {
  final PomodoroStages stage;

  const TimePicker(this.stage, {super.key});

  @override
  Widget build(BuildContext context) {
    return PomodoroUI.isTablet(context)
        ? _TabletPicker(stage)
        : _MobilePicker(stage);
  }
}

class _MobilePicker extends ConsumerWidget {
  final PomodoroStages stage;

  const _MobilePicker(this.stage);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var settingsModel = ref.watch(settingsProvider);
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, bottom: 6.0),
      child: Row(
        children: [
          Center(
            child: SizedBox(
              width: 100,
              child: Text(
                _ditermineStageText(stage),
                style: TextStyle(
                  fontStyle: GoogleFonts.kumbhSans().fontStyle,
                  fontWeight: FontWeight.bold,
                  color: PomodoroUI.textMidDark,
                ),
              ),
            ),
          ),
          _Picker(
            stage: stage,
            settingsModel: settingsModel,
          )
        ],
      ),
    );
  }
}

class _TabletPicker extends ConsumerWidget {
  final PomodoroStages stage;
  const _TabletPicker(this.stage);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var settingsModel = ref.watch(settingsProvider);
    return Column(
      children: [
        Center(
          child: SizedBox(
            width: 100,
            child: Text(
              _ditermineStageText(stage),
              style: TextStyle(
                fontStyle: GoogleFonts.kumbhSans().fontStyle,
                fontWeight: FontWeight.bold,
                color: PomodoroUI.textMidDark,
              ),
            ),
          ),
        ),
        _Picker(
          stage: stage,
          settingsModel: settingsModel,
        )
      ],
    );
  }
}

class _Picker extends ConsumerWidget {
  final PomodoroStages stage;
  final SettingsModel settingsModel;

  const _Picker({
    required this.stage,
    required this.settingsModel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var settingsModel = ref.watch(settingsProvider);
    return Padding(
      padding: const EdgeInsets.only(left: 40),
      child: SizedBox(
        height: 40,
        width: 140,
        child: Container(
          decoration: BoxDecoration(
            color: PomodoroUI.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 80.0),
                  child: Text(
                    settingsModel.getStageTime(stage).toString(),
                    style: TextStyle(
                      color: PomodoroUI.textDark,
                      fontStyle: GoogleFonts.kumbhSans().fontStyle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              _PickerButtons(stage),
            ],
          ),
        ),
      ),
    );
  }
}

class _PickerButtons extends ConsumerWidget {
  final PomodoroStages stage;
  const _PickerButtons(this.stage);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var settingsModel = ref.watch(settingsProvider);
    return Column(
      children: [
        _ArrowButton(Icons.keyboard_arrow_up, () {
          settingsModel.incrementStageTime(stage);
        }),
        _ArrowButton(Icons.keyboard_arrow_down, () {
          settingsModel.decrementStageTime(stage);
        }),
      ],
    );
  }
}

// IconButton wasn't playing nice with the row allignment so I made a custom
// implementation simmilar to IconButton. I'm guessing it's much simpler than the
// version that ships with materail design and therefore it doesn't
// have whatever junk is causing the allignment issues.
class _ArrowButton extends StatelessWidget {
  final IconData icon;
  final void Function() onPressed;

  const _ArrowButton(this.icon, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Icon(
        color: PomodoroUI.textMidDark,
        size: 20,
        icon,
      ),
    );
  }
}

// helper functions

String _ditermineStageText(PomodoroStages stage) {
  switch (stage) {
    case PomodoroStages.work:
      return "pomodoro";
    case PomodoroStages.shortBreak:
      return "short break";
    case PomodoroStages.longBreak:
      return "long break";
    default:
      return "Work";
  }
}
