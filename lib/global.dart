import 'dart:math';
import 'package:animal_puzzle_game/modal.dart';
import 'package:flutter/material.dart';

class Global {
  static List<Content> list = [];
  static List<Content> currentPool = [];
  static String image = "";
  static String title = "";
  static String categoryKey = ""; // always English
  static String language = 'en';

  static String tr(String en, String bg) => language == 'bg' ? bg : en;

  static List<Content> randomFrom(List<Content> pool, [int count = 6]) {
    final copy = List<Content>.from(pool)..shuffle(Random());
    final selected = copy.take(count).toList();
    for (final item in selected) {
      item.isDropped = false;
    }
    return selected;
  }

  // ─── Animals (23 items) ───────────────────────────────────────────────────
  static final List<Content> animals = [
    Content(value: "Cow",        bg: "Крава",      image: "assets/animals/cow.png",      isDropped: false),
    Content(value: "Elephant",   bg: "Слон",       image: "assets/animals/elephant.png", isDropped: false),
    Content(value: "Horse",      bg: "Кон",        image: "assets/animals/horse.png",    isDropped: false),
    Content(value: "Monkey",     bg: "Маймуна",    image: "assets/animals/monkey.png",   isDropped: false),
    Content(value: "Panda",      bg: "Панда",      image: "assets/animals/panda.png",    isDropped: false),
    Content(value: "Lion",       bg: "Лъв",        emoji: "🦁",  isDropped: false),
    Content(value: "Tiger",      bg: "Тигър",      emoji: "🐯",  isDropped: false),
    Content(value: "Bear",       bg: "Мечка",      emoji: "🐻",  isDropped: false),
    Content(value: "Dog",        bg: "Куче",       emoji: "🐶",  isDropped: false),
    Content(value: "Cat",        bg: "Коте",       emoji: "🐱",  isDropped: false),
    Content(value: "Rabbit",     bg: "Заек",       emoji: "🐰",  isDropped: false),
    Content(value: "Fox",        bg: "Лисица",     emoji: "🦊",  isDropped: false),
    Content(value: "Giraffe",    bg: "Жираф",      emoji: "🦒",  isDropped: false),
    Content(value: "Zebra",      bg: "Зебра",      emoji: "🦓",  isDropped: false),
    Content(value: "Penguin",    bg: "Пингвин",    emoji: "🐧",  isDropped: false),
    Content(value: "Duck",       bg: "Патица",     emoji: "🦆",  isDropped: false),
    Content(value: "Frog",       bg: "Жаба",       emoji: "🐸",  isDropped: false),
    Content(value: "Parrot",     bg: "Папагал",    emoji: "🦜",  isDropped: false),
    Content(value: "Crocodile",  bg: "Крокодил",   emoji: "🐊",  isDropped: false),
    Content(value: "Deer",       bg: "Елен",       emoji: "🦌",  isDropped: false),
    Content(value: "Camel",      bg: "Камила",     emoji: "🐪",  isDropped: false),
    Content(value: "Kangaroo",   bg: "Кенгуру",    emoji: "🦘",  isDropped: false),
    Content(value: "Koala",      bg: "Коала",      emoji: "🐨",  isDropped: false),
  ];

  // ─── Fruits (17 items) ───────────────────────────────────────────────────
  static final List<Content> fruits = [
    Content(value: "Apple",       bg: "Ябълка",    image: "assets/fruits/apple.png",      isDropped: false),
    Content(value: "Banana",      bg: "Банан",     image: "assets/fruits/banana.png",     isDropped: false),
    Content(value: "Grapes",      bg: "Грозде",    image: "assets/fruits/greps.png",      isDropped: false),
    Content(value: "Kiwi",        bg: "Киви",      image: "assets/fruits/kiwi.png",       isDropped: false),
    Content(value: "Watermelon",  bg: "Диня",      image: "assets/fruits/watermelon.png", isDropped: false),
    Content(value: "Orange",      bg: "Портокал",  emoji: "🍊",  isDropped: false),
    Content(value: "Strawberry",  bg: "Ягода",     emoji: "🍓",  isDropped: false),
    Content(value: "Cherry",      bg: "Череша",    emoji: "🍒",  isDropped: false),
    Content(value: "Pear",        bg: "Круша",     emoji: "🍐",  isDropped: false),
    Content(value: "Pineapple",   bg: "Ананас",    emoji: "🍍",  isDropped: false),
    Content(value: "Lemon",       bg: "Лимон",     emoji: "🍋",  isDropped: false),
    Content(value: "Mango",       bg: "Манго",     emoji: "🥭",  isDropped: false),
    Content(value: "Peach",       bg: "Праскова",  emoji: "🍑",  isDropped: false),
    Content(value: "Blueberry",   bg: "Боровинка", emoji: "🫐",  isDropped: false),
    Content(value: "Coconut",     bg: "Кокос",     emoji: "🥥",  isDropped: false),
    Content(value: "Avocado",     bg: "Авокадо",   emoji: "🥑",  isDropped: false),
    Content(value: "Melon",       bg: "Пъпеш",     emoji: "🍈",  isDropped: false),
  ];

