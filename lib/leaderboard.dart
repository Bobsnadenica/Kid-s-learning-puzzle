import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LeaderboardEntry {
  final String category;
  final int score;
  final int timeSeconds;

  const LeaderboardEntry({
    required this.category,
    required this.score,
    required this.timeSeconds,
  });

  String get formattedTime {
    final m = timeSeconds ~/ 60;
    final s = timeSeconds % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  Map<String, dynamic> toJson() => {
        'category': category,
        'score': score,
        'timeSeconds': timeSeconds,
      };

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) =>
      LeaderboardEntry(
        category: json['category'] as String,
        score: json['score'] as int,
        timeSeconds: json['timeSeconds'] as int,
      );
}

class Leaderboard {
  static const _key = 'leaderboard_v1';
  static const _maxEntries = 50;
  static List<LeaderboardEntry> _entries = [];

  static Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return;
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      _entries = list
          .map((e) => LeaderboardEntry.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      _entries = [];
    }
  }

  static Future<void> add(LeaderboardEntry entry) async {
    _entries.add(entry);
    _entries.sort((a, b) {
      final scoreCmp = b.score.compareTo(a.score);
      if (scoreCmp != 0) return scoreCmp;
      return a.timeSeconds.compareTo(b.timeSeconds); // faster is better on tie
    });
    if (_entries.length > _maxEntries) {
      _entries = _entries.sublist(0, _maxEntries);
    }
    await _save();
  }

  static Future<void> clear() async {
    _entries = [];
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }

  static Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _key,
      jsonEncode(_entries.map((e) => e.toJson()).toList()),
    );
  }

  static List<LeaderboardEntry> get entries => List.unmodifiable(_entries);
}
