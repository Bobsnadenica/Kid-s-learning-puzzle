import 'package:animal_puzzle_game/modal.dart';
import 'package:flutter/material.dart';

class Global {
  static List<Content> list = [];
  static String image = "";
  static String title = "";
  static String language = 'en'; // 'en' or 'bg'

  static String tr(String en, String bg) => language == 'bg' ? bg : en;

  static final List<Content> animals = [
    Content(value: "Cow", bg: "Крава", image: "assets/animals/cow.png", isDropped: false),
    Content(value: "Elephant", bg: "Слон", image: "assets/animals/elephant.png", isDropped: false),
    Content(value: "Horse", bg: "Кон", image: "assets/animals/horse.png", isDropped: false),
    Content(value: "Monkey", bg: "Маймуна", image: "assets/animals/monkey.png", isDropped: false),
    Content(value: "Panda", bg: "Панда", image: "assets/animals/panda.png", isDropped: false),
    Content(value: "Lion", bg: "Лъв", emoji: "🦁", isDropped: false),
  ];

  static final List<Content> fruits = [
    Content(value: "Apple", bg: "Ябълка", image: "assets/fruits/apple.png", isDropped: false),
    Content(value: "Banana", bg: "Банан", image: "assets/fruits/banana.png", isDropped: false),
    Content(value: "Grapes", bg: "Грозде", image: "assets/fruits/greps.png", isDropped: false),
    Content(value: "Kiwi", bg: "Киви", image: "assets/fruits/kiwi.png", isDropped: false),
    Content(value: "Watermelon", bg: "Диня", image: "assets/fruits/watermelon.png", isDropped: false),
    Content(value: "Orange", bg: "Портокал", emoji: "🍊", isDropped: false),
  ];

  static final List<Content> vegetables = [
    Content(value: "Carrot", bg: "Морков", emoji: "🥕", isDropped: false),
    Content(value: "Corn", bg: "Царевица", emoji: "🌽", isDropped: false),
    Content(value: "Tomato", bg: "Домат", emoji: "🍅", isDropped: false),
    Content(value: "Broccoli", bg: "Броколи", emoji: "🥦", isDropped: false),
    Content(value: "Cucumber", bg: "Краставица", emoji: "🥒", isDropped: false),
    Content(value: "Potato", bg: "Картоф", emoji: "🥔", isDropped: false),
  ];

  static final List<Content> flowers = [
    Content(value: "Rose", bg: "Роза", emoji: "🌹", isDropped: false),
    Content(value: "Tulip", bg: "Лале", emoji: "🌷", isDropped: false),
    Content(value: "Sunflower", bg: "Слънчоглед", emoji: "🌻", isDropped: false),
    Content(value: "Blossom", bg: "Цвят", emoji: "🌼", isDropped: false),
    Content(value: "Hibiscus", bg: "Хибискус", emoji: "🌺", isDropped: false),
    Content(value: "Daisy", bg: "Маргаритка", emoji: "💐", isDropped: false),
  ];

  static final List<Content> professions = [
    Content(value: "Doctor", bg: "Лекар", icon: Icons.medical_services, color: const Color(0xFFE57373), isDropped: false),
    Content(value: "Teacher", bg: "Учител", icon: Icons.school, color: const Color(0xFF64B5F6), isDropped: false),
    Content(value: "Chef", bg: "Готвач", icon: Icons.restaurant, color: const Color(0xFFFFB74D), isDropped: false),
    Content(value: "Firefighter", bg: "Пожарникар", icon: Icons.local_fire_department, color: const Color(0xFFFF7043), isDropped: false),
    Content(value: "Pilot", bg: "Пилот", icon: Icons.flight, color: const Color(0xFF90A4AE), isDropped: false),
    Content(value: "Police", bg: "Полицай", icon: Icons.local_police, color: const Color(0xFF1565C0), isDropped: false),
  ];

