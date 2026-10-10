import 'package:flutter/material.dart';

import '../atoms/busy_spinner.dart';
import '../atoms/sub_text.dart';

/// Spinner + a short message, shown while data is loading.
class LoadingMessage extends StatelessWidget {
  const LoadingMessage({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BusySpinner(),
          const SizedBox(height: 16),
          SubText(message, center: true),
        ],
      ),
    );
  }
}
