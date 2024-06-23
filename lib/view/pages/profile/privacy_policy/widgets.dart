// Custom widget for bullet points
import 'package:flutter/material.dart';

class BulletPoint extends StatelessWidget {
  final String text;

  const BulletPoint({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(fontSize: 20.0, height: 1.55),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16.0, height: 1.55),
            ),
          ),
        ],
      ),
    );
  }
}