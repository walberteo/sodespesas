import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Expense {
  final String title;
  final String subtitle;
  final double value;
  final DateTime date;
  final IconData icon;
  final Color color;

  Expense(
      this.icon, this.title, this.subtitle, this.value, this.date, this.color);
}
