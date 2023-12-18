import 'package:charts/linear_chart/linear_chart.dart';
import 'package:charts/linear_chart/linear_chart_data.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const LineChartExample());
}

class LineChartExample extends StatefulWidget {
  const LineChartExample({Key? key}) : super(key: key);

  @override
  State<LineChartExample> createState() => _LineChartExampleState();
}

class _LineChartExampleState extends State<LineChartExample> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: ElevatedButton(
            onPressed: () => setState(() {}), child: const Text('tap')),
        appBar: AppBar(
          title: const Text('Interactive Line Chart'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              color: Colors.white,
              width: 400,
              height: 500,
              child: LinearChart(
                spacing: 20,
                data: [
                  LinearChartData(value: 54, title: 'asas'),
                  LinearChartData(value: 30, title: 'asas'),
                  LinearChartData(value: 20, title: 'asas'),
                  LinearChartData(value: 60),
                  LinearChartData(value: 70),
                  LinearChartData(value: 10),
                  LinearChartData(value: 20),
                ],
                lineColor: Colors.red,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
