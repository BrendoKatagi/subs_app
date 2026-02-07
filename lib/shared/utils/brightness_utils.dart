import 'package:flutter/foundation.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

void setScreenMaxBrightness() {
  if (kIsWeb) return;
  try {
    WakelockPlus.enable();
    ScreenBrightness().setScreenBrightness(1);
    // ignore: empty_catches
  } catch (e) {}
}

void resetScreenBrightness() {
  if (kIsWeb) return;
  try {
    WakelockPlus.disable();
    ScreenBrightness().resetScreenBrightness();
    // ignore: empty_catches
  } catch (e) {}
}
