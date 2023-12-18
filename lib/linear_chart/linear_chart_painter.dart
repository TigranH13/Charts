import 'package:charts/linear_chart/linear_chart_data.dart';
import 'package:flutter/material.dart';

class LinearChartPainter extends CustomPainter {
  final double pointRadius;
  final Animation<double> animation;
  final TextStyle textStyle;
  final int displayedValueSpace;
  final double spacing;
  final List<LinearChartData> data;
  final Color lineColor;
  double? minValue;

  LinearChartPainter({
    required this.displayedValueSpace,
    required this.textStyle,
    required this.data,
    required this.lineColor,
    required this.spacing,
    required this.pointRadius,
    required this.animation,
    this.minValue,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    //Paint settings for the line connecting data points
    final Paint linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    // Paint settings for the circular data points
    final Paint circlePaint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.fill;

    // Path to connect data points with a line
    final Path path = Path();

    // Calculate the maximum value in the data set
    final maxValue = data.reduce((a, b) => a.value > b.value ? a : b).value;

    // Calculate the minimum value in the data set
    final double dataMinValue =
        data.reduce((a, b) => a.value < b.value ? a : b).value;

    // If minValue is not provided, set it to dataMinValue
    minValue ??= dataMinValue;

    // Validate that minValue is less than or equal to dataMinValue
    if (minValue! > dataMinValue) {
      throw ArgumentError('Invalid minValue: $minValue');
    }

    //Calculate the width and height of the graph area
    final graphWidth = size.width - pointRadius - spacing;
    final graphHeight = size.height - pointRadius - spacing;

    // Draw the line connecting data points and paint data point circles
    for (var i = 0; i < data.length; i++) {
      double graphX = ((i * ((graphWidth) / (data.length - 1))));

      double graphY = ((graphHeight -
              ((data[i].value - minValue!) / (maxValue - minValue!)) *
                  graphHeight)) *
          animation.value;

      // Handle the first data point separately
      if (i == 0) {
        graphX += (pointRadius + spacing);
        path.moveTo(graphX, graphY);
        path.lineTo(graphX, graphY);
        canvas.drawCircle(Offset(graphX, graphY), 4, circlePaint);
      } else if (data[i].value == maxValue) {
        graphY += (pointRadius + spacing) * animation.value;
        path.lineTo(graphX, graphY);
        canvas.drawCircle(Offset(graphX, graphY), 4, circlePaint);
      } else {
        path.lineTo(graphX, graphY);
        canvas.drawCircle(Offset(graphX, graphY), 4, circlePaint);
      }

      // Paint value labels on the canvas
      paintValue(graphHeight, maxValue, canvas);

      // Paint title labels below the graph
      paintTitle(data[i].title, canvas, graphX, graphHeight);
    }

    // Draw the line connecting data points
    canvas.drawPath(path, linePaint);
  }

  void paintValue(double graphHeight, double maxValue, Canvas canvas) {
    // Generate a list of values based on displayedValueSpace
    List<int> valueList = List.generate(
        ((maxValue - minValue!) / displayedValueSpace).round() + 1,
        (index) => minValue!.round() + ((index) * displayedValueSpace));

    // Validate that the last value in the list does not exceed maxValue
    if (valueList.last > maxValue) {
      throw ArgumentError('Invalid valueList: $valueList');
    }
    // Paint value labels on the canvas
    for (var i = 0; i < valueList.length; i++) {
      TextPainter valuePainter = TextPainter(
        text: TextSpan(
          text: valueList[i].toString(),
          style: textStyle,
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      double valuePainterWidth = valuePainter.size.width;

      double valueY = (graphHeight -
          ((valueList[i] - minValue!) / (maxValue - minValue!)) * graphHeight);

      if (valueList[i] == maxValue) {
        valueY += pointRadius + spacing;
      }

      valuePainter.paint(
        canvas,
        Offset(0 + pointRadius, valueY - valuePainterWidth / 2),
      );
    }
  }

  void paintTitle(
      String title, Canvas canvas, double graphX, double graphHeight) {
    // Paint title labels below the graph
    TextPainter titlePainter = TextPainter(
      text: TextSpan(
        text: title,
        style: const TextStyle(fontSize: 12, color: Colors.black),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final double titlePainterheight = titlePainter.size.height;
    titlePainter.paint(
      canvas,
      Offset(graphX - titlePainterheight / 2,
          graphHeight + spacing - titlePainterheight),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
