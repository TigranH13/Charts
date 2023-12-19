import 'dart:math';

import 'package:charts/pie_chart/pie_chart_data.dart';
import 'package:flutter/material.dart';

class PieChartPainter extends CustomPainter {
  final List<PieChartData> data;

  final TextStyle textStyle;
  final Animation<double> animation;

  const PieChartPainter({
    required this.data,
    required this.animation,
    required this.textStyle,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    double total = data.map((item) => item.value).reduce((a, b) => a + b);
    double startRadian = 0.0;

    for (var item in data) {
      final paint = Paint()
        ..color = item.color
        ..style = PaintingStyle.fill;

      double sweepRadian = (item.value / total) * 2 * pi * animation.value;

      canvas.drawArc(
        Rect.fromCircle(
          center: size.center(Offset.zero),
          radius: size.width / 2,
        ),
        startRadian,
        sweepRadian,
        true,
        paint,
      );

      startRadian += sweepRadian;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
