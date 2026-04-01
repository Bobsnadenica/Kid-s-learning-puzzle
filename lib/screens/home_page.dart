import 'package:flutter/material.dart';

import '../global.dart';
import '../modal.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Text(
                "Choose a Matching Game",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: Colors.brown.shade800,
                  shadows: const [
                    Shadow(color: Colors.white, blurRadius: 10),
                  ],
                ),
              ),
            ),
            ...Global.categories.map(
              (category) => InkWell(
                onTap: () {
                  Global.list = category.items;
                  Global.image = category.backgroundImage;
                  Global.title = category.title;
                  Navigator.of(context).pushNamed("game_page");
                },
                child: gameContainer(category),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget gameContainer(GameCategory category) {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: category.accentColor, width: 5),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 140,
              child: Center(
                child: _buildPreview(category),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.title,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Colors.brown.shade700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Match ${category.items.length} fun pictures to words",
                  style: TextStyle(
                    fontSize: 18,
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
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: category.accentColor.withValues(alpha: 0.16),
      ),
      alignment: Alignment.center,
      child: category.previewEmoji != null
          ? Text(
              category.previewEmoji!,
              style: const TextStyle(fontSize: 64),
            )
          : Icon(
              category.previewIcon,
              size: 68,
              color: category.accentColor,
            ),
    );
  }
}
