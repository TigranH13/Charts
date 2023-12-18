import 'package:flutter/material.dart';

class BarChartData {
  final double value;
  final Color? color;
  final String title;
  final Radius? borderRadius;

  BarChartData({
    required this.value,
    this.title = '',
    this.color,
    this.borderRadius,
  });
}
