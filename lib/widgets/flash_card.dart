import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../models/vocab.dart';

/// Thẻ từ vựng: chạm để lật, vuốt để trả lời.
///
/// LÝ THUYẾT MINH HỌA:
/// - GestureDetector: nhận onTap (lật thẻ) và onHorizontalDrag… (vuốt).
/// - Callback: thẻ KHÔNG tự quyết định "đã thuộc" hay "chưa thuộc".
///   Nó chỉ gọi [onSwipe] để báo sự kiện lên StudyPage.
/// - Trạng thái cục bộ: [_isFlipped] và [_dragDx] chỉ thẻ này cần biết,
///   nên nằm trong State của thẻ, không nâng lên màn hình cha.
class FlashCard extends StatefulWidget {
  const FlashCard({
    super.key,
    required this.word,
    required this.onFlip,
    required this.onSwipe,
  });

  final Word word;

  /// Báo lên cha: thẻ vừa lật, kèm giá trị mới của isFlipped.
  final ValueChanged<bool> onFlip;

  /// Báo lên cha: người dùng vuốt xong. true = vuốt phải = đã thuộc.
  final ValueChanged<bool> onSwipe;

  @override
  State<FlashCard> createState() => _FlashCardState();
}

class _FlashCardState extends State<FlashCard> {
  // ========== TRẠNG THÁI CỤC BỘ ==========
  bool _isFlipped = false;
  double _dragDx = 0;
  bool _isDragging = false;

  static const _swipeDistance = 120.0;
  static const _swipeVelocity = 900.0;

  void _flip() {
    setState(() => _isFlipped = !_isFlipped);
    widget.onFlip(_isFlipped);
  }

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      _isDragging = true;
      _dragDx += details.delta.dx;
    });
  }

  void _onDragEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    final farEnough = _dragDx.abs() > _swipeDistance;
    final fastEnough = velocity.abs() > _swipeVelocity;

    if (farEnough || fastEnough) {
      final known = (farEnough ? _dragDx : velocity) > 0;
      setState(() => _isDragging = false);
      widget.onSwipe(known);
    } else {
      // Vuốt chưa đủ xa: thẻ trượt về chỗ cũ.
      setState(() {
        _isDragging = false;
        _dragDx = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final swipeProgress = (_dragDx / _swipeDistance).clamp(-1.0, 1.0);

    return GestureDetector(
      key: const Key('flashcard'),
      onTap: _flip,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      child: AnimatedContainer(
        duration: _isDragging
            ? Duration.zero
            : const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        transformAlignment: Alignment.center,
        transform: Matrix4.translationValues(_dragDx, 0, 0)
          ..multiply(Matrix4.rotationZ(_dragDx / 1500)),
        child: SizedBox(
          height: 250,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned.fill(child: _buildFlippingFaces()),
              if (swipeProgress != 0)
                Positioned.fill(
                  child: IgnorePointer(
                    child: _SwipeOverlay(progress: swipeProgress),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Hiệu ứng lật 3D: xoay quanh trục Y từ 0 đến π.
  Widget _buildFlippingFaces() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: _isFlipped ? math.pi : 0),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      builder: (context, angle, _) {
        final showBack = angle > math.pi / 2;
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001) // phối cảnh
            ..multiply(Matrix4.rotationY(angle)),
          child: showBack
              ? Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(math.pi), // tránh chữ bị ngược
                  child: _CardBack(word: widget.word),
                )
              : _CardFront(word: widget.word),
        );
      },
    );
  }
}

class _CardShell extends StatelessWidget {
  const _CardShell({required this.color, required this.child});

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            blurRadius: 16,
            offset: Offset(0, 6),
            color: Colors.black26,
          ),
        ],
      ),
      child: child,
    );
  }
}

class _CardFront extends StatelessWidget {
  const _CardFront({required this.word});

  final Word word;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _CardShell(
      color: theme.colorScheme.surfaceContainerLowest,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              word.type,
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: FittedBox(
                child: Text(
                  word.english,
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.touch_app_outlined,
                size: 18,
                color: theme.colorScheme.outline,
              ),
              const SizedBox(width: 6),
              Text(
                'Chạm để xem nghĩa',
                style: TextStyle(color: theme.colorScheme.outline),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CardBack extends StatelessWidget {
  const _CardBack({required this.word});

  final Word word;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onColor = theme.colorScheme.onPrimaryContainer;
    return _CardShell(
      color: theme.colorScheme.primaryContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${word.english}  (${word.type})',
            style: theme.textTheme.labelLarge?.copyWith(color: onColor),
          ),
          Expanded(
            child: Center(
              child: Text(
                word.meaning,
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: onColor,
                ),
              ),
            ),
          ),
          Text(
            word.example,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontStyle: FontStyle.italic,
              color: onColor,
            ),
          ),
        ],
      ),
    );
  }
}

/// Lớp phủ khi vuốt: xanh "ĐÃ THUỘC" (phải), đỏ "CHƯA THUỘC" (trái).
class _SwipeOverlay extends StatelessWidget {
  const _SwipeOverlay({required this.progress});

  /// Từ -1 (vuốt hết sang trái) đến 1 (vuốt hết sang phải).
  final double progress;

  @override
  Widget build(BuildContext context) {
    final known = progress > 0;
    final color = known ? Colors.green : Colors.red;
    final strength = progress.abs();

    return Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.22 * strength),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withValues(alpha: strength), width: 3),
      ),
      alignment: known ? Alignment.topLeft : Alignment.topRight,
      padding: const EdgeInsets.all(18),
      child: Opacity(
        opacity: strength,
        child: Text(
          known ? 'ĐÃ THUỘC' : 'CHƯA THUỘC',
          style: TextStyle(
            color: color.shade700,
            fontWeight: FontWeight.w900,
            fontSize: 20,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }
}