  // ─── Vegetables (16 items) ───────────────────────────────────────────────
  static final List<Content> vegetables = [
    Content(value: "Carrot",        bg: "Морков",       emoji: "🥕",  isDropped: false),
    Content(value: "Corn",          bg: "Царевица",     emoji: "🌽",  isDropped: false),
    Content(value: "Tomato",        bg: "Домат",        emoji: "🍅",  isDropped: false),
    Content(value: "Broccoli",      bg: "Броколи",      emoji: "🥦",  isDropped: false),
    Content(value: "Cucumber",      bg: "Краставица",   emoji: "🥒",  isDropped: false),
    Content(value: "Potato",        bg: "Картоф",       emoji: "🥔",  isDropped: false),
    Content(value: "Eggplant",      bg: "Патладжан",    emoji: "🍆",  isDropped: false),
    Content(value: "Onion",         bg: "Лук",          emoji: "🧅",  isDropped: false),
    Content(value: "Mushroom",      bg: "Гъба",         emoji: "🍄",  isDropped: false),
    Content(value: "Pumpkin",       bg: "Тиква",        emoji: "🎃",  isDropped: false),
    Content(value: "Garlic",        bg: "Чесън",        emoji: "🧄",  isDropped: false),
    Content(value: "Pepper",        bg: "Чушка",        emoji: "🫑",  isDropped: false),
    Content(value: "Cabbage",       bg: "Зеле",         emoji: "🥬",  isDropped: false),
    Content(value: "Peas",          bg: "Грах",         emoji: "🫛",  isDropped: false),
    Content(value: "Chili",         bg: "Люта чушка",   emoji: "🌶️",  isDropped: false),
    Content(value: "Sweet Potato",  bg: "Сладък картоф",emoji: "🍠",  isDropped: false),
  ];

  // ─── Flowers (9 unique emoji items) ──────────────────────────────────────
  static final List<Content> flowers = [
    Content(value: "Rose",           bg: "Роза",           emoji: "🌹",  isDropped: false),
    Content(value: "Tulip",          bg: "Лале",           emoji: "🌷",  isDropped: false),
    Content(value: "Sunflower",      bg: "Слънчоглед",     emoji: "🌻",  isDropped: false),
    Content(value: "Daisy",          bg: "Маргаритка",     emoji: "🌼",  isDropped: false),
    Content(value: "Hibiscus",       bg: "Хибискус",       emoji: "🌺",  isDropped: false),
    Content(value: "Cherry Blossom", bg: "Черешов цвят",   emoji: "🌸",  isDropped: false),
    Content(value: "Lotus",          bg: "Лотос",          emoji: "🪷",  isDropped: false),
    Content(value: "Bouquet",        bg: "Букет",          emoji: "💐",  isDropped: false),
    Content(value: "Lavender",       bg: "Лавандула",      emoji: "🪻",  isDropped: false),
  ];

