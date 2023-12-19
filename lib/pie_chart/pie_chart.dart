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
  PieChartState createState() {
    print('cr');
    return PieChartState();
  }
}

class PieChartState extends State<PieChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    print('init');
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
  void didUpdateWidget(covariant PieChart oldWidget) {
    print(oldWidget.data.length);
    print(widget.data.length);
    if (oldWidget.data.hashCode != widget.data.hashCode) {
      print('haa');
      _controller.reset();
      _controller.forward();
    }
    print('update widget');
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    print('update dep');
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return SizedBox.expand(
      child: CustomPaint(
        painter: PieChartPainter(
          data: widget.data,
          animation: _controller,
          textStyle: widget.textStyle,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
