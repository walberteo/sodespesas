import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class ExpenseMonth {
  final String month;
  final double value;
  final charts.Color color;

  ExpenseMonth(this.month, this.value, Color color)
      : this.color = new charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}
