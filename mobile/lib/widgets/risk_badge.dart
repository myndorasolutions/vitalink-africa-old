import 'package:flutter/material.dart';

import '../core/theme.dart';

class RiskBadge extends StatelessWidget {
  const RiskBadge({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final color = VitaLinkTheme.riskColor(status);
    final label = status.toUpperCase();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
