import 'package:flutter/material.dart';

import '../../models/live_feed_state.dart';
import '../../services/artwork_service.dart';
import '../molecules/error_message.dart';
import '../molecules/loading_message.dart';
import '../molecules/warning_note.dart';
import '../organisms/artwork_card.dart';
import '../organisms/artwork_details_dialog.dart';
import '../organisms/feed_status_card.dart';
import '../templates/screen_layout.dart';

/// Page 2 - StreamBuilder.
/// The stream starts ONCE in initState. It brings a new artwork every
/// 5 seconds. If a request fails, the last artwork stays on screen with a
/// warning, and the stream keeps running until a request works again.
class LivePage extends StatefulWidget {
  const LivePage({super.key, required this.service});

  final ArtworkService service;

  @override
  State<LivePage> createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  late Stream<LiveFeedState> _stream;

  @override
  void initState() {
    super.initState();
    _stream = widget.service.watchLiveFeed();
  }

  void _restart() {
    setState(() => _stream = widget.service.watchLiveFeed());
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      title: 'Live Gallery',
      subtitle: 'A new artwork arrives every 5 seconds.',
      child: StreamBuilder<LiveFeedState>(
        stream: _stream,
        builder: (context, snapshot) {
          // 1. Loading (nothing received yet)
          if (!snapshot.hasData && !snapshot.hasError) {
            return const LoadingMessage(message: 'Waiting for the first artwork...');
          }

          // 2. Stream-level error (should not normally happen)
          if (snapshot.hasError) {
            return ErrorMessage(
              message: ArtworkException.messageFor(snapshot.error),
              onRetry: _restart,
            );
          }

          final feed = snapshot.data!;
          final artwork = feed.artwork;

          // 3. The very first request failed
          if (artwork == null) {
            return ErrorMessage(
              message: feed.error ?? 'No artwork yet.',
              onRetry: _restart,
            );
          }

          // 4. Data (plus a warning if the newest request failed)
          return ListView(
            children: [
              if (feed.error != null)
                WarningNote(message: '${feed.error} Trying again automatically.'),
              ArtworkCard(
                artwork: artwork,
                showMedium: true,
                onTap: () => showArtworkDetails(context, artwork),
              ),
              FeedStatusCard(
                updates: feed.updates,
                updatedAt: feed.updatedAt,
                onRestart: _restart,
              ),
            ],
          );
        },
      ),
    );
  }
}
