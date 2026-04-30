# How We Name Things 🎓

A bilingual drag-and-drop word-learning game for young children, supporting **English** and **Bulgarian**. Built with Flutter — runs on iOS and Android (web and macOS also available).

---

## How the app works

### Screen flow

```
Language picker → Home (category list) → Game → Win dialog (restart / home)
                                       ↗
                          Leaderboard (trophy icon on home)
```

### 1 — Language picker
The first screen shows two big flag buttons. The child (or parent) picks **English 🇬🇧** or **Bulgarian 🇧🇬**. The entire app — all labels, category names, and text-to-speech — switches to that language. The choice is held in memory for the session; it can be changed by restarting the app.

### 2 — Home screen (category grid)
A scrollable list of 19 learning categories. Each card shows:
- A **preview image or emoji** representing the category
- The **category name** in the chosen language
- A **coloured accent border and drop-shadow** matching the category's theme
- An **arrow chevron** hinting it is tappable

Tapping a card shuffles the category's item pool, picks 6 random items, and launches the game. The **🏆 trophy** button (top right) opens the leaderboard. The **🔊/🔇 mute button** (top row) silences all text-to-speech.

### 3 — Game screen
Two columns fill the screen:

| Left column | Right column |
|---|---|
| 6 picture/emoji cards (draggable) | 6 word labels (drop targets) |

The child picks up a picture and drags it onto the word they think matches. Words are shuffled separately from pictures so positions don't correspond.

**Correct match**
- Both the picture and word disappear (replaced by empty space)
- ✅ Green Lottie animation plays for 800 ms
- Medium haptic pulse fires
- Score +10

**Wrong match**
- Nothing disappears
- ❌ Red Lottie animation plays for 600 ms
- Heavy haptic pulse fires
- Score −5

**Round complete (all 6 matched)**
- 🎉 Confetti Lottie animation plays for 1.5 s
- Result is saved to the leaderboard (category + score + time)
- A dialog shows the final score and elapsed time with two buttons: **Home** or **Restart**

**Text-to-speech**
- Dragging a picture speaks its name in the current language
- Tapping a word label speaks that word
- The **🔊/🔇 button** in the top-right of the game header mutes/unmutes instantly

**Score bar (bottom)**
- ⭐ current score on the left
- ⏱️ elapsed timer (mm:ss) on the right, counting up while the round is active

**Home button (top-left)** — returns to the category list without saving a result.

### 4 — Leaderboard
All completed rounds are listed, sorted by score (descending). Each row shows:
- Rank medal (🥇 🥈 🥉 or number)
- Category emoji + name in the current language
- Score in points
- Time (with ⚡ badge if finished under 30 seconds)

A 🗑️ delete button (top-right) clears all records after confirmation. Records are persisted to device storage via SharedPreferences and survive app restarts.

---

## Categories (19)

| # | English | Bulgarian | Items | Visual type |
|---|---|---|---|---|
| 1 | Animals | Животни | 30 | Photos + emoji |
| 2 | Fruits | Плодове | 17 | Photos + emoji |
| 3 | Vegetables | Зеленчуци | 16 | Emoji |
| 4 | Flowers | Цветя | 9 | Emoji |
| 5 | Professions | Професии | 16 | Illustrations |
| 6 | Vehicles | Превозни средства | 16 | Illustrations |
| 7 | Weather | Времето | 13 | Icons + emoji |
| 8 | Colors | Цветове | 11 | Emoji |
| 9 | Shapes | Фигури | 13 | Emoji |
| 10 | Ocean | Океанът | 15 | Illustrations |
| 11 | Sports | Спортове | 21 | Emoji |
| 12 | Body Parts | Части на тялото | 16 | Emoji |
| 13 | Space | Космос | 15 | Emoji |
| 14 | Clothing | Облекло | 15 | Emoji |
| 15 | Food | Храна | 15 | Emoji |
| 16 | Instruments | Инструменти | 12 | Emoji |
| 17 | Numbers | Числа | 10 | Emoji (1️⃣–🔟) |
| 18 | Emotions | Емоции | 12 | Emoji |
| 19 | Insects | Насекоми | 12 | Emoji |

Each game round draws **6 random items** from the category's pool, so repeated plays feel different.

---

## Features

| Feature | Detail |
|---|---|
| Bilingual EN / BG | Language toggle on first screen; all UI, labels, TTS, and OS home screen name switch |
| Text-to-speech | Words spoken on drag-start and on word-tap; rate 0.45×, pitch 1.1 (kid-friendly) |
| Mute toggle | 🔊/🔇 button on home and game screens; persists for the session |
| Lottie animations | yes.json (correct), no.json (wrong), confetti.json (winner) — raw JSON format |
| Haptic feedback | Medium impact = correct; heavy impact = wrong |
| Leaderboard | Sorted by score; persists between app launches |
| App icon | Generated from `assets/logo/logo.png` via flutter_launcher_icons |
| Localised app name | iOS & Android show "Как назоваваме нещата" when device language is Bulgarian |
| Backgrounds | Each category has its own matching background photo |

---

## Tech stack

