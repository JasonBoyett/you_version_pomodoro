import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tomato_timer/model/pomodoro.dart';
import 'package:tomato_timer/model/settings.dart';
import 'package:tomato_timer/widgets/color_pickers.dart';
import 'package:tomato_timer/widgets/font_pickers.dart';
import 'package:tomato_timer/widgets/home_page.dart';
import 'package:tomato_timer/widgets/time_picker.dart';

// I am using this because I want certain behavior on
// the first build of the settings dialog
// but not on subsequent builds.
var settingsOpen = false;

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
      backgroundColor: Colors.transparent,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.8,
              child: _dialogBase(
                pomodoroModel: pomodoroModel,
                settingsModel: settingsModel,
                context: context,
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.05 - 20,
              left: _determineLeftPadding(
                MediaQuery.of(context).size.width * 0.8,
                140,
              ),
              height: 53,
              width: 140,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: settingsModel.themeColor.color,
                  foregroundColor: Colors.white,
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
                  pomodoroModel.setThemeColor(settingsModel.themeColor);
                  pomodoroModel.setThemeFont(settingsModel.themeFont);
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
                    color: const Color.fromARGB(255, 22, 25, 50),
                    fontStyle: GoogleFonts.kumbhSans().fontStyle,
                    fontWeight: FontWeight.bold,
                  ),
                  textScaler: const TextScaler.linear(1.5),
                )),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: IconButton(
                  color: const Color.fromARGB(255, 30, 33, 63),
                  onPressed: () {
                    settingsOpen = false;
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
            ],
          ),
          const Divider(
            color: Color.fromRGBO(227, 225, 225, 1),
            thickness: 2,
          ),
          _sectionTitle("time (minutes)"),
          timePicker(PomodoroStages.work, settingsModel),
          timePicker(PomodoroStages.shortBreak, settingsModel),
          timePicker(PomodoroStages.longBreak, settingsModel),
          const Divider(
            color: Color.fromRGBO(227, 225, 225, 1),
            thickness: 2,
            indent: 25,
            endIndent: 25,
          ),
          _sectionTitle("font"),
          Center(child: fontPickers(settingsModel)),
          const Divider(
            color: Color.fromRGBO(227, 225, 225, 1),
            thickness: 2,
            indent: 25,
            endIndent: 25,
          ),
          _sectionTitle("color"),
          Center(child: colorPickers(settingsModel)),
        ],
      ),
    );
  }
}

_determineLeftPadding(double containerWidth, double width) {
  var offset = width / 2;
  var center = containerWidth / 2;
  return center - offset;
}

Widget _sectionTitle(String title) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          letterSpacing: 5,
          color: const Color.fromARGB(255, 22, 25, 50),
          fontStyle: GoogleFonts.kumbhSans().fontStyle,
          fontWeight: FontWeight.bold,
        ),
        textScaler: const TextScaler.linear(1),
      ),
    ),
  );
}

final settingsProvider =
    ChangeNotifierProvider<SettingsModel>((ref) => SettingsModel());
