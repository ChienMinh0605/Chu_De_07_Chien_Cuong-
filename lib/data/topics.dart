import 'package:flutter/material.dart';

import '../models/vocab.dart';

const List<Topic> topics = [
  Topic(
    name: 'Công nghệ',
    icon: Icons.computer,
    color: Color(0xFF3F51B5),
    words: [
      Word(
        english: 'algorithm',
        type: 'n.',
        meaning: 'thuật toán',
        example: 'This algorithm sorts the list quickly.',
      ),
      Word(
        english: 'database',
        type: 'n.',
        meaning: 'cơ sở dữ liệu',
        example: 'User data is stored in a database.',
      ),
      Word(
        english: 'deploy',
        type: 'v.',
        meaning: 'triển khai (đưa ứng dụng lên môi trường chạy thật)',
        example: 'We deploy the app every Friday.',
      ),
      Word(
        english: 'debug',
        type: 'v.',
        meaning: 'gỡ lỗi',
        example: 'She spent an hour debugging the login screen.',
      ),
      Word(
        english: 'callback',
        type: 'n.',
        meaning: 'hàm gọi lại',
        example: 'The button runs a callback when it is pressed.',
      ),
      Word(
        english: 'interface',
        type: 'n.',
        meaning: 'giao diện',
        example: 'The new interface is easier to use.',
      ),
      Word(
        english: 'framework',
        type: 'n.',
        meaning: 'bộ khung phát triển phần mềm',
        example: 'Flutter is a UI framework from Google.',
      ),
      Word(
        english: 'update',
        type: 'v.',
        meaning: 'cập nhật',
        example: 'Tap the button to update the screen.',
      ),
    ],
  ),
  Topic(
    name: 'Du lịch',
    icon: Icons.flight_takeoff,
    color: Color(0xFF00897B),
    words: [
      Word(
        english: 'luggage',
        type: 'n.',
        meaning: 'hành lý',
        example: 'Please keep your luggage with you.',
      ),
      Word(
        english: 'passport',
        type: 'n.',
        meaning: 'hộ chiếu',
        example: 'Show your passport at the counter.',
      ),
      Word(
        english: 'itinerary',
        type: 'n.',
        meaning: 'lịch trình chuyến đi',
        example: 'Our itinerary includes three cities.',
      ),
      Word(
        english: 'souvenir',
        type: 'n.',
        meaning: 'quà lưu niệm',
        example: 'I bought a souvenir for my sister.',
      ),
      Word(
        english: 'reservation',
        type: 'n.',
        meaning: 'sự đặt chỗ trước',
        example: 'I have a reservation for two nights.',
      ),
      Word(
        english: 'destination',
        type: 'n.',
        meaning: 'điểm đến',
        example: 'Da Nang is a popular destination.',
      ),
      Word(
        english: 'currency',
        type: 'n.',
        meaning: 'tiền tệ',
        example: 'What currency do they use in Japan?',
      ),
      Word(
        english: 'delay',
        type: 'v.',
        meaning: 'hoãn, làm chậm trễ',
        example: 'Our flight was delayed by two hours.',
      ),
    ],
  ),
  Topic(
    name: 'Đồ ăn',
    icon: Icons.restaurant,
    color: Color(0xFFE64A19),
    words: [
      Word(
        english: 'recipe',
        type: 'n.',
        meaning: 'công thức nấu ăn',
        example: 'This recipe needs only five ingredients.',
      ),
      Word(
        english: 'ingredient',
        type: 'n.',
        meaning: 'nguyên liệu',
        example: 'Fresh ingredients make the dish better.',
      ),
      Word(
        english: 'appetizer',
        type: 'n.',
        meaning: 'món khai vị',
        example: 'We ordered spring rolls as an appetizer.',
      ),
      Word(
        english: 'dessert',
        type: 'n.',
        meaning: 'món tráng miệng',
        example: 'Ice cream is my favourite dessert.',
      ),
      Word(
        english: 'spicy',
        type: 'adj.',
        meaning: 'cay',
        example: 'This soup is too spicy for me.',
      ),
      Word(
        english: 'grill',
        type: 'v.',
        meaning: 'nướng (trên vỉ)',
        example: 'They grill the fish over charcoal.',
      ),
      Word(
        english: 'beverage',
        type: 'n.',
        meaning: 'đồ uống',
        example: 'Beverages are served at the counter.',
      ),
      Word(
        english: 'vegetarian',
        type: 'n./adj.',
        meaning: 'người ăn chay; món chay',
        example: 'Is there a vegetarian option?',
      ),
    ],
  ),
];