  static final List<Content> vehicles = [
    Content(value: "Car", bg: "Кола", icon: Icons.directions_car, color: const Color(0xFF42A5F5), isDropped: false),
    Content(value: "Bus", bg: "Автобус", icon: Icons.directions_bus, color: const Color(0xFFFFCA28), isDropped: false),
    Content(value: "Train", bg: "Влак", icon: Icons.train, color: const Color(0xFFAB47BC), isDropped: false),
    Content(value: "Bike", bg: "Велосипед", icon: Icons.two_wheeler, color: const Color(0xFF66BB6A), isDropped: false),
    Content(value: "Boat", bg: "Лодка", icon: Icons.directions_boat, color: const Color(0xFF26C6DA), isDropped: false),
    Content(value: "Airplane", bg: "Самолет", icon: Icons.airplanemode_active, color: const Color(0xFF8D6E63), isDropped: false),
  ];

  static final List<Content> weather = [
    Content(value: "Sun", bg: "Слънце", icon: Icons.wb_sunny, color: const Color(0xFFFFCA28), isDropped: false),
    Content(value: "Cloud", bg: "Облак", icon: Icons.cloud, color: const Color(0xFF90A4AE), isDropped: false),
    Content(value: "Rain", bg: "Дъжд", icon: Icons.grain, color: const Color(0xFF42A5F5), isDropped: false),
    Content(value: "Snow", bg: "Сняг", icon: Icons.ac_unit, color: const Color(0xFF4FC3F7), isDropped: false),
    Content(value: "Rainbow", bg: "Дъга", emoji: "🌈", isDropped: false),
    Content(value: "Wind", bg: "Вятър", icon: Icons.air, color: const Color(0xFF80CBC4), isDropped: false),
  ];

  static final List<Content> colors = [
    Content(value: "Red", bg: "Червено", emoji: "🔴", isDropped: false),
    Content(value: "Orange", bg: "Оранжево", emoji: "🟠", isDropped: false),
    Content(value: "Yellow", bg: "Жълто", emoji: "🟡", isDropped: false),
    Content(value: "Green", bg: "Зелено", emoji: "🟢", isDropped: false),
    Content(value: "Blue", bg: "Синьо", emoji: "🔵", isDropped: false),
    Content(value: "Purple", bg: "Лилаво", emoji: "🟣", isDropped: false),
  ];

  static final List<Content> shapes = [
    Content(value: "Circle", bg: "Кръг", emoji: "⭕", isDropped: false),
    Content(value: "Square", bg: "Квадрат", emoji: "⬛", isDropped: false),
    Content(value: "Triangle", bg: "Триъгълник", emoji: "🔺", isDropped: false),
    Content(value: "Star", bg: "Звезда", emoji: "⭐", isDropped: false),
    Content(value: "Heart", bg: "Сърце", emoji: "❤️", isDropped: false),
    Content(value: "Diamond", bg: "Диамант", emoji: "💎", isDropped: false),
  ];

  static final List<Content> ocean = [
    Content(value: "Shark", bg: "Акула", emoji: "🦈", isDropped: false),
    Content(value: "Dolphin", bg: "Делфин", emoji: "🐬", isDropped: false),
    Content(value: "Octopus", bg: "Октопод", emoji: "🐙", isDropped: false),
    Content(value: "Fish", bg: "Риба", emoji: "🐟", isDropped: false),
    Content(value: "Crab", bg: "Рак", emoji: "🦀", isDropped: false),
    Content(value: "Whale", bg: "Кит", emoji: "🐳", isDropped: false),
  ];

  static final List<Content> sports = [
    Content(value: "Football", bg: "Футбол", emoji: "⚽", isDropped: false),
    Content(value: "Basketball", bg: "Баскетбол", emoji: "🏀", isDropped: false),
    Content(value: "Tennis", bg: "Тенис", emoji: "🎾", isDropped: false),
    Content(value: "Baseball", bg: "Бейзбол", emoji: "⚾", isDropped: false),
    Content(value: "Volleyball", bg: "Волейбол", emoji: "🏐", isDropped: false),
    Content(value: "Swimming", bg: "Плуване", emoji: "🏊", isDropped: false),
  ];

