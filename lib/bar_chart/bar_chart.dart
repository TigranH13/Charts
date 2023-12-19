import 'dart:developer';

import 'package:charts/bar_chart/bar_chart_data.dart';
import 'package:charts/bar_chart/bar_chart_painter.dart';
import 'package:flutter/material.dart';

/// A custom bar chart widget.
class BarChart extends StatefulWidget {
  // Width and height of the chart.
  final double? width;
  final double? height;

  // InteractiveViewer properties.
  final Clip clipBehavior;
  final double minScale;
  final double maxScale;

  // Bar chart customization options.
  final Radius borderRadius;
  final Color defaultBarColor;
  final Duration spawnAnimationDuration;
  final Curve spawnAnimationCurve;
  final List<BarChartData> data;
  final double spaceBetweenBars;
  final bool displayValue;
  final TextStyle textStyle;

  /// Creates a custom bar chart.
  /// The key used to force the rebuild of the BarChart when data changes.
  const BarChart({
    required this.data,
    this.maxScale = 2.5,
    this.width,
    this.height,
    this.clipBehavior = Clip.hardEdge,
    this.minScale = 0.8,
    this.spawnAnimationCurve = Curves.ease,
    this.spaceBetweenBars = 3,
    this.borderRadius = Radius.zero,
    this.defaultBarColor = Colors.purple,
    this.spawnAnimationDuration = const Duration(milliseconds: 400),
    this.displayValue = false,
    this.textStyle = const TextStyle(
      color: Colors.black,
      fontSize: 12.0,
    ),
    super.key,
  });

  @override
  State<BarChart> createState() => _BarChartState();
}

/// The state of the `BarChart` widget.
class _BarChartState extends State<BarChart> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    log('bar init');
    super.initState();
    // Initialize animation controller and animation.
    _controller = AnimationController(
      vsync: this,
      duration: widget.spawnAnimationDuration,
      reverseDuration: widget.spawnAnimationDuration,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.spawnAnimationCurve,
    );

    _controller.forward();
  }

  @override
  void didChangeDependencies() {
    log('bar dp');
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant BarChart oldWidget) {
    log('bar update');

    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    // Return a custom paint widget for drawing the bar chart.
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: InteractiveViewer(
        clipBehavior: widget.clipBehavior,
        minScale: widget.minScale,
        maxScale: widget.maxScale,
        child: CustomPaint(
          painter: BarChartPainter(
            textStyle: widget.textStyle,
            displayValue: widget.displayValue,
            defaultBarBorderRadius: widget.borderRadius,
            data: widget.data,
            spaceBetweenBars: widget.spaceBetweenBars,
            animation: _animation,
            defaultBarColor: widget.defaultBarColor,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of the animation controller.
    _controller.dispose();
    super.dispose();
  }
}
