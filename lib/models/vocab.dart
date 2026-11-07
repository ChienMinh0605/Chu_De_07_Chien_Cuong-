import 'package:flutter/material.dart';

/// Một từ vựng. Đây là dữ liệu cố định, không phải trạng thái:
/// nội dung từ không đổi khi người dùng thao tác.
class Word {
  const Word({
    required this.english,
    required this.type,
    required this.meaning,
    required this.example,
  });

  final String english;

  /// Từ loại: n., v., adj.
  final String type;
  final String meaning;
  final String example;
}

/// Một chủ đề gồm nhiều từ.
class Topic {
  const Topic({
    required this.name,
    required this.icon,
    required this.color,
    required this.words,
  });

  final String name;
  final IconData icon;
  final Color color;
  final List<Word> words;
}
