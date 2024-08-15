import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tomato_timer/models/models.dart';
import 'package:tomato_timer/pages/settings/settings.dart';
import 'package:tomato_timer/pages/settings/widgets/widgets.dart';
import 'package:tomato_timer/providers/providers.dart';

class MobileDialog extends ConsumerWidget {
  final void Function(bool) openSetter;

  const MobileDialog({
    super.key,
    required this.openSetter,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var settingsModel = ref.watch(settingsProvider);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Center(
                    child: Text(
                  "Settings",
                  style: TextStyle(
                    color: PomodoroUI.textDark,
                    fontStyle: PomodoroUI.sans.fontStyle,
                    fontWeight: FontWeight.bold,
                  ),
                  textScaler: const TextScaler.linear(1.5),
                )),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: IconButton(
                  color: PomodoroUI.textMidDark,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
            ],
          ),
          Divider(
            color: PomodoroUI.dividerColor,
            thickness: 2,
          ),
          const SectionTitle("time (minutes)"),
          const TimePicker(PomodoroStages.work),
          const TimePicker(PomodoroStages.shortBreak),
          const TimePicker(PomodoroStages.longBreak),
          Divider(
            color: PomodoroUI.dividerColor,
            thickness: 2,
            indent: 25,
            endIndent: 25,
          ),
          const SectionTitle("font"),
          const Center(child: FontPickers()),
          Divider(
            color: PomodoroUI.dividerColor,
            thickness: 2,
            indent: 25,
            endIndent: 25,
          ),
          const SectionTitle("color"),
          const Center(child: ColorPickers()),
          Divider(
            color: PomodoroUI.dividerColor,
            thickness: 2,
            indent: 25,
            endIndent: 25,
          ),
          const SectionTitle("display"),
          booleanPicker(
            value: settingsModel.isShowingSeconds,
            onToggle: (value) {
              settingsModel.setIsShowingSeconds(value);
            },
            color: settingsModel.themeColor.color,
            text: "Show seconds",
          ),
        ],
      ),
    );
  }
}
