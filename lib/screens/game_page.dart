import 'package:animal_puzzle_game/modal.dart';
import 'package:flutter/material.dart';

import '../global.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int score = 0;
  int gameOver = 0;
  List<Content> list2 = [];

  @override
  void initState() {
    super.initState();
    _setup();
  }

  void _setup() {
    list2 = [...Global.list];
    list2.shuffle();
    for (final item in Global.list) {
      item.isDropped = false;
    }
    for (final item in list2) {
      item.isDropped = false;
    }
  }

  void _restart() {
    Global.list = Global.randomFrom(Global.currentPool);
    setState(() {
      score = 0;
      gameOver = 0;
      _setup();
    });
  }

  String _display(Content item) =>
      Global.language == 'bg' ? (item.bg ?? item.value) : item.value;

  @override
  Widget build(BuildContext context) {
    final bool isBg = Global.language == 'bg';
    final int itemCount = Global.list.length;
    final double availableHeight = MediaQuery.of(context).size.height * 0.76;
    final double height = (availableHeight / itemCount).clamp(58.0, 128.0);
    final double feedbackWidth = MediaQuery.of(context).size.width * 0.38;

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              opacity: 0.87,
              image: AssetImage(Global.image),
            ),
          ),
          alignment: Alignment.center,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
                child: Text(
                  Global.title.isEmpty
                      ? (isBg ? "Игра за съвпадение" : "Matching Game")
                      : Global.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Colors.brown.shade800,
                    shadows: const [Shadow(color: Colors.white, blurRadius: 14)],
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    // Left column: draggable images/emoji/icons
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(Global.list.length, (index) {
                          final item = Global.list[index];
                          return item.isDropped
                              ? SizedBox(height: height)
                              : Draggable<String>(
                                  data: item.value,
                                  childWhenDragging:
                                      _buildMatchCard(item, height, faded: true),
                                  feedback: Material(
                                    color: Colors.transparent,
                                    child: SizedBox(
                                      width: feedbackWidth,
                                      child: _buildMatchCard(item, height),
                                    ),
                                  ),
                                  child: _buildMatchCard(item, height),
                                );
                        }),
                      ),
                    ),
                    // Right column: drop target labels
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(list2.length, (index) {
                          final item = list2[index];
                          return item.isDropped
                              ? SizedBox(height: height)
                              : DragTarget<String>(
                                  onAcceptWithDetails: (details) {
                                    if (item.value == details.data) {
                                      setState(() {
                                        for (final src in Global.list) {
                                          if (src.value == item.value) {
                                            src.isDropped = true;
                                          }
                                        }
                                        item.isDropped = true;
                                        score += 10;
                                        gameOver++;
                                        if (gameOver == Global.list.length) {
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (_) => _dialog(isBg),
                                          );
                                        }
                                      });
                                    } else {
                                      setState(() => score -= 5);
                                    }
                                  },
                                  builder: (context, candidateData, _) {
                                    final bool hovering =
                                        candidateData.isNotEmpty;
                                    return Container(
                                      height: height,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(
                                            alpha: hovering ? 0.65 : 0.45),
                                        borderRadius:
                                            BorderRadius.circular(24),
                                        border: Border.all(
                                          color: hovering
                                              ? Colors.green.shade600
                                              : Colors.brown.shade700,
                                          width: 3,
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        _display(item),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          shadows: [
                                            Shadow(
                                                color: Colors.brown.shade900,
                                                blurRadius: 30),
                                            const Shadow(
                                                color: Colors.black87,
                                                blurRadius: 10),
                                          ],
                                          letterSpacing: 1.0,
                                          color: Colors.yellow.shade800,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 20,
                                        ),
                                      ),
                                    );
                                  },
                                );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                color: Colors.white.withValues(alpha: 0.5),
                padding: const EdgeInsets.all(12),
                child: Text(
                  isBg ? "  Резултат : $score" : "  Your Score : $score",
                  style: TextStyle(
                    color: Colors.brown.shade700,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMatchCard(Content item, double height, {bool faded = false}) {
    return Opacity(
      opacity: faded ? 0.35 : 1,
      child: Container(
        height: height,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.75),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: item.color ?? Colors.brown.shade400,
            width: 3,
          ),
        ),
        child: Center(child: _buildItemVisual(item, height)),
      ),
    );
  }

  Widget _buildItemVisual(Content item, double height) {
    if (item.image != null) {
      return Image.asset(item.image!, fit: BoxFit.contain);
    }
    if (item.emoji != null) {
      return FittedBox(
        child: Text(item.emoji!, style: const TextStyle(fontSize: 64)),
      );
    }
    return Icon(
      item.icon,
      size: height * 0.55,
      color: item.color ?? Colors.brown.shade700,
    );
  }

  AlertDialog _dialog(bool isBg) {
    return AlertDialog(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.brown.shade800, width: 5),
      ),
      backgroundColor: Colors.white.withValues(alpha: 0.9),
      title: Center(
        child: Text(
          isBg ? "Браво! 🎉" : "Well Done! 🎉",
          style: TextStyle(
            fontSize: 32,
            color: Colors.brown.shade800,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      content: Text(
        isBg ? "- Твоят резултат -\n$score" : "- Your Score -\n$score",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black.withValues(alpha: 0.7),
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Home button
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(
                    vertical: 12, horizontal: 16),
              ),
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("home_page", (r) => false);
              },
              child: Icon(Icons.home, color: Colors.brown.shade700),
            ),
            // Restart with NEW random items
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(
                    horizontal: 25, vertical: 12),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _restart();
              },
              child: Text(
                isBg ? "Отново" : "Restart",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.brown.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
