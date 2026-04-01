import 'package:animal_puzzle_game/modal.dart';
import 'package:flutter/material.dart';

class Global {
  static List<Content> list = [];
  static String image = "";
  static String title = "";

  static final List<Content> animals = [
    Content(value: "Cow", image: "assets/animals/cow.png", isDropped: false),
    Content(
      value: "Elephant",
      image: "assets/animals/elephant.png",
      isDropped: false,
    ),
    Content(
        value: "Horse", image: "assets/animals/horse.png", isDropped: false),
    Content(
      value: "Monkey",
      image: "assets/animals/monkey.png",
      isDropped: false,
    ),
    Content(
        value: "Panda", image: "assets/animals/panda.png", isDropped: false),
  ];

  static final List<Content> fruits = [
    Content(value: "Apple", image: "assets/fruits/apple.png", isDropped: false),
    Content(
      value: "Banana",
      image: "assets/fruits/banana.png",
      isDropped: false,
    ),
    Content(value: "Greps", image: "assets/fruits/greps.png", isDropped: false),
    Content(value: "Kiwi", image: "assets/fruits/kiwi.png", isDropped: false),
    Content(
      value: "Watermelon",
      image: "assets/fruits/watermelon.png",
      isDropped: false,
    ),
  ];

  static final List<Content> vegetables = [
    Content(value: "Carrot", emoji: "🥕", isDropped: false),
    Content(value: "Corn", emoji: "🌽", isDropped: false),
    Content(value: "Tomato", emoji: "🍅", isDropped: false),
    Content(value: "Broccoli", emoji: "🥦", isDropped: false),
    Content(value: "Cucumber", emoji: "🥒", isDropped: false),
  ];

  static final List<Content> professions = [
    Content(
      value: "Doctor",
      icon: Icons.medical_services,
      color: const Color(0xFFE57373),
      isDropped: false,
    ),
    Content(
      value: "Teacher",
      icon: Icons.school,
      color: const Color(0xFF64B5F6),
      isDropped: false,
    ),
    Content(
      value: "Chef",
      icon: Icons.restaurant,
      color: const Color(0xFFFFB74D),
      isDropped: false,
    ),
    Content(
      value: "Firefighter",
      icon: Icons.local_fire_department,
      color: const Color(0xFFFF7043),
      isDropped: false,
    ),
    Content(
      value: "Pilot",
      icon: Icons.flight,
      color: const Color(0xFF90A4AE),
      isDropped: false,
    ),
  ];

  static final List<Content> vehicles = [
    Content(
      value: "Car",
      icon: Icons.directions_car,
      color: const Color(0xFF42A5F5),
      isDropped: false,
    ),
    Content(
      value: "Bus",
      icon: Icons.directions_bus,
      color: const Color(0xFFFFCA28),
      isDropped: false,
    ),
    Content(
      value: "Train",
      icon: Icons.train,
      color: const Color(0xFFAB47BC),
      isDropped: false,
    ),
    Content(
      value: "Bike",
      icon: Icons.two_wheeler,
      color: const Color(0xFF66BB6A),
      isDropped: false,
    ),
    Content(
      value: "Boat",
      icon: Icons.directions_boat,
      color: const Color(0xFF26C6DA),
      isDropped: false,
    ),
  ];

  static final List<Content> flowers = [
    Content(value: "Rose", emoji: "🌹", isDropped: false),
    Content(value: "Tulip", emoji: "🌷", isDropped: false),
    Content(value: "Sunflower", emoji: "🌻", isDropped: false),
    Content(value: "Blossom", emoji: "🌼", isDropped: false),
    Content(value: "Hibiscus", emoji: "🌺", isDropped: false),
  ];

  static final List<Content> weather = [
    Content(
      value: "Sun",
      icon: Icons.wb_sunny,
      color: const Color(0xFFFFCA28),
      isDropped: false,
    ),
    Content(
      value: "Cloud",
      icon: Icons.cloud,
      color: const Color(0xFF90A4AE),
      isDropped: false,
    ),
    Content(
      value: "Rain",
      icon: Icons.grain,
      color: const Color(0xFF42A5F5),
      isDropped: false,
    ),
    Content(
      value: "Snow",
      icon: Icons.ac_unit,
      color: const Color(0xFF4FC3F7),
      isDropped: false,
    ),
    Content(value: "Rainbow", emoji: "🌈", isDropped: false),
  ];

  static final List<GameCategory> categories = [
    GameCategory(
      title: "Animals Game",
      backgroundImage: "assets/animals/forest.jpg",
      items: animals,
      previewImage: "assets/animals/animals.png",
      accentColor: const Color(0xFF8D6E63),
    ),
    GameCategory(
      title: "Fruits Game",
      backgroundImage: "assets/fruits/fruit_background.jpg",
      items: fruits,
      previewImage: "assets/fruits/fruits.png",
      accentColor: const Color(0xFFD2691E),
    ),
    GameCategory(
      title: "Vegetables Game",
      backgroundImage: "assets/fruits/fruit_background.jpg",
      items: vegetables,
      previewEmoji: "🥕",
      accentColor: const Color(0xFF43A047),
    ),
    GameCategory(
      title: "Professions Game",
      backgroundImage: "assets/animals/game.jpg",
      items: professions,
      previewIcon: Icons.work,
      accentColor: const Color(0xFF5C6BC0),
    ),
    GameCategory(
      title: "Vehicles Game",
      backgroundImage: "assets/animals/game.jpg",
      items: vehicles,
      previewIcon: Icons.directions_car,
      accentColor: const Color(0xFF00897B),
    ),
    GameCategory(
      title: "Flowers Game",
      backgroundImage: "assets/animals/forest.jpg",
      items: flowers,
      previewEmoji: "🌸",
      accentColor: const Color(0xFFEC407A),
    ),
    GameCategory(
      title: "Weather Game",
      backgroundImage: "assets/animals/forest.jpg",
      items: weather,
      previewIcon: Icons.wb_sunny,
      accentColor: const Color(0xFFFFB300),
    ),
  ];
}
