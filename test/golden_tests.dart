import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:tomato_timer/app.dart';

Future<void> configureTesterForSize(
    WidgetTester tester, Size canvasSize, double devicePixelRatio) async {
  Size convertedSize = Size(canvasSize.width / devicePixelRatio,
      canvasSize.height / devicePixelRatio);
  await tester.binding.setSurfaceSize(convertedSize);
  tester.view.physicalSize = convertedSize;
  tester.view.devicePixelRatio = 1.0;
}

void main() {
  GoldenToolkit.runWithConfiguration(
    () {
      testGoldens('Golden Test Pixel 3a', (WidgetTester tester) async {
        await configureTesterForSize(tester, const Size(1080, 2220), 2.75);
        await tester.pumpWidget(const App());
        await expectLater(find.byType(App),
            matchesGoldenFile('golden_files/main-pixel3a-golden.png'));
      });

      testGoldens('Golden Test Pixel 4XL', (WidgetTester tester) async {
        await configureTesterForSize(tester, const Size(1440, 3040), 2.75);
        await tester.pumpWidget(const App());
        await expectLater(find.byType(App),
            matchesGoldenFile('golden_files/main-pixel4XL-golden.png'));
      });

      testGoldens('Golden Test iPhone 14', (WidgetTester tester) async {
        await configureTesterForSize(tester, const Size(390, 844), 3.00);
        await tester.pumpWidget(const App());
        await expectLater(find.byType(App),
            matchesGoldenFile('golden_files/main-iphone14.png'));
      });

      testGoldens('Golden Test iPhone 14 pro Max', (WidgetTester tester) async {
        await configureTesterForSize(tester, const Size(430, 932), 3.00);
        await tester.pumpWidget(const App());
        await expectLater(find.byType(App),
            matchesGoldenFile('golden_files/main-iphone14-pro-max-golden.png'));
      });

      testGoldens('Golden Test iPad Air', (WidgetTester tester) async {
        await configureTesterForSize(tester, const Size(820, 1180), 2.00);
        await tester.pumpWidget(const App());
        await expectLater(find.byType(App),
            matchesGoldenFile('golden_files/main-iPad-air.png'));
      });
    },
    config: GoldenToolkitConfiguration(
      skipGoldenAssertion: () => false,
    ),
  );
}
