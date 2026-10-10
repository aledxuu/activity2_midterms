import 'package:flutter/material.dart';

/// The round loading spinner.
class BusySpinner extends StatelessWidget {
  const BusySpinner({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 36,
      height: 36,
      child: CircularProgressIndicator(),
    );
  }
}
