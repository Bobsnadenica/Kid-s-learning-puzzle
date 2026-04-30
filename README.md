# How We Name Things 🎓

A bilingual kids drag-and-drop matching game for learning English and Bulgarian vocabulary. Built with Flutter — runs on iOS, Android, Web, and macOS.

## What it does

Children drag a picture/emoji on the left and drop it onto the matching word on the right. Each round uses 6 random items from the chosen category. Correct matches earn +10 points; wrong ones deduct 5. A timer tracks speed. Scores are saved to a leaderboard.

## Features

- **19 categories** — Animals, Fruits, Vegetables, Flowers, Professions, Vehicles, Weather, Colors, Shapes, Ocean, Sports, Body Parts, Space, Clothing, Food, Instruments, Numbers, Emotions, Insects
- **250+ items** with images or emoji visuals
- **Bilingual** — EN / BG toggle on the language screen; all UI text and category names switch
- **Lottie animations** — ✅ correct, ❌ wrong, 🎉 winner celebrations
- **Haptic feedback** — medium impact on correct match, heavy impact on wrong
- **Leaderboard** — top scores per category, persisted via SharedPreferences
- **App icon** generated from `assets/logo/logo.png`

## Tech stack

| Layer | Choice |
|---|---|
| Framework | Flutter (Dart) |
| State | Plain `setState` — no Bloc/Riverpod |
| Persistence | `shared_preferences` |
| Animations | `lottie ^3.1.0` (raw JSON, not dotLottie) |
| Icons | `flutter_launcher_icons ^0.14.3` |

## Project layout

```
lib/
  main.dart               — app entry, route table
  global.dart             — all game data + category registry
  modal.dart              — Content & GameCategory models
  leaderboard.dart        — LeaderboardEntry + Leaderboard (SharedPreferences)
  screens/
    language_page.dart    — language picker (first screen)
    home_page.dart        — category grid
    game_page.dart        — drag-and-drop game
    leaderboard_page.dart — score history

assets/
  animals/          — 23 PNG images + game.jpg background
  animals_emoji/    — PNG emoji-style animal images
  fruits/           — 5 PNG fruit images
  fruits_emoji/     — 12 PNG fruit emoji images
  backgrounds/      — category background JPGs
  professions/      — profession PNG images
  vehicles/         — vehicle PNG images
  ocean/            — ocean creature PNG images
  lottie/           — yes.json, no.json, confetti.json
  logo/             — logo.png (launcher), transparent_logo.png (in-app)

ios/Runner/Info.plist     — CFBundleDisplayName = "How we name things"
android/app/src/main/AndroidManifest.xml — android:label
```

## Adding a new category

1. Add a `static final List<Content> myCategory = [...]` block in `lib/global.dart`
2. Add a `GameCategory(...)` entry to the `categories` getter in the same file
3. Add `"MyCategory": "emoji"` to `_categoryEmojis` in `lib/screens/leaderboard_page.dart`
4. If you use images, add them under `assets/` and register the folder in `pubspec.yaml`

## Running

```bash
flutter pub get
flutter run
```

## Generating launcher icons

```bash
dart run flutter_launcher_icons
```
