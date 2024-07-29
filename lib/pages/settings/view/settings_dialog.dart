import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tomato_timer/models/models.dart';
import 'package:tomato_timer/providers/providers.dart';
import 'package:tomato_timer/pages/home/home.dart';
import 'package:tomato_timer/pages/settings/widgets/widgets.dart';

// I am using this because I want certain behavior on
// the first build of the settings dialog
// but not on subsequent builds.
var settingsOpen = false;

final settingsProvider = getSettingsProvider();
final PreferenceLoader loader = PreferenceLoader();

class SettingsDialog extends ConsumerWidget {
  const SettingsDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var settingsModel = ref.watch(settingsProvider);
    var pomodoroModel = ref.watch(pomodoroProvider);
    Future(() {
      if (!settingsOpen) settingsModel.setFromPomodorModel(pomodoroModel);
      settingsOpen = true;
    });
    return Dialog(
      alignment: Alignment.center,
      backgroundColor: Colors.transparent,
      child: SizedBox(
        height: PomodoroUI.settingsDialogSizeOuter(context).height,
        width: PomodoroUI.settingsDialogSizeOuter(context).width,
        child: Stack(
          children: [
            SizedBox(
              height: PomodoroUI.settingsDialogSizeInner(context).height,
              width: PomodoroUI.settingsDialogSizeInner(context).width,
              child: _dialogBase(
                pomodoroModel: pomodoroModel,
                settingsModel: settingsModel,
                context: context,
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: settingsModel.themeColor.color,
                    foregroundColor: Colors.white,
                    fixedSize: PomodoroUI.applyButtonSize,
                  ),
                  onPressed: () {
                    pomodoroModel.setWorkTime(
                      settingsModel.getStageTime(
                        PomodoroStages.work,
                      ),
                    );
                    pomodoroModel.setBreakTimeLong(
                      settingsModel.getStageTime(
                        PomodoroStages.longBreak,
                      ),
                    );
                    pomodoroModel.setBreakTimeShort(
                      settingsModel.getStageTime(
                        PomodoroStages.shortBreak,
                      ),
                    );
                    pomodoroModel.setIsShowingSeconds(
                      settingsModel.isShowingSeconds,
                    );
                    pomodoroModel.setThemeColor(settingsModel.themeColor);
                    pomodoroModel.setThemeFont(settingsModel.themeFont);
                    loader.save(pomodoroModel);
                    Navigator.of(context).pop();
                  },
                  onLongPress: () {
                    settingsModel.hardReset();
                    pomodoroModel.preferencesReset();
                    loader.save(pomodoroModel);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Apply",
                    style: TextStyle(
                      fontStyle: GoogleFonts.kumbhSans().fontStyle,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      shadows: const [
                        Shadow(
                          color: Colors.black,
                          blurRadius: 1,
                          offset: Offset(0.2, 0.2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _dialogBase({
    required PomodoroModel pomodoroModel,
    required SettingsModel settingsModel,
    required BuildContext context,
  }) {
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
                    fontStyle: GoogleFonts.kumbhSans().fontStyle,
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
                    settingsOpen = false;
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
          sectionTitle("time (minutes)"),
          timePicker(PomodoroStages.work, settingsModel),
          timePicker(PomodoroStages.shortBreak, settingsModel),
          timePicker(PomodoroStages.longBreak, settingsModel),
          Divider(
            color: PomodoroUI.dividerColor,
            thickness: 2,
            indent: 25,
            endIndent: 25,
          ),
          sectionTitle("font"),
          Center(child: fontPickers(settingsModel, context)),
          Divider(
            color: PomodoroUI.dividerColor,
            thickness: 2,
            indent: 25,
            endIndent: 25,
          ),
          sectionTitle("color"),
          Center(child: colorPickers(settingsModel, context)),
          Divider(
            color: PomodoroUI.dividerColor,
            thickness: 2,
            indent: 25,
            endIndent: 25,
          ),
          sectionTitle("display"),
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
