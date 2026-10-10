import 'package:flutter/material.dart';

/// The bottom bar that switches between the two pages.
class BottomTabs extends StatelessWidget {
  const BottomTabs({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onSelected,
      destinations: const [
        NavigationDestination(icon: Icon(Icons.grid_view), label: 'Collection'),
        NavigationDestination(icon: Icon(Icons.sync), label: 'Live'),
      ],
    );
  }
}
