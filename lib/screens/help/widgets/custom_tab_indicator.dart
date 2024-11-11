import 'package:flutter/material.dart';

class CustomTabIndicator extends Decoration {
  final Color color;
  final double indicatorWidth; // Fixed width for the indicator
  final double indicatorHeight; // Fixed height for the indicator

  CustomTabIndicator({
    required this.color,
    this.indicatorWidth = 60.0, // Set a fixed width for the indicator
    this.indicatorHeight = 5.0, // Set a fixed height for the indicator
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomPainter(
        color: color,
        indicatorWidth: indicatorWidth,
        indicatorHeight: indicatorHeight);
  }
}

class _CustomPainter extends BoxPainter {
  final Color color;
  final double indicatorWidth;
  final double indicatorHeight;

  _CustomPainter({
    required this.color,
    required this.indicatorWidth,
    required this.indicatorHeight,
  });

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Calculate the center position for the indicator
    final double dx =
        offset.dx + (configuration.size!.width - indicatorWidth) / 2;
    final double dy =
        configuration.size!.height - indicatorHeight; // Position at the bottom

    final Rect rect = Rect.fromLTWH(dx, dy, indicatorWidth, indicatorHeight);
    canvas.drawRect(rect, paint);
  }
}
