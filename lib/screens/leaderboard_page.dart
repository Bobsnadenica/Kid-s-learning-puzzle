import 'package:flutter/material.dart';
import '../global.dart';
import '../leaderboard.dart';

const Map<String, String> _categoryEmojis = {
  "Animals": "🦁",
  "Fruits": "🍎",
  "Vegetables": "🥕",
  "Flowers": "🌸",
  "Professions": "👨‍⚕️",
  "Vehicles": "🚗",
  "Weather": "☀️",
  "Colors": "🎨",
  "Shapes": "⭐",
  "Ocean": "🌊",
  "Sports": "⚽",
  "Body Parts": "👁️",
};

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  List<LeaderboardEntry> _entries = List.from(Leaderboard.entries);

  Future<void> _clear() async {
    final bool isBg = Global.language == 'bg';
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.brown.shade400, width: 3),
        ),
        title: Text(isBg ? "Изчисти класацията?" : "Clear leaderboard?"),
        content: Text(
          isBg ? "Всички резултати ще бъдат изтрити." : "All scores will be deleted.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(isBg ? "Отказ" : "Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(
              isBg ? "Изчисти" : "Clear",
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
    if (confirm == true) {
      await Leaderboard.clear();
      setState(() => _entries = []);
    }
  }

  String _categoryDisplay(String key) {
    final isBg = Global.language == 'bg';
    if (!isBg) return key;
    try {
      return Global.categories.firstWhere((c) => c.title == key).bgTitle ?? key;
    } catch (_) {
      return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isBg = Global.language == 'bg';

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/animals/game.jpg"),
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.arrow_back_ios_new,
                          color: Colors.brown.shade800),
                    ),
                    Expanded(
                      child: Text(
                        isBg ? "🏆 Класация" : "🏆 Leaderboard",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: Colors.brown.shade800,
                          shadows: const [
                            Shadow(color: Colors.white, blurRadius: 10)
                          ],
                        ),
                      ),
                    ),
                    if (_entries.isNotEmpty)
                      IconButton(
                        onPressed: _clear,
                        icon: Icon(Icons.delete_outline,
                            color: Colors.red.shade600),
                        tooltip: isBg ? "Изчисти" : "Clear",
                      )
                    else
                      const SizedBox(width: 48),
                  ],
                ),
              ),

              // Column headers
              if (_entries.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 4),
                  child: Row(
                    children: [
                      const SizedBox(width: 44),
                      Expanded(
                        child: Text(
                          isBg ? "Категория" : "Category",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Colors.brown.shade600,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 60,
                        child: Text(
                          isBg ? "Точки" : "Score",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Colors.brown.shade600,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 56,
                        child: Text(
                          isBg ? "Време" : "Time",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Colors.brown.shade600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              // Entries list
              Expanded(
                child: _entries.isEmpty
                    ? _emptyState(isBg)
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                        itemCount: _entries.length,
                        itemBuilder: (context, index) =>
                            _entryCard(_entries[index], index, isBg),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emptyState(bool isBg) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(32),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.75),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("🏆", style: TextStyle(fontSize: 64)),
            const SizedBox(height: 16),
            Text(
              isBg ? "Все още няма резултати!\nИграй, за да се класираш! 🎮"
                   : "No records yet!\nPlay a game to get on the board! 🎮",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.brown.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _entryCard(LeaderboardEntry entry, int index, bool isBg) {
    final String rankEmoji = switch (index) {
      0 => "🥇",
      1 => "🥈",
      2 => "🥉",
      _ => "${index + 1}",
    };
    final bool isTopThree = index < 3;

    final Color borderColor = switch (index) {
      0 => const Color(0xFFFFD700),
      1 => const Color(0xFFC0C0C0),
      2 => const Color(0xFFCD7F32),
      _ => Colors.brown.shade200,
    };

    final String emoji =
        _categoryEmojis[entry.category] ?? "🎮";

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: isTopThree ? 0.88 : 0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: isTopThree ? 2.5 : 1.5),
      ),
      child: Row(
        children: [
          // Rank
          SizedBox(
            width: 44,
            child: Text(
              rankEmoji,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isTopThree ? 26 : 18,
                fontWeight: FontWeight.bold,
                color: Colors.brown.shade700,
              ),
            ),
          ),
          // Category emoji + name
          Expanded(
            child: Row(
              children: [
                Text(emoji, style: const TextStyle(fontSize: 22)),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    _categoryDisplay(entry.category),
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Colors.brown.shade800,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          // Score
          SizedBox(
            width: 60,
            child: Text(
              "${entry.score}pts",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: isTopThree ? Colors.green.shade700 : Colors.brown.shade600,
              ),
            ),
          ),
          // Time + fast badge
          SizedBox(
            width: 56,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  entry.formattedTime,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.brown.shade500,
                  ),
                ),
                if (entry.timeSeconds <= 30)
                  const Text("⚡", style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
