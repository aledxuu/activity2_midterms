import 'package:flutter/material.dart';

import '../../models/artwork.dart';
import '../molecules/detail_line.dart';

/// Opens a dialog with the full record of one artwork.
void showArtworkDetails(BuildContext context, Artwork artwork) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(artwork.title),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailLine(label: 'Artist', value: artwork.artist),
            DetailLine(label: 'Date', value: artwork.date),
            DetailLine(label: 'Medium', value: artwork.medium),
            DetailLine(label: 'Place of origin', value: artwork.origin),
            DetailLine(
              label: 'Access',
              value: artwork.isPublicDomain ? 'Public domain' : 'Museum collection',
            ),
            DetailLine(label: 'Catalogue number', value: '${artwork.id}'),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    ),
  );
}
