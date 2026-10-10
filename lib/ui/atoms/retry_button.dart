import 'package:flutter/material.dart';

/// The "Try again" button.
class RetryButton extends StatelessWidget {
  const RetryButton({super.key, required this.onPressed, this.label = 'Try again'});

  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.refresh),
      label: Text(label),
    );
  }
}
