import 'package:flutter/material.dart';

class MyndoraCareTheme {
  static ThemeData light() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0D6E6E)),
      useMaterial3: true,
    );
  }

  static Color riskColor(String status) {
    switch (status) {
      case 'red':
        return Colors.red.shade700;
      case 'yellow':
        return Colors.amber.shade800;
      default:
        return Colors.green.shade700;
    }
  }
}
