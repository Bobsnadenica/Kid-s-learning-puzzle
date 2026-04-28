import 'package:flutter/material.dart';

class Content {
  final String value;
  final String? bg;
  final String? image;
  final String? emoji;
  final IconData? icon;
  final Color? color;
  late bool isDropped;

  Content({
    required this.value,
    this.bg,
    this.image,
    this.emoji,
    this.icon,
    this.color,
    required this.isDropped,
  }) : assert(
          image != null || emoji != null || icon != null,
          'Every content item needs a visual.',
        );
}

class GameCategory {
  final String title;
  final String? bgTitle;
  final String backgroundImage;
  final List<Content> items;
  final String? previewImage;
  final String? previewEmoji;
  final IconData? previewIcon;
  final Color accentColor;

  GameCategory({
    required this.title,
    this.bgTitle,
    required this.backgroundImage,
    required this.items,
    this.previewImage,
    this.previewEmoji,
    this.previewIcon,
    required this.accentColor,
  }) : assert(
          previewImage != null || previewEmoji != null || previewIcon != null,
          'Every category needs a preview visual.',
        );
}
