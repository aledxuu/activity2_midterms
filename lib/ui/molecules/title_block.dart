import 'package:flutter/material.dart';

import '../atoms/heading_text.dart';
import '../atoms/sub_text.dart';

/// A bold title with a quiet line under it (artwork title + artist).
class TitleBlock extends StatelessWidget {
  const TitleBlock({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeadingText(title),
        const SizedBox(height: 4),
        SubText(subtitle, maxLines: 2),
      ],
    );
  }
}
