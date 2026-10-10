import 'package:flutter/material.dart';

import '../atoms/tag_label.dart';

/// Several [TagLabel]s that wrap onto the next line when needed.
class TagRow extends StatelessWidget {
  const TagRow({super.key, required this.tags});

  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [for (final tag in tags) TagLabel(tag)],
    );
  }
}
