import 'dart:ui';
import 'package:charts/bar_chart/bar_chart_data.dart';
import 'package:flutter/material.dart';

/// The custom painter for the bar chart.
class BarChartPainter extends CustomPainter {
  final TextStyle textStyle;
  final bool displayValue;
  final Radius defaultBarBorderRadius;
  final Color defaultBarColor;
  final Animation<double> animation;
  final double spaceBetweenBars;
  final List<BarChartData> data;

  BarChartPainter({
    required this.defaultBarBorderRadius,
    required this.defaultBarColor,
    required this.animation,
    required this.spaceBetweenBars,
    required this.data,
    required this.displayValue,
    required this.textStyle,
  }) : super(repaint: animation);

  /// Paint a single bar on the canvas.
  void paintBar(Canvas canvas, Size size, int index, double animationValue) {
    final BarChartData barChartData = data[index];

    //handle negative value
    if (barChartData.value < 0) {
      throw ArgumentError(
          'Value for bar at index $index (${barChartData.title}) must be non-negative.');
    }

    //value painter
    TextPainter? valuePainter = displayValue
        ? TextPainter(
            text: TextSpan(
              text: barChartData.value.round().toString(),
              style: textStyle,
            ),
            textDirection: TextDirection.ltr,
          )
        : null;
    valuePainter?.layout();

    //title painter
    TextPainter titlePainter = TextPainter(
      text: TextSpan(text: barChartData.title, style: textStyle),
      textDirection: TextDirection.ltr,
    )..layout();

    //Filled Bar painter
    Paint barPainter = Paint()..color = barChartData.color ?? defaultBarColor;

    //calculation value size
    final double valueHeight = displayValue ? valuePainter!.size.height : 0;
    final double valueWidth = displayValue ? valuePainter!.size.height : 0;

    //calculation filled bar sizes
    double barWidth =
        ((size.width - spaceBetweenBars * (data.length - 1)) / data.length);
    double barHeight = barChartData.value *
        ((size.height - titlePainter.height - valueHeight) /
            data.reduce((a, b) => a.value > b.value ? a : b).value);
    double animatedBarHeight = lerpDouble(0, barHeight, animationValue) ?? 0.0;

    //calculation filled bar cordinates
    double barX = index * (barWidth + spaceBetweenBars);
    double barY = size.height - titlePainter.height - animatedBarHeight;

    //calculation value cordinates
    double valueX = barX + (barWidth - valueWidth) / 2;
    final valueY =
        size.height - titlePainter.height - animatedBarHeight - valueHeight;

    //calculation title cordinates
    double titleX = barX + (barWidth - titlePainter.width) / 2;
    double titleY = size.height - titlePainter.height;

    //draw  value on the canvas.
    if (displayValue) {
      valuePainter!.paint(canvas, Offset(valueX, valueY));
    }

    //draw filled bar on the canvas.
    RRect roundedRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(barX, barY, barWidth, animatedBarHeight),
      barChartData.borderRadius ?? defaultBarBorderRadius,
    );
    canvas.drawRRect(roundedRect, barPainter);

    //draw  title on the canvas.
    titlePainter.paint(canvas, Offset(titleX, titleY));
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Draw each bar on the canvas.
    for (int i = 0; i < data.length; i++) {
      paintBar(canvas, size, i, animation.value);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // Indicate whether the painter should repaint.
    return false;
  }
}
