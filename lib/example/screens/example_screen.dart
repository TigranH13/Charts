import 'package:charts/bar_chart/bar_chart.dart';
import 'package:charts/bar_chart/bar_chart_data.dart';
import 'package:charts/linear_chart/linear_chart.dart';
import 'package:charts/linear_chart/linear_chart_data.dart';
import 'package:charts/pie_chart/pie_chart.dart';
import 'package:charts/pie_chart/pie_chart_data.dart';
import 'package:flutter/material.dart';

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({super.key});

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  final List<LinearChartData> linearData = [
    LinearChartData(value: 4, title: 'Title 1'),
    LinearChartData(value: 5, title: 'Ttile 2'),
    LinearChartData(value: 1, title: 'Title 3'),
  ];

  final List<PieChartData> pieData = [
    PieChartData(value: 4, color: Colors.grey),
    PieChartData(
      value: 5,
      color: Colors.amber,
    ),
    PieChartData(
      value: 6,
      color: Colors.red,
    ),
  ];

  List<BarChartData> barData = [
    BarChartData(
      value: 50,
    ),
    BarChartData(
      value: 60,
      color: Colors.red,
      title: 'Title',
      borderRadius: const Radius.circular(19),
    ),
    BarChartData(value: 40, color: Colors.green, title: 'Title2'),
  ];
  double space = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
        onPressed: () {
          setState(() {});
        },
        child: const Text('reBuild'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 300,
            height: 200,
            child: LinearChart(
              minValue: 0,
              textStyle: const TextStyle(color: Colors.red),
              lineColor: Colors.red,
              key: UniqueKey(),
              spacing: 20,
              data: linearData,
            ),
          ),
          SizedBox(
            width: 300,
            height: 200,
            child: BarChart(
              textStyle: const TextStyle(color: Colors.blueAccent),
              displayValue: true,
              key: UniqueKey(),
              spaceBetweenBars: 10,
              data: barData,
            ),
          ),
          SizedBox(
            width: 300,
            height: 300,
            child: PieChart(
              key: UniqueKey(),
              data: pieData,
            ),
          ),
        ],
      ),
    );
  }
}
