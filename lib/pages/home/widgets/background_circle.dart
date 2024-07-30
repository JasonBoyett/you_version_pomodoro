import 'package:flutter/material.dart';
import 'package:tomato_timer/providers/providers.dart';

Widget backgroundCircle() {
  return Stack(alignment: Alignment.center, children: [
    SizedBox(
      width: 365,
      height: 365,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: PomodoroUI.timerGradient,
          boxShadow: [
            PomodoroUI.timerShadowLight,
            PomodoroUI.timerShadowDark,
          ],
        ),
      ),
    ),
    SizedBox(
      width: 330,
      height: 330,
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromARGB(255, 22, 25, 50),
        ),
      ),
    ),
  ]);
}
