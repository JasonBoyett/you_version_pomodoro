import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tomato_timer/models/models.dart';
import 'package:tomato_timer/pages/settings/settings.dart';
import 'package:tomato_timer/pages/settings/widgets/widgets.dart';
import 'package:tomato_timer/providers/providers.dart';

class TabletDialog extends ConsumerWidget {
  final void Function(bool) openSetter;
  const TabletDialog({
    required this.openSetter,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var settingsModel = ref.watch(settingsProvider);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  top: 8.0,
                ),
                child: Center(
                    child: Text(
                  "Settings",
                  style: TextStyle(
                    color: PomodoroUI.textDark,
                    fontStyle: PomodoroUI.sans.fontStyle,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
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
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 4.0,
                  bottom: 4.0,
                ),
                child: SectionTitle("time (minutes)", center: false),
              ),
              Row(
                children: [
                  TimePicker(PomodoroStages.work),
                  TimePicker(PomodoroStages.shortBreak),
                  TimePicker(PomodoroStages.longBreak),
                ],
              ),
            ],
          ),
          Divider(
            color: PomodoroUI.dividerColor,
            thickness: 2,
            indent: 25,
            endIndent: 25,
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 4.0,
              bottom: 4.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SectionTitle("font"),
                FontPickers(),
              ],
            ),
          ),
          Divider(
            color: PomodoroUI.dividerColor,
            thickness: 2,
            indent: 25,
            endIndent: 25,
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 4.0,
              bottom: 4.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SectionTitle("color"),
                ColorPickers(),
              ],
            ),
          ),
          Divider(
            color: PomodoroUI.dividerColor,
            thickness: 2,
            indent: 25,
            endIndent: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 4.0,
              bottom: 4.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle("display", center: false),
                booleanPicker(
                  value: settingsModel.isShowingSeconds,
                  isTablet: true,
                  onToggle: (value) {
                    settingsModel.setIsShowingSeconds(value);
                  },
                  color: settingsModel.themeColor.color,
                  text: "Show seconds",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
