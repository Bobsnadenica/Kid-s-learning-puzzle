import 'dart:async';
import 'package:animal_puzzle_game/leaderboard.dart';
import 'package:animal_puzzle_game/modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import '../tts_service.dart';

import '../global.dart';

const _kLottieCorrect = 'assets/lottie/yes.json';
const _kLottieWrong   = 'assets/lottie/no.json';
const _kLottieWinner  = 'assets/lottie/confetti.json';

enum _FeedbackType { none, correct, wrong, winner }

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int score = 0;
  int gameOver = 0;
  List<Content> list2 = [];
  _FeedbackType _feedbackType = _FeedbackType.none;

  final Stopwatch _stopwatch = Stopwatch();
  Timer? _ticker;
  int _elapsedSeconds = 0;

  Timer? _dragSpeakTimer;
  int _introGen = 0;

  @override
  void initState() {
    super.initState();
    _setup();
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _dragSpeakTimer?.cancel();
    super.dispose();
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
    _stopwatch
      ..reset()
      ..start();
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _elapsedSeconds = _stopwatch.elapsed.inSeconds);
    });
    _startIntroRead();
  }

  /// Reads all 6 words aloud in sequence when a round starts.
  /// Uses a generation counter so restarts cancel any pending reads.
  void _startIntroRead() {
    if (TtsService.muted) return;
    _introGen++;
    final gen = _introGen;
    final items = List<Content>.from(Global.list);
    for (int i = 0; i < items.length; i++) {
      Future.delayed(Duration(milliseconds: 500 + i * 850), () {
        if (!mounted || _introGen != gen) return;
        if (!items[i].isDropped) {
          TtsService.speak(_display(items[i]), isBg: Global.language == 'bg');
        }
      });
    }
  }

  void _restart() {
    Global.list = Global.randomFrom(Global.currentPool);
    setState(() {
      score = 0;
      gameOver = 0;
      _elapsedSeconds = 0;
      _feedbackType = _FeedbackType.none;
      _setup();
    });
  }

  void _stopTimer() {
    _stopwatch.stop();
    _ticker?.cancel();
    setState(() => _elapsedSeconds = _stopwatch.elapsed.inSeconds);
  }

  void _showFeedback(_FeedbackType type, {int dismissAfterMs = 800}) {
    if (!mounted) return;
    setState(() => _feedbackType = type);
    if (dismissAfterMs > 0) {
      Future.delayed(Duration(milliseconds: dismissAfterMs), () {
        if (mounted) setState(() => _feedbackType = _FeedbackType.none);
      });
    }
  }

  String _display(Content item) =>
      Global.language == 'bg' ? (item.bg ?? item.value) : item.value;

  String _formatTime(int secs) {
    final m = secs ~/ 60;
    final s = secs % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final bool isBg = Global.language == 'bg';
    final int itemCount = Global.list.length;
    final double availableHeight = MediaQuery.of(context).size.height * 0.76;
    final double height = (availableHeight / itemCount).clamp(58.0, 128.0);
    final double feedbackWidth = MediaQuery.of(context).size.width * 0.38;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
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
                    padding: const EdgeInsets.fromLTRB(8, 10, 8, 6),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.of(context)
                              .pushNamedAndRemoveUntil(
                                  "home_page", (r) => false),
                          icon: Icon(Icons.home_rounded,
                              color: Colors.brown.shade800, size: 30),
                        ),
                        Expanded(
                          child: Text(
                            Global.title.isEmpty
                                ? (isBg ? "Игра за съвпадение" : "Matching Game")
                                : Global.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                              color: Colors.brown.shade800,
                              shadows: const [
                                Shadow(color: Colors.white, blurRadius: 14)
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => setState(
                              () => TtsService.muted = !TtsService.muted),
                          icon: Icon(
                            TtsService.muted
                                ? Icons.volume_off_rounded
                                : Icons.volume_up_rounded,
                            color: Colors.brown.shade800,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        // Left: draggable visuals
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(Global.list.length, (index) {
                              final item = Global.list[index];
                              return item.isDropped
                                  ? SizedBox(height: height)
                                  : Draggable<String>(
                                      data: item.value,
                                      onDragStarted: () {
                                        _dragSpeakTimer?.cancel();
                                        _dragSpeakTimer = Timer(
                                          const Duration(milliseconds: 180),
                                          () => TtsService.speak(
                                            _display(item),
                                            isBg: Global.language == 'bg',
                                          ),
                                        );
                                      },
                                      onDragEnd: (_) =>
                                          _dragSpeakTimer?.cancel(),
                                      onDraggableCanceled: (_, __) =>
                                          _dragSpeakTimer?.cancel(),
                                      childWhenDragging: _buildMatchCard(
                                          item, height,
                                          faded: true),
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
                        // Right: drop target labels
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
                                          });
                                          HapticFeedback.mediumImpact();
                                          TtsService.speak(
                                            Global.language == 'bg'
                                                ? 'Браво! ${_display(item)}'
                                                : 'Great! ${_display(item)}',
                                            isBg: Global.language == 'bg',
                                          );
                                          if (gameOver == Global.list.length) {
                                            _stopTimer();
                                            Leaderboard.add(LeaderboardEntry(
                                              category: Global.categoryKey,
                                              score: score,
                                              timeSeconds: _elapsedSeconds,
                                            ));
                                            _showFeedback(_FeedbackType.winner,
                                                dismissAfterMs: 0);
                                            Future.delayed(
                                                const Duration(
                                                    milliseconds: 1500), () {
                                              if (!mounted) return;
                                              setState(() => _feedbackType =
                                                  _FeedbackType.none);
                                              if (!context.mounted) return;
                                              showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                builder: (_) => _dialog(
                                                    Global.language == 'bg'),
                                              );
                                            });
                                          } else {
                                            _showFeedback(_FeedbackType.correct);
                                          }
                                        } else {
                                          setState(() => score -= 5);
                                          HapticFeedback.heavyImpact();
                                          TtsService.speak(
                                            Global.language == 'bg'
                                                ? 'Опитай пак!'
                                                : 'Try again!',
                                            isBg: Global.language == 'bg',
                                          );
                                          _showFeedback(_FeedbackType.wrong,
                                              dismissAfterMs: 600);
                                        }
                                      },
                                      builder: (context, candidateData, _) {
                                        final bool hovering =
                                            candidateData.isNotEmpty;
                                        return GestureDetector(
                                          onTap: () => TtsService.speak(
                                            _display(item),
                                            isBg: Global.language == 'bg',
                                          ),
                                          child: Container(
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
                                                    color:
                                                        Colors.brown.shade900,
                                                    blurRadius: 30),
                                                const Shadow(
                                                    color: Colors.black87,
                                                    blurRadius: 10),
                                              ],
                                              letterSpacing: 1.0,
                                              color: Colors.yellow.shade800,
                                              fontWeight: FontWeight.w900,
                                              fontSize: 22,
                                            ),
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
                  // Score + timer bar
                  Container(
                    width: double.infinity,
                    color: Colors.white.withValues(alpha: 0.5),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "⭐ $score",
                          style: TextStyle(
                            color: Colors.brown.shade700,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Row(
                          children: [
                            const Text("⏱️",
                                style: TextStyle(fontSize: 20)),
                            const SizedBox(width: 4),
                            Text(
                              _formatTime(_elapsedSeconds),
                              style: TextStyle(
                                color: Colors.brown.shade700,
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _buildFeedbackOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackOverlay() {
    if (_feedbackType == _FeedbackType.none) return const SizedBox.shrink();

    final url = switch (_feedbackType) {
      _FeedbackType.correct => _kLottieCorrect,
      _FeedbackType.wrong   => _kLottieWrong,
      _FeedbackType.winner  => _kLottieWinner,
      _FeedbackType.none    => '',
    };

    final fallbackIcon = _feedbackType == _FeedbackType.wrong
        ? Icons.cancel_rounded
        : Icons.check_circle_rounded;
    final fallbackColor = _feedbackType == _FeedbackType.wrong
        ? Colors.red.shade400
        : Colors.green.shade400;

    return Positioned.fill(
      child: IgnorePointer(
        child: ColoredBox(
          color: Colors.black.withValues(alpha: 0.30),
          child: Center(
            child: Lottie.asset(
              url,
              width: 280,
              height: 280,
              fit: BoxFit.contain,
              repeat: false,
              errorBuilder: (_, __, ___) => Icon(
                fallbackIcon,
                size: 120,
                color: fallbackColor,
              ),
            ),
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
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isBg ? "Резултат: $score точки" : "Score: $score pts",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.brown.shade800,
              fontWeight: FontWeight.w800,
              fontSize: 26,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "⏱️  ${_formatTime(_elapsedSeconds)}",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.brown.shade600,
              fontWeight: FontWeight.w700,
              fontSize: 22,
            ),
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
