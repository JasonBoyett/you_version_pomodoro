import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tomato_timer/models/models.dart';
import 'package:tomato_timer/pages/settings/settings.dart';
import 'package:tomato_timer/providers/providers.dart';

class FontPickers extends StatelessWidget {
  const FontPickers({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _FontButton(PomodoroFonts.serrif),
        _FontButton(PomodoroFonts.mono),
        _FontButton(PomodoroFonts.sans),
      ],
    );
  }
}

class _FontButton extends ConsumerWidget {
  final PomodoroFonts font;

  const _FontButton(this.font);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var settingsModel = ref.watch(settingsProvider);
    return GestureDetector(
      onTap: () {
        settingsModel.setFont(font);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          width: PomodoroUI.circularPickerSize,
          height: PomodoroUI.circularPickerSize,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: settingsModel.themeFont == font
                  ? PomodoroUI.black
                  : PomodoroUI.grey,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              "Aa",
              style: settingsModel.themeFont == font
                  ? _letterStyle(font, Colors.white)
                  : _letterStyle(font, Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}

TextStyle _letterStyle(PomodoroFonts font, Color color) {
  var base = font.font;
  return base.merge(TextStyle(
    color: color,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ));
}
