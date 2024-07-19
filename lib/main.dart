import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'helpers.dart';
import 'pomodoroProps.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tomoto Timer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var value = ref.watch(pomodoroProvider);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              displayMinutesTimer(value.secondsInStage),
              textScaler: const TextScaler.linear(5.5),
            ),
            Text(
              value.currentStage.name,
              textScaler: const TextScaler.linear(2.5),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          switch (value.currentStage) {
            case PomodoroStages.paused:
              ref.read(pomodoroProvider).resume();
              break;
            case PomodoroStages.preStart:
              {
                ref.read(pomodoroProvider).start();
                break;
              }
            default:
              {
                ref.read(pomodoroProvider).pause();
                break;
              }
          }
        },
        child: value.currentStage == PomodoroStages.paused ||
                value.currentStage == PomodoroStages.preStart
            ? const Icon(Icons.play_arrow)
            : const Icon(Icons.pause),
      ),
    );
  }
}

final pomodoroProvider =
    ChangeNotifierProvider<PomodoroModel>((ref) => PomodoroModel());
