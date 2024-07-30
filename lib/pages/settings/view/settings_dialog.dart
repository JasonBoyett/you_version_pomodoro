import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    var pomodoroModel = ref.watch(pomodoroProvider);
    var settingsModel = ref.watch(settingsProvider);

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
              width: PomodoroUI.settingsDialogSizeInner(context).width,
              height: PomodoroUI.settingsDialogSizeInner(context).height,
              child: PomodoroUI.isTablet(context)
                  ? tabletDialog(
                      context: context,
                      settingsModel: settingsModel,
                      pomodoroModel: pomodoroModel,
                      openSetter: (bool value) {
                        settingsOpen = value;
                      },
                    )
                  : mobileDialog(
                      context: context,
                      settingsModel: settingsModel,
                      pomodoroModel: pomodoroModel,
                      openSetter: (bool value) {
                        settingsOpen = value;
                      },
                    ),
            ),
            applyButton(
              context: context,
              settingsModel: settingsModel,
              pomodoroModel: pomodoroModel,
              loader: loader,
            ),
          ],
        ),
      ),
    );
  }
}
