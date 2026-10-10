import 'package:flutter/material.dart';

/// The frame of the whole app: a safe-area body and a bottom bar.
class ShellLayout extends StatelessWidget {
  const ShellLayout({super.key, required this.body, required this.bottomBar});

  final Widget body;
  final Widget bottomBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: body),
      bottomNavigationBar: bottomBar,
    );
  }
}
