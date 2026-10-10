import 'package:flutter/material.dart';

import '../atoms/sub_text.dart';

/// Shown when the API answered but there is nothing to display.
class EmptyMessage extends StatelessWidget {
  const EmptyMessage({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.image_not_supported_outlined,
                size: 56, color: Colors.grey.shade600),
            const SizedBox(height: 12),
            SubText(message, center: true),
          ],
        ),
      ),
    );
  }
}
