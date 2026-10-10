import 'package:flutter/material.dart';

import '../../models/artwork.dart';
import '../atoms/sub_text.dart';
import '../molecules/tag_row.dart';
import '../molecules/title_block.dart';

/// One artwork shown as a card. Tap it to open the details.
/// [showMedium] adds the medium line (used on the live page).
class ArtworkCard extends StatelessWidget {
  const ArtworkCard({
    super.key,
    required this.artwork,
    required this.onTap,
    this.showMedium = false,
  });

  final Artwork artwork;
  final VoidCallback onTap;
  final bool showMedium;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleBlock(title: artwork.title, subtitle: artwork.artist),
              const SizedBox(height: 12),
              TagRow(tags: [artwork.date, artwork.origin]),
              if (showMedium) ...[
                const SizedBox(height: 12),
                SubText(artwork.medium, maxLines: 2),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
