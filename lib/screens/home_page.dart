import 'package:flutter/material.dart';

import '../global.dart';
import '../modal.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isBg = Global.language == 'bg';

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/animals/game.jpg"),
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 14),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Row(
                children: [
                  Image.asset(
                    "assets/logo/transparent_logo.png",
                    height: 48,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      isBg ? "Как назоваваме нещата" : "How we name things",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Colors.brown.shade800,
                        shadows: const [
                          Shadow(color: Colors.white, blurRadius: 10)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Trophy leaderboard button
                  GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed("leaderboard"),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.75),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                            color: const Color(0xFFFFD700), width: 2.5),
                      ),
                      child: const Text("🏆",
                          style: TextStyle(fontSize: 28)),
                    ),
                  ),
                ],
              ),
            ),
            ...Global.categories.map(
              (category) => InkWell(
                onTap: () {
                  Global.currentPool = category.items;
                  Global.list = Global.randomFrom(category.items);
                  Global.categoryKey = category.title;
                  Global.image = category.backgroundImage;
                  Global.title = isBg
                      ? (category.bgTitle ?? category.title)
                      : category.title;
                  Navigator.of(context).pushNamed("game_page");
                },
                child: _gameContainer(category, isBg),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gameContainer(GameCategory category, bool isBg) {
    final String displayTitle =
        isBg ? (category.bgTitle ?? category.title) : category.title;

    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: category.accentColor, width: 4),
        boxShadow: [
          BoxShadow(
            color: category.accentColor.withValues(alpha: 0.35),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 100,
              child: Center(child: _buildPreview(category)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 3,
            child: Text(
              displayTitle,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: Colors.brown.shade700,
              ),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 18,
            color: category.accentColor,
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }

  Widget _buildPreview(GameCategory category) {
    if (category.previewImage != null) {
      return Image.asset(category.previewImage!);
    }

    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: category.accentColor.withValues(alpha: 0.16),
      ),
      alignment: Alignment.center,
      child: category.previewEmoji != null
          ? Text(category.previewEmoji!, style: const TextStyle(fontSize: 48))
          : Icon(category.previewIcon, size: 52, color: category.accentColor),
    );
  }
}
