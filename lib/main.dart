import 'package:animal_puzzle_game/global.dart';
import 'package:animal_puzzle_game/leaderboard.dart';
import 'package:animal_puzzle_game/screens/game_page.dart';
import 'package:animal_puzzle_game/screens/home_page.dart';
import 'package:animal_puzzle_game/screens/language_page.dart';
import 'package:animal_puzzle_game/screens/leaderboard_page.dart';
import 'package:animal_puzzle_game/tts_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Leaderboard.load();
  await TtsService.init();
  final prefs = await SharedPreferences.getInstance();
  final savedLang = prefs.getString('app_language');
  if (savedLang != null) Global.language = savedLang;
  runApp(MyApp(skipPicker: savedLang != null));
}

class MyApp extends StatelessWidget {
  final bool skipPicker;
  const MyApp({required this.skipPicker, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: skipPicker ? 'home_page' : '/',
      routes: {
        '/': (context) => const LanguagePage(),
        'home_page': (context) => const HomePage(),
        'game_page': (context) => const GamePage(),
        'leaderboard': (context) => const LeaderboardPage(),
      },
    );
  }
}
