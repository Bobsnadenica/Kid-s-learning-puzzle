import 'package:flutter/material.dart';

import '../global.dart';
import '../modal.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _toggleLanguage() {
    setState(() {
      Global.language = Global.language == 'en' ? 'bg' : 'en';
    });
  }

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
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      isBg ? "Избери игра" : "Choose a Game",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Colors.brown.shade800,
                        shadows: const [
                          Shadow(color: Colors.white, blurRadius: 10),
                        ],
                      ),
                    ),
                  ),
                  _buildLanguageToggle(),
                ],
              ),
            ),
            ...Global.categories.map(
              (category) => InkWell(
                onTap: () {
                  // Reset dropped state each time a category is entered
                  for (final item in category.items) {
                    item.isDropped = false;
                  }
                  Global.list = category.items;
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

  Widget _buildLanguageToggle() {
    final bool isBg = Global.language == 'bg';
    return GestureDetector(
      onTap: _toggleLanguage,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.75),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.brown.shade400, width: 2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '🇬🇧',
              style: TextStyle(
                fontSize: isBg ? 18 : 24,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '🇧🇬',
              style: TextStyle(
                fontSize: isBg ? 24 : 18,
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
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: category.accentColor, width: 4),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 110,
              child: Center(child: _buildPreview(category)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayTitle,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Colors.brown.shade700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  isBg
                      ? "Свържи ${category.items.length} картинки с думи"
                      : "Match ${category.items.length} pictures to words",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.brown.shade500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreview(GameCategory category) {
    if (category.previewImage != null) {
      return Image.asset(category.previewImage!);
    }

    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: category.accentColor.withValues(alpha: 0.16),
      ),
      alignment: Alignment.center,
      child: category.previewEmoji != null
          ? Text(
              category.previewEmoji!,
              style: const TextStyle(fontSize: 52),
            )
          : Icon(
              category.previewIcon,
              size: 56,
              color: category.accentColor,
            ),
    );
  }
}
