import 'package:vibration/vibration.dart';

class VibrationProvider {
  static Future<void> defaultVibration() async {
    var hasVibrator = await Vibration.hasVibrator() ?? false;
    var hasCustomVibration =
        await Vibration.hasCustomVibrationsSupport() ?? false;
    var hasAmplitudeControl = await Vibration.hasAmplitudeControl() ?? false;

    if (!hasVibrator) {
      return;
    }
    if (hasCustomVibration && hasAmplitudeControl) {
      Vibration.vibrate(
        pattern: [
          0,
          500,
          100,
          500,
          100,
          500,
        ],
        intensities: [
          128,
          200,
          255,
        ],
      );
      return;
    }
    if (hasCustomVibration) {
      Vibration.vibrate(
        pattern: [
          0,
          500,
          100,
          500,
          100,
          500,
        ],
      );
      return;
    }
    Vibration.vibrate(
      duration: 1000,
    );
  }
}