  static final List<Content> bodyParts = [
    Content(value: "Eye", bg: "Око", emoji: "👁️", isDropped: false),
    Content(value: "Nose", bg: "Нос", emoji: "👃", isDropped: false),
    Content(value: "Mouth", bg: "Уста", emoji: "👄", isDropped: false),
    Content(value: "Ear", bg: "Ухо", emoji: "👂", isDropped: false),
    Content(value: "Hand", bg: "Ръка", emoji: "✋", isDropped: false),
    Content(value: "Foot", bg: "Крак", emoji: "🦶", isDropped: false),
  ];

  static List<GameCategory> get categories => [
    GameCategory(
      title: "Animals",
      bgTitle: "Животни",
      backgroundImage: "assets/animals/forest.jpg",
      items: animals,
      previewImage: "assets/animals/animals.png",
      accentColor: const Color(0xFF8D6E63),
    ),
    GameCategory(
      title: "Fruits",
      bgTitle: "Плодове",
      backgroundImage: "assets/fruits/fruit_background.jpg",
      items: fruits,
      previewImage: "assets/fruits/fruits.png",
      accentColor: const Color(0xFFD2691E),
    ),
    GameCategory(
      title: "Vegetables",
      bgTitle: "Зеленчуци",
      backgroundImage: "assets/fruits/fruit_background.jpg",
      items: vegetables,
      previewEmoji: "🥕",
      accentColor: const Color(0xFF43A047),
    ),
    GameCategory(
      title: "Flowers",
      bgTitle: "Цветя",
      backgroundImage: "assets/animals/forest.jpg",
      items: flowers,
      previewEmoji: "🌸",
      accentColor: const Color(0xFFEC407A),
    ),
    GameCategory(
      title: "Professions",
      bgTitle: "Професии",
      backgroundImage: "assets/animals/game.jpg",
      items: professions,
      previewIcon: Icons.work,
      accentColor: const Color(0xFF5C6BC0),
    ),
    GameCategory(
      title: "Vehicles",
      bgTitle: "Превозни средства",
      backgroundImage: "assets/animals/game.jpg",
      items: vehicles,
      previewIcon: Icons.directions_car,
      accentColor: const Color(0xFF00897B),
    ),
    GameCategory(
      title: "Weather",
      bgTitle: "Времето",
      backgroundImage: "assets/animals/forest.jpg",
      items: weather,
      previewIcon: Icons.wb_sunny,
      accentColor: const Color(0xFFFFB300),
    ),
    GameCategory(
      title: "Colors",
      bgTitle: "Цветове",
      backgroundImage: "assets/animals/game.jpg",
      items: colors,
      previewEmoji: "🎨",
      accentColor: const Color(0xFFE91E63),
    ),
    GameCategory(
      title: "Shapes",
      bgTitle: "Фигури",
      backgroundImage: "assets/animals/forest.jpg",
      items: shapes,
      previewEmoji: "⭐",
      accentColor: const Color(0xFF7B1FA2),
    ),
    GameCategory(
      title: "Ocean",
      bgTitle: "Океанът",
      backgroundImage: "assets/animals/forest.jpg",
      items: ocean,
      previewEmoji: "🌊",
      accentColor: const Color(0xFF0288D1),
    ),
    GameCategory(
      title: "Sports",
      bgTitle: "Спортове",
      backgroundImage: "assets/animals/game.jpg",
      items: sports,
      previewEmoji: "⚽",
      accentColor: const Color(0xFF388E3C),
    ),
    GameCategory(
      title: "Body Parts",
      bgTitle: "Части на тялото",
      backgroundImage: "assets/animals/game.jpg",
      items: bodyParts,
      previewEmoji: "👁️",
      accentColor: const Color(0xFFF57C00),
    ),
  ];
}
