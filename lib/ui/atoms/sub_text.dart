import 'package:flutter/material.dart';

/// Quiet grey text for extra information.
class SubText extends StatelessWidget {
  const SubText(this.text, {super.key, this.maxLines, this.center = false});

  final String text;
  final int? maxLines;
  final bool center;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: maxLines == null ? null : TextOverflow.ellipsis,
      textAlign: center ? TextAlign.center : null,
      style: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(color: Colors.grey.shade700),
    );
  }
}
