import 'dart:async';

import 'package:flutter/material.dart';

import '../data/topics.dart';
import '../models/vocab.dart';
import 'study_page.dart';

/// Màn hình 1: chọn chủ đề.
///
/// LÝ THUYẾT MINH HỌA: InkWell + onTap. Chạm vào chủ đề có hiệu ứng gợn
/// sóng (ripple) để người dùng biết thao tác đã được nhận.
class TopicPage extends StatelessWidget {
  const TopicPage({super.key});

  void _openTopic(BuildContext context, Topic topic) {
    unawaited(
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (_) => StudyPage(topic: topic, words: topic.words),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Thẻ học từ vựng')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text('Chọn một chủ đề', style: theme.textTheme.headlineSmall),
              const SizedBox(height: 4),
              Text(
                'Chạm thẻ để lật, vuốt phải nếu đã thuộc, vuốt trái nếu chưa.',
                style: TextStyle(color: theme.colorScheme.outline),
              ),
              const SizedBox(height: 16),
              for (final topic in topics)
                TopicTile(
                  topic: topic,
                  onTap: () => _openTopic(context, topic),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Một dòng chủ đề. Không tự điều hướng: chỉ gọi [onTap] (callback).
class TopicTile extends StatelessWidget {
  const TopicTile({super.key, required this.topic, required this.onTap});

  final Topic topic;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias, // giữ ripple trong góc bo của thẻ
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: topic.color.withValues(alpha: 0.15),
                child: Icon(topic.icon, color: topic.color, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(topic.name, style: theme.textTheme.titleMedium),
                    Text(
                      '${topic.words.length} từ',
                      style: TextStyle(color: theme.colorScheme.outline),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