  // ─── Professions (16 items) ──────────────────────────────────────────────
  static final List<Content> professions = [
    Content(value: "Doctor",      bg: "Лекар",              icon: Icons.medical_services,      color: const Color(0xFFE57373), isDropped: false),
    Content(value: "Teacher",     bg: "Учител",             icon: Icons.school,                color: const Color(0xFF64B5F6), isDropped: false),
    Content(value: "Chef",        bg: "Готвач",             icon: Icons.restaurant,            color: const Color(0xFFFFB74D), isDropped: false),
    Content(value: "Firefighter", bg: "Пожарникар",         icon: Icons.local_fire_department, color: const Color(0xFFFF7043), isDropped: false),
    Content(value: "Pilot",       bg: "Пилот",              icon: Icons.flight,                color: const Color(0xFF90A4AE), isDropped: false),
    Content(value: "Police",      bg: "Полицай",            icon: Icons.local_police,          color: const Color(0xFF1565C0), isDropped: false),
    Content(value: "Engineer",    bg: "Инженер",            icon: Icons.engineering,           color: const Color(0xFF78909C), isDropped: false),
    Content(value: "Astronaut",   bg: "Астронавт",          icon: Icons.rocket_launch,         color: const Color(0xFF4A148C), isDropped: false),
    Content(value: "Farmer",      bg: "Земеделец",          icon: Icons.agriculture,           color: const Color(0xFF558B2F), isDropped: false),
    Content(value: "Artist",      bg: "Художник",           icon: Icons.brush,                 color: const Color(0xFFEC407A), isDropped: false),
    Content(value: "Scientist",   bg: "Учен",               icon: Icons.science,               color: const Color(0xFF00838F), isDropped: false),
    Content(value: "Nurse",       bg: "Медицинска сестра",  icon: Icons.medication,            color: const Color(0xFF00ACC1), isDropped: false),
    Content(value: "Judge",       bg: "Съдия",              icon: Icons.gavel,                 color: const Color(0xFF5D4037), isDropped: false),
    Content(value: "Mechanic",    bg: "Механик",            icon: Icons.build,                 color: const Color(0xFF546E7A), isDropped: false),
    Content(value: "Architect",   bg: "Архитект",           icon: Icons.architecture,          color: const Color(0xFF6D4C41), isDropped: false),
    Content(value: "Barber",      bg: "Бръснар",            emoji: "💈",  isDropped: false),
  ];

  // ─── Vehicles (16 items) ─────────────────────────────────────────────────
  static final List<Content> vehicles = [
    Content(value: "Car",          bg: "Кола",               icon: Icons.directions_car,      color: const Color(0xFF42A5F5), isDropped: false),
    Content(value: "Bus",          bg: "Автобус",            icon: Icons.directions_bus,      color: const Color(0xFFFFCA28), isDropped: false),
    Content(value: "Train",        bg: "Влак",               icon: Icons.train,               color: const Color(0xFFAB47BC), isDropped: false),
    Content(value: "Bike",         bg: "Велосипед",          icon: Icons.two_wheeler,         color: const Color(0xFF66BB6A), isDropped: false),
    Content(value: "Boat",         bg: "Лодка",              icon: Icons.directions_boat,     color: const Color(0xFF26C6DA), isDropped: false),
    Content(value: "Airplane",     bg: "Самолет",            icon: Icons.airplanemode_active, color: const Color(0xFF8D6E63), isDropped: false),
    Content(value: "Helicopter",   bg: "Хеликоптер",         emoji: "🚁",  isDropped: false),
    Content(value: "Rocket",       bg: "Ракета",             emoji: "🚀",  isDropped: false),
    Content(value: "Tractor",      bg: "Трактор",            emoji: "🚜",  isDropped: false),
    Content(value: "Truck",        bg: "Камион",             emoji: "🚚",  isDropped: false),
    Content(value: "Scooter",      bg: "Скутер",             emoji: "🛵",  isDropped: false),
    Content(value: "Ambulance",    bg: "Линейка",            emoji: "🚑",  isDropped: false),
    Content(value: "Fire Truck",   bg: "Пожарна",            emoji: "🚒",  isDropped: false),
    Content(value: "Police Car",   bg: "Полицейска кола",    emoji: "🚓",  isDropped: false),
    Content(value: "Sailboat",     bg: "Ветроходна лодка",   emoji: "⛵",  isDropped: false),
    Content(value: "Hot Air Balloon", bg: "Балон",           emoji: "🎈",  isDropped: false),
  ];

