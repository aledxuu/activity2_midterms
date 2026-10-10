import 'package:flutter/material.dart';

import '../atoms/page_title.dart';
import '../atoms/sub_text.dart';

/// Layout shared by both pages: title, short description, then the content.
/// A template only arranges widgets. It has no data and no API calls.
class ScreenLayout extends StatelessWidget {
  const ScreenLayout({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageTitle(title),
          const SizedBox(height: 4),
          SubText(subtitle),
          const SizedBox(height: 12),
          Expanded(child: child),
        ],
      ),
    );
  }
}
