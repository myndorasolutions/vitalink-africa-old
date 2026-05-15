import 'package:flutter/material.dart';

class MyndoraFooter extends StatelessWidget {
  const MyndoraFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Powered by Myndora Solutions',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 8),
          Image.asset(
            'assets/images/myndora_logo.png',
            height: 36,
            errorBuilder: (_, _, _) =>
                Icon(Icons.business, size: 36, color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }
}
