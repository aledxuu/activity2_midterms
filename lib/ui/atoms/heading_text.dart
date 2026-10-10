import 'package:flutter/material.dart';

/// Bold text for a card title.
class HeadingText extends StatelessWidget {
  const HeadingText(this.text, {super.key, this.maxLines = 2});

  final String text;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(fontWeight: FontWeight.w700),
    );
  }
}
