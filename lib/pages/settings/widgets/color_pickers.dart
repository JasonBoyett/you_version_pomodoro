import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tomato_timer/models/models.dart';
import 'package:tomato_timer/pages/settings/settings.dart';
import 'package:tomato_timer/providers/providers.dart';

class ColorPickers extends ConsumerWidget {
  const ColorPickers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _ColorButton(PomodoroColors.red),
        _ColorButton(PomodoroColors.cyan),
        _ColorButton(PomodoroColors.purple),
      ],
    );
  }
}

class _ColorButton extends ConsumerWidget {
  final PomodoroColors color;
  const _ColorButton(this.color);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var settingsModel = ref.watch(settingsProvider);
    return GestureDetector(
      onTap: () {
        settingsModel.setColor(color);
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
              color: color.color,
              borderRadius: BorderRadius.circular(100),
            ),
            child: settingsModel.themeColor == color
                ? const Icon(
                    Icons.check,
                    color: Colors.black,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
