import 'package:flutter/material.dart';

import 'screens/topic_page.dart';

void main() => runApp(const VocabApp());

class VocabApp extends StatelessWidget {
  const VocabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thẻ học từ vựng',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF3F51B5),
        useMaterial3: true,
      ),
      home: const TopicPage(),
    );
  }
}
