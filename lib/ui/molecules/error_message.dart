import 'package:flutter/material.dart';

import '../atoms/heading_text.dart';
import '../atoms/retry_button.dart';
import '../atoms/sub_text.dart';

/// Error icon, explanation and a Try again button.
class ErrorMessage extends StatelessWidget {
  const ErrorMessage({super.key, required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_off, size: 56, color: Colors.grey.shade600),
            const SizedBox(height: 12),
            const HeadingText('Could not load artworks'),
            const SizedBox(height: 6),
            SubText(message, center: true),
            const SizedBox(height: 16),
            RetryButton(onPressed: onRetry),
          ],
        ),
      ),
    );
  }
}