  // ─── Weather (13 items) ──────────────────────────────────────────────────
  static final List<Content> weather = [
    Content(value: "Sun",       bg: "Слънце",       icon: Icons.wb_sunny,  color: const Color(0xFFFFCA28), isDropped: false),
    Content(value: "Cloud",     bg: "Облак",        icon: Icons.cloud,     color: const Color(0xFF90A4AE), isDropped: false),
    Content(value: "Rain",      bg: "Дъжд",         icon: Icons.grain,     color: const Color(0xFF42A5F5), isDropped: false),
    Content(value: "Snow",      bg: "Сняг",         icon: Icons.ac_unit,   color: const Color(0xFF4FC3F7), isDropped: false),
    Content(value: "Wind",      bg: "Вятър",        icon: Icons.air,       color: const Color(0xFF80CBC4), isDropped: false),
    Content(value: "Rainbow",   bg: "Дъга",         emoji: "🌈",  isDropped: false),
    Content(value: "Thunder",   bg: "Гръмотевица",  emoji: "⛈️",  isDropped: false),
    Content(value: "Fog",       bg: "Мъгла",        emoji: "🌫️",  isDropped: false),
    Content(value: "Tornado",   bg: "Торнадо",      emoji: "🌪️",  isDropped: false),
    Content(value: "Hail",      bg: "Градушка",     emoji: "🌨️",  isDropped: false),
    Content(value: "Hot",       bg: "Горещо",       emoji: "🌡️",  isDropped: false),
    Content(value: "Drizzle",   bg: "Ръмеж",        emoji: "🌧️",  isDropped: false),
    Content(value: "Lightning", bg: "Мълния",       emoji: "⚡",  isDropped: false),
  ];

  // ─── Colors (11 items) ───────────────────────────────────────────────────
  static final List<Content> colors = [
    Content(value: "Red",    bg: "Червено",   emoji: "🔴",  isDropped: false),
    Content(value: "Orange", bg: "Оранжево",  emoji: "🟠",  isDropped: false),
    Content(value: "Yellow", bg: "Жълто",     emoji: "🟡",  isDropped: false),
    Content(value: "Green",  bg: "Зелено",    emoji: "🟢",  isDropped: false),
    Content(value: "Blue",   bg: "Синьо",     emoji: "🔵",  isDropped: false),
    Content(value: "Purple", bg: "Лилаво",    emoji: "🟣",  isDropped: false),
    Content(value: "Brown",  bg: "Кафяво",    emoji: "🟤",  isDropped: false),
    Content(value: "Black",  bg: "Черно",     emoji: "⚫",  isDropped: false),
    Content(value: "White",  bg: "Бяло",      emoji: "⚪",  isDropped: false),
    Content(value: "Pink",   bg: "Розово",    emoji: "🩷",  isDropped: false),
    Content(value: "Gray",   bg: "Сиво",      emoji: "🩶",  isDropped: false),
  ];

  // ─── Shapes (13 items) ───────────────────────────────────────────────────
  static final List<Content> shapes = [
    Content(value: "Circle",    bg: "Кръг",         emoji: "⭕",  isDropped: false),
    Content(value: "Square",    bg: "Квадрат",      emoji: "⬛",  isDropped: false),
    Content(value: "Triangle",  bg: "Триъгълник",   emoji: "🔺",  isDropped: false),
    Content(value: "Star",      bg: "Звезда",       emoji: "⭐",  isDropped: false),
    Content(value: "Heart",     bg: "Сърце",        emoji: "❤️",  isDropped: false),
    Content(value: "Diamond",   bg: "Диамант",      emoji: "💎",  isDropped: false),
    Content(value: "Arrow",     bg: "Стрелка",      emoji: "➡️",  isDropped: false),
    Content(value: "Moon",      bg: "Луна",         emoji: "🌙",  isDropped: false),
    Content(value: "Oval",      bg: "Овал",         emoji: "🥚",  isDropped: false),
    Content(value: "Cross",     bg: "Кръст",        emoji: "✝️",  isDropped: false),
    Content(value: "Spiral",    bg: "Спирала",      emoji: "🌀",  isDropped: false),
    Content(value: "Shield",    bg: "Щит",          emoji: "🛡️",  isDropped: false),
    Content(value: "Hourglass", bg: "Пясъчен часовник", emoji: "⌛", isDropped: false),
  ];