| Layer | Library / approach |
|---|---|
| Framework | Flutter 3.x (Dart 3) |
| State | Plain `setState` — no Bloc/Riverpod/Provider |
| Persistence | `shared_preferences ^2.3.0` |
| Animations | `lottie ^3.1.0` |
| TTS | `flutter_tts ^4.0.0` — uses device's native speech engine |
| Icons | `flutter_launcher_icons ^0.14.3` |
| Font icons | `font_awesome_flutter ^10.12.0` |

---

## Project layout

```
lib/
  main.dart               App entry — binds Leaderboard + TtsService, defines route table
  global.dart             Single source of truth: all 19 categories and 250+ items
  modal.dart              Data models: Content, GameCategory
  tts_service.dart        TTS singleton (init, speak, stop, muted flag)
  leaderboard.dart        LeaderboardEntry model + Leaderboard persistence
  screens/
    language_page.dart    First screen — language selection
    home_page.dart        Category list (StatefulWidget for mute button state)
    game_page.dart        Core game — drag & drop, scoring, feedback, timer
    leaderboard_page.dart Score history

assets/
  animals/                23 PNG animal photos + game.jpg
  animals_emoji/          18 PNG emoji-style animal images
  fruits/                 5 PNG fruit photos + fruits.png preview
  fruits_emoji/           12 PNG fruit emoji images
  backgrounds/            19 JPG backgrounds (one per category)
  professions/            15 profession illustration PNGs
  vehicles/               15 vehicle illustration PNGs
  ocean/                  14 ocean creature PNGs
  lottie/                 yes.json · no.json · confetti.json
  logo/                   logo.png (launcher) · transparent_logo.png (in-app)

android/app/src/main/
  AndroidManifest.xml           android:label="@string/app_name"
  res/values/strings.xml        English app name
  res/values-bg/strings.xml     Bulgarian app name

ios/Runner/
  Info.plist                    CFBundleDisplayName (fallback)
  en.lproj/InfoPlist.strings    English app name
  bg.lproj/InfoPlist.strings    Bulgarian app name
  Runner.xcodeproj/             bg registered in knownRegions, InfoPlist.strings in Resources
```

---

## Text-to-speech notes

TTS uses the **device's built-in speech engine** (AVSpeechSynthesizer on iOS, Android TTS on Android). No internet required.

- **English** (`en-US`) — available on all devices by default
- **Bulgarian** (`bg-BG`) — requires the Bulgarian voice to be installed on the device

  *On iOS*: Settings → Accessibility → Spoken Content → Voices → Bulgarian  
  *On Android*: Settings → General management → Language → Text-to-speech → Install Bulgarian voice

If Bulgarian voice is unavailable, the device falls back to its default voice (usually English). The game still works; it just reads words with a wrong accent.

---

## App name localisation

The OS home screen shows the app name in the device language:

| Device language | App name shown |
|---|---|
| Bulgarian | Как назоваваме нещата |
| Any other | How we name things |

If the name still shows as *Howwenamethings* (no spaces), the device has a **stale install**. Fix:

```bash
flutter clean
# uninstall the old app from the device first, then:
flutter run
```

---

## Running locally

```bash
flutter pub get
flutter run
```

## Regenerating launcher icons

```bash
dart run flutter_launcher_icons
```

---

## Adding a new category

1. **`lib/global.dart`** — add a new content list:
   ```dart
   static final List<Content> myCategory = [
     Content(value: "Dog", bg: "Куче", emoji: "🐕", isDropped: false),
     // ...
   ];
   ```
2. **`lib/global.dart`** — add a `GameCategory` entry to the `categories` getter:
   ```dart
   GameCategory(
     title: "MyCategory",  bgTitle: "Моята категория",
     backgroundImage: "assets/backgrounds/mycategory.jpg",
     items: myCategory,
     previewEmoji: "🐕",
     accentColor: const Color(0xFF795548),
   ),
   ```
3. **`lib/screens/leaderboard_page.dart`** — add to `_categoryEmojis`:
   ```dart
   "MyCategory": "🐕",
   ```
4. If using image assets (not emoji), add them under `assets/mycategory/` and register the folder in `pubspec.yaml` under `flutter › assets`.
5. Commit, advance `main` with `git update-ref refs/heads/main HEAD`, and sync changed files to the main working tree.

---

## Content model reference

```dart
// lib/modal.dart
class Content {
  String value;      // English word — used as the match key
  String? bg;        // Bulgarian word
  String? image;     // asset path, e.g. "assets/animals/cow.png"
  String? emoji;     // emoji char, e.g. "🐄"
  IconData? icon;    // Flutter Material icon (fallback when no image/emoji)
  Color? color;      // icon colour
  bool isDropped;    // managed by game engine — reset each round
}

class GameCategory {
  String title;           // English name — also used as leaderboard key
  String? bgTitle;        // Bulgarian name
  String backgroundImage; // asset path for game background
  List<Content> items;    // full item pool (game picks 6 per round)
  String? previewImage;   // home card preview (image path)
  String? previewEmoji;   // home card preview (emoji)
  IconData? previewIcon;  // home card preview (icon fallback)
  Color accentColor;      // border/shadow colour on home cards
}
```
