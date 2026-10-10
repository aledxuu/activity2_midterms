import 'package:flutter/material.dart';

import '../../models/artwork.dart';
import 'artwork_card.dart';

/// A scrolling list of artwork cards.
class ArtworkListView extends StatelessWidget {
  const ArtworkListView({
    super.key,
    required this.artworks,
    required this.onArtworkTap,
  });

  final List<Artwork> artworks;
  final void Function(Artwork artwork) onArtworkTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: artworks.length,
      itemBuilder: (context, index) {
        final artwork = artworks[index];
        return ArtworkCard(
          artwork: artwork,
          onTap: () => onArtworkTap(artwork),
        );
      },
    );
  }
}
