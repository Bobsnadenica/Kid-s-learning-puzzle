import 'package:animal_puzzle_game/leaderboard.dart';
import 'package:animal_puzzle_game/screens/game_page.dart';
import 'package:animal_puzzle_game/screens/home_page.dart';
import 'package:animal_puzzle_game/screens/language_page.dart';
import 'package:animal_puzzle_game/screens/leaderboard_page.dart';
import 'package:animal_puzzle_game/tts_service.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Leaderboard.load();
  await TtsService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => const LanguagePage(),
        "home_page": (context) => const HomePage(),
        "game_page": (context) => const GamePage(),
        "leaderboard": (context) => const LeaderboardPage(),
      },
    );
  }
}
