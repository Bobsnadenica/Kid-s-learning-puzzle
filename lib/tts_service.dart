import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  static final _tts = FlutterTts();
  static bool muted = false;

  static Future<void> init() async {
    await _tts.setSpeechRate(0.45);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.1);
  }

  static Future<void> speak(String text, {bool isBg = false}) async {
    if (muted) return;
    await _tts.stop();
    await _tts.setLanguage(isBg ? 'bg-BG' : 'en-US');
    await _tts.speak(text);
  }

  static Future<void> stop() async => _tts.stop();
}
