import 'package:charts/bar_chart/bar_chart.dart';
import 'package:charts/bar_chart/bar_chart_data.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BarChartApp());
}

class BarChartApp extends StatelessWidget {
  const BarChartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: BarChartScreen());
  }
}

class BarChartScreen extends StatefulWidget {
  const BarChartScreen({super.key});

  @override
  State<BarChartScreen> createState() => _BarChartScreenState();
}

class _BarChartScreenState extends State<BarChartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
          onPressed: () {
            setState(() {
         
            });
          },
          child: const Text('pyy')),
      body: Center(
        child: BarChart(
          textStyle: const TextStyle(fontSize: 20, color: Colors.amber),
          displayValue: true,
          key: UniqueKey(),
          width: 400,
          height: 400,
          spaceBetweenBars: 10,
          data: [
            BarChartData(
              value: 100,
              title: 'ass',
            ),
            BarChartData(
              value: 100,
              title: 'asas',
              borderRadius: const Radius.circular(20),
            ),
          ],
        ),
      ),
    );
  }
}
