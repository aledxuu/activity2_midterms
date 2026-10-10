import 'package:flutter/material.dart';

import '../atoms/sub_text.dart';

/// A small card for an error that happens AFTER data is already on screen.
class WarningNote extends StatelessWidget {
  const WarningNote({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange.shade50,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.orange.shade800),
            const SizedBox(width: 10),
            Expanded(child: SubText(message)),
          ],
        ),
      ),
    );
  }
}
