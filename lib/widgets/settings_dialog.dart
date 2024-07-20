import 'package:flutter/material.dart';

import 'package:tomato_timer/model/pomodoro.dart';

Widget settingsDialog(PomodoroModel model) {
  return Dialog(
    child: Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 30, 33, 63),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        children: [
          Text("Hello"),
          Text("Hello"),
          Text("Hello"),
          Text("Hello"),
          Text("Hello"),
          Text("Hello"),
        ],
      ),
    ),
  );
}
