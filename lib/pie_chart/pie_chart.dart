import 'package:charts/pie_chart/pie_chart_data.dart';
import 'package:charts/pie_chart/pie_chart_painter.dart';
import 'package:flutter/material.dart';

class PieChart extends StatefulWidget {
  final TextStyle textStyle;
  final List<PieChartData> data;
  final Duration animationDuratin;
  final Curve animationCurve;

  const PieChart({
    this.animationDuratin = const Duration(milliseconds: 1000),
    this.animationCurve = Curves.easeIn,
    this.textStyle = const TextStyle(color: Colors.white, fontSize: 15),
    required this.data,
    super.key,
  });

  @override
  PieChartState createState() => PieChartState();
}

class PieChartState extends State<PieChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuratin,
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _animation =
        CurvedAnimation(parent: _animation, curve: widget.animationCurve);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: PieChartPainter(
        data: widget.data,
        animation: _controller,
        textStyle: widget.textStyle,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