  // ─── Ocean (15 items) ────────────────────────────────────────────────────
  static final List<Content> ocean = [
    Content(value: "Shark",      bg: "Акула",        emoji: "🦈",  isDropped: false),
    Content(value: "Dolphin",    bg: "Делфин",       emoji: "🐬",  isDropped: false),
    Content(value: "Octopus",    bg: "Октопод",      emoji: "🐙",  isDropped: false),
    Content(value: "Fish",       bg: "Риба",         emoji: "🐟",  isDropped: false),
    Content(value: "Crab",       bg: "Рак",          emoji: "🦀",  isDropped: false),
    Content(value: "Whale",      bg: "Кит",          emoji: "🐳",  isDropped: false),
    Content(value: "Turtle",     bg: "Костенурка",   emoji: "🐢",  isDropped: false),
    Content(value: "Jellyfish",  bg: "Медуза",       emoji: "🪼",  isDropped: false),
    Content(value: "Lobster",    bg: "Омар",         emoji: "🦞",  isDropped: false),
    Content(value: "Seal",       bg: "Тюлен",        emoji: "🦭",  isDropped: false),
    Content(value: "Coral",      bg: "Корал",        emoji: "🪸",  isDropped: false),
    Content(value: "Shrimp",     bg: "Скарида",      emoji: "🦐",  isDropped: false),
    Content(value: "Squid",      bg: "Калмар",       emoji: "🦑",  isDropped: false),
    Content(value: "Clam",       bg: "Мида",         emoji: "🐚",  isDropped: false),
    Content(value: "Pufferfish", bg: "Риба-бал",     emoji: "🐡",  isDropped: false),
  ];

  // ─── Sports (16 items) ───────────────────────────────────────────────────
  static final List<Content> sports = [
    Content(value: "Football",    bg: "Футбол",           emoji: "⚽",  isDropped: false),
    Content(value: "Basketball",  bg: "Баскетбол",        emoji: "🏀",  isDropped: false),
    Content(value: "Tennis",      bg: "Тенис",            emoji: "🎾",  isDropped: false),
    Content(value: "Baseball",    bg: "Бейзбол",          emoji: "⚾",  isDropped: false),
    Content(value: "Volleyball",  bg: "Волейбол",         emoji: "🏐",  isDropped: false),
    Content(value: "Swimming",    bg: "Плуване",          emoji: "🏊",  isDropped: false),
    Content(value: "Cycling",     bg: "Колоездене",       emoji: "🚴",  isDropped: false),
    Content(value: "Golf",        bg: "Голф",             emoji: "⛳",  isDropped: false),
    Content(value: "Boxing",      bg: "Бокс",             emoji: "🥊",  isDropped: false),
    Content(value: "Skiing",      bg: "Ски",              emoji: "⛷️",  isDropped: false),
    Content(value: "Surfing",     bg: "Сърфиране",        emoji: "🏄",  isDropped: false),
    Content(value: "Archery",     bg: "Стрелба с лък",    emoji: "🏹",  isDropped: false),
    Content(value: "Ping Pong",   bg: "Тенис на маса",    emoji: "🏓",  isDropped: false),
    Content(value: "Rugby",       bg: "Ръгби",            emoji: "🏉",  isDropped: false),
    Content(value: "Hockey",      bg: "Хокей",            emoji: "🏒",  isDropped: false),
    Content(value: "Badminton",   bg: "Бадминтон",        emoji: "🏸",  isDropped: false),
  ];

