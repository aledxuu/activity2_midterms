import 'package:flutter/material.dart';

import '../atoms/sub_text.dart';

/// A card that shows how many updates the live feed has received.
class FeedStatusCard extends StatelessWidget {
  const FeedStatusCard({
    super.key,
    required this.updates,
    required this.updatedAt,
    required this.onRestart,
  });

  final int updates;
  final DateTime? updatedAt;
  final VoidCallback onRestart;

  @override
  Widget build(BuildContext context) {
    final time = updatedAt == null
        ? 'Waiting for the first update'
        : 'Last updated ${TimeOfDay.fromDateTime(updatedAt!).format(context)}';

    return Card(
      child: ListTile(
        leading: const Icon(Icons.sync),
        title: Text('Updates received: $updates'),
        subtitle: SubText(time),
        trailing: TextButton(onPressed: onRestart, child: const Text('Restart')),
      ),
    );
  }
}
