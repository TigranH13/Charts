import 'package:charts/linear_chart/linear_chart_data.dart';
import 'package:charts/linear_chart/linear_chart_painter.dart';
import 'package:flutter/material.dart';

class LinearChart extends StatefulWidget {
  final double ponitRadius;

  final TextStyle textStyle;
  final int displayedValueSpace;

  final double spacing;
  final List<LinearChartData> data;
  final Color lineColor;
  final double? minValue;

  const LinearChart({
    this.minValue,
    this.displayedValueSpace = 10,
    required this.data,
    this.lineColor = Colors.grey,
    super.key,
    this.ponitRadius = 3,
    this.textStyle = const TextStyle(fontSize: 8, color: Colors.black),
    this.spacing = 8,
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
      duration: const Duration(
          milliseconds: 1000), // Set your desired animation duration
    );

    final animation =
        Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animation = CurvedAnimation(curve: Curves.easeIn, parent: animation);

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
        pointRadius: widget.ponitRadius,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