  // ─── Body Parts (16 items) ───────────────────────────────────────────────
  static final List<Content> bodyParts = [
    Content(value: "Eye",     bg: "Око",      emoji: "👁️",  isDropped: false),
    Content(value: "Nose",    bg: "Нос",      emoji: "👃",  isDropped: false),
    Content(value: "Mouth",   bg: "Уста",     emoji: "👄",  isDropped: false),
    Content(value: "Ear",     bg: "Ухо",      emoji: "👂",  isDropped: false),
    Content(value: "Hand",    bg: "Ръка",     emoji: "✋",  isDropped: false),
    Content(value: "Foot",    bg: "Стъпало",  emoji: "🦶",  isDropped: false),
    Content(value: "Tooth",   bg: "Зъб",      emoji: "🦷",  isDropped: false),
    Content(value: "Brain",   bg: "Мозък",    emoji: "🧠",  isDropped: false),
    Content(value: "Bone",    bg: "Кост",     emoji: "🦴",  isDropped: false),
    Content(value: "Muscle",  bg: "Мускул",   emoji: "💪",  isDropped: false),
    Content(value: "Leg",     bg: "Крак",     emoji: "🦵",  isDropped: false),
    Content(value: "Tongue",  bg: "Език",     emoji: "👅",  isDropped: false),
    Content(value: "Finger",  bg: "Пръст",    emoji: "👆",  isDropped: false),
    Content(value: "Thumb",   bg: "Палец",    emoji: "👍",  isDropped: false),
    Content(value: "Elbow",   bg: "Лакът",    emoji: "🦾",  isDropped: false),
    Content(value: "Knee",    bg: "Коляно",   emoji: "🦿",  isDropped: false),
  ];

  // ─── Categories ──────────────────────────────────────────────────────────
  static List<GameCategory> get categories => [
    GameCategory(
      title: "Animals",     bgTitle: "Животни",
      backgroundImage: "assets/animals/forest.jpg",
      items: animals,
      previewImage: "assets/animals/animals.png",
      accentColor: const Color(0xFF8D6E63),
    ),
    GameCategory(
      title: "Fruits",      bgTitle: "Плодове",
      backgroundImage: "assets/fruits/fruit_background.jpg",
      items: fruits,
      previewImage: "assets/fruits/fruits.png",
      accentColor: const Color(0xFFD2691E),
    ),
    GameCategory(
      title: "Vegetables",  bgTitle: "Зеленчуци",
      backgroundImage: "assets/fruits/fruit_background.jpg",
      items: vegetables,
      previewEmoji: "🥕",
      accentColor: const Color(0xFF43A047),
    ),
    GameCategory(
      title: "Flowers",     bgTitle: "Цветя",
      backgroundImage: "assets/animals/forest.jpg",
      items: flowers,
      previewEmoji: "🌸",
      accentColor: const Color(0xFFEC407A),
    ),
    GameCategory(
      title: "Professions", bgTitle: "Професии",
      backgroundImage: "assets/animals/game.jpg",
      items: professions,
      previewIcon: Icons.work,
      accentColor: const Color(0xFF5C6BC0),
    ),
    GameCategory(
      title: "Vehicles",    bgTitle: "Превозни средства",
      backgroundImage: "assets/animals/game.jpg",
      items: vehicles,
      previewIcon: Icons.directions_car,
      accentColor: const Color(0xFF00897B),
    ),
    GameCategory(
      title: "Weather",     bgTitle: "Времето",
      backgroundImage: "assets/animals/forest.jpg",
      items: weather,
      previewIcon: Icons.wb_sunny,
      accentColor: const Color(0xFFFFB300),
    ),
    GameCategory(
      title: "Colors",      bgTitle: "Цветове",
      backgroundImage: "assets/animals/game.jpg",
      items: colors,
      previewEmoji: "🎨",
      accentColor: const Color(0xFFE91E63),
    ),
    GameCategory(
      title: "Shapes",      bgTitle: "Фигури",
      backgroundImage: "assets/animals/forest.jpg",
      items: shapes,
      previewEmoji: "⭐",
      accentColor: const Color(0xFF7B1FA2),
    ),
    GameCategory(
      title: "Ocean",       bgTitle: "Океанът",
      backgroundImage: "assets/animals/forest.jpg",
      items: ocean,
      previewEmoji: "🌊",
      accentColor: const Color(0xFF0288D1),
    ),
    GameCategory(
      title: "Sports",      bgTitle: "Спортове",
      backgroundImage: "assets/animals/game.jpg",
      items: sports,
      previewEmoji: "⚽",
      accentColor: const Color(0xFF388E3C),
    ),
    GameCategory(
      title: "Body Parts",  bgTitle: "Части на тялото",
      backgroundImage: "assets/animals/game.jpg",
      items: bodyParts,
      previewEmoji: "👁️",
      accentColor: const Color(0xFFF57C00),
    ),
  ];
}
