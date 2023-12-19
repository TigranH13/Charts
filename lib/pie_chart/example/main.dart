import 'package:charts/pie_chart/pie_chart.dart';
import 'package:charts/pie_chart/pie_chart_data.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Pie Chart'),
        ),
        body: Container(
          width: 300,
          height: 300,
          color: Colors.grey,
          child: PieChart(
            data: [
              PieChartData(
                value: 600000000000.0,
                color: Colors.amber,
              ),
              PieChartData(
                value: 600000000000.0,
                color: Colors.amber,
              ),
              PieChartData(
                value: 1000000000000.0,
                color: Colors.blue,
              ),
              PieChartData(
                value: 211110.0,
                color: Colors.green,
              ),
              PieChartData(
                value: 411110.0,
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
