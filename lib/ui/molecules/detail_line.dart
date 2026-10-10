import 'package:flutter/material.dart';

import '../atoms/sub_text.dart';

/// "Label: value" line used in the details dialog.
class DetailLine extends StatelessWidget {
  const DetailLine({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SubText(label),
          Text(value),
        ],
      ),
    );
  }
}
