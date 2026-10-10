import 'package:flutter/material.dart';

import '../../models/artwork.dart';
import '../../services/artwork_service.dart';
import '../molecules/empty_message.dart';
import '../molecules/error_message.dart';
import '../molecules/loading_message.dart';
import '../organisms/artwork_details_dialog.dart';
import '../organisms/artwork_list_view.dart';
import '../templates/screen_layout.dart';

/// Page 1 - FutureBuilder.
/// The request starts ONCE in initState (never inside build).
/// It only repeats when the user taps "Try again".
class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key, required this.service});

  final ArtworkService service;

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  late Future<List<Artwork>> _future;

  @override
  void initState() {
    super.initState();
    _future = widget.service.fetchArtworks();
  }

  void _retry() {
    setState(() => _future = widget.service.fetchArtworks());
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      title: 'ArtVault Collection',
      subtitle: 'Public-domain artworks from the Art Institute of Chicago.',
      child: FutureBuilder<List<Artwork>>(
        future: _future,
        builder: (context, snapshot) {
          // 1. Loading
          if (snapshot.connectionState != ConnectionState.done) {
            return const LoadingMessage(message: 'Loading artworks...');
          }

          // 2. Error with Retry
          if (snapshot.hasError) {
            return ErrorMessage(
              message: ArtworkException.messageFor(snapshot.error),
              onRetry: _retry,
            );
          }

          // 3. Empty
          final artworks = snapshot.data ?? const <Artwork>[];
          if (artworks.isEmpty) {
            return const EmptyMessage(message: 'No artworks were found.');
          }

          // 4. Real data
          return ArtworkListView(
            artworks: artworks,
            onArtworkTap: (artwork) => showArtworkDetails(context, artwork),
          );
        },
      ),
    );
  }
}
