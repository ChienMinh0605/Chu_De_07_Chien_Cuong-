import 'dart:async';

import 'package:flutter/material.dart';

import '../models/vocab.dart';
import 'study_page.dart';

/// Màn hình 3: kết quả.
///
/// Không giữ trạng thái: chỉ hiển thị kết quả StudyPage truyền sang.
/// Nút "Học lại từ chưa thuộc" bị vô hiệu hóa (onPressed: null)
/// khi không còn từ nào chưa thuộc.
class ResultPage extends StatelessWidget {
  const ResultPage({
    super.key,
    required this.topic,
    required this.known,
    required this.unknown,
  });

  final Topic topic;
  final List<Word> known;
  final List<Word> unknown;

  void _study(BuildContext context, List<Word> words) {
    unawaited(
      Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
          builder: (_) => StudyPage(topic: topic, words: words),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final total = known.length + unknown.length;
    final allKnown = unknown.isEmpty;

    return Scaffold(
      appBar: AppBar(title: Text('Kết quả: ${topic.name}')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Icon(
                allKnown ? Icons.emoji_events : Icons.school,
                size: 72,
                color: allKnown ? Colors.amber.shade700 : topic.color,
              ),
              const SizedBox(height: 12),
              Text(
                'Đã thuộc ${known.length}/$total từ',
                key: const Key('result_score'),
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              LinearProgressIndicator(
                value: total == 0 ? 0 : known.length / total,
                minHeight: 10,
                color: Colors.green.shade600,
                backgroundColor: Colors.red.shade100,
                borderRadius: BorderRadius.circular(5),
              ),
              const SizedBox(height: 20),
              if (allKnown)
                const Text(
                  'Tuyệt vời, bạn đã thuộc hết các từ trong lượt này!',
                  textAlign: TextAlign.center,
                )
              else ...[
                Text('Cần ôn lại:', style: theme.textTheme.titleMedium),
                for (final word in unknown)
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.close, color: Colors.red.shade400),
                    title: Text(word.english),
                    subtitle: Text(word.meaning),
                  ),
              ],
              const SizedBox(height: 20),
              FilledButton.icon(
                key: const Key('btn_retry_unknown'),
                onPressed: allKnown ? null : () => _study(context, unknown),
                icon: const Icon(Icons.replay),
                label: Text('Học lại ${unknown.length} từ chưa thuộc'),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () => _study(context, topic.words),
                icon: const Icon(Icons.restart_alt),
                label: const Text('Học lại cả chủ đề'),
              ),
              const SizedBox(height: 8),
              TextButton.icon(
                key: const Key('btn_back_topics'),
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.list),
                label: const Text('Chọn chủ đề khác'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
