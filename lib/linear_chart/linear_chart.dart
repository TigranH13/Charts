import 'package:charts/linear_chart/linear_chart_data.dart';
import 'package:charts/linear_chart/linear_chart_painter.dart';
import 'package:flutter/material.dart';

class LinearChart extends StatefulWidget {
  final Duration animationDuration;
  final double pointRadius;
  final TextStyle textStyle;
  final int displayedValueSpace;
  final double spacing;
  final List<LinearChartData> data;
  final Color lineColor;
  final double? minValue;
  final Curve animationCurve;

  const LinearChart({
    this.animationCurve = Curves.easeIn,
    this.animationDuration = const Duration(milliseconds: 1000),
    this.minValue,
    this.displayedValueSpace = 1,
    required this.data,
    this.lineColor = Colors.grey,
    this.pointRadius = 3,
    this.textStyle = const TextStyle(fontSize: 8, color: Colors.black),
    this.spacing = 8,
    super.key,
  });

  @override
  State<LinearChart> createState() => _LinearChartState();
}

class _LinearChartState extends State<LinearChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration, // Set your desired animation duration
    );

    final animation =
        Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animation =
        CurvedAnimation(curve: widget.animationCurve, parent: animation);

    _animationController.forward(); // Start the animation
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LinearChartPainter(
        displayedValueSpace: widget.displayedValueSpace,
        textStyle: widget.textStyle,
        animation: _animation,
        data: widget.data,
        lineColor: widget.lineColor,
        minValue: widget.minValue,
        spacing: widget.spacing,
        pointRadius: widget.pointRadius,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
