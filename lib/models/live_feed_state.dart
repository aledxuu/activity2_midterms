import 'artwork.dart';

/// What the live stream sends to the screen on every tick.
/// If the newest request failed, [error] is set but [artwork] still holds
/// the last good record, so the screen can keep showing it.
class LiveFeedState {
  const LiveFeedState({
    required this.updates,
    this.artwork,
    this.error,
    this.updatedAt,
  });

  final Artwork? artwork;
  final String? error;
  final int updates;
  final DateTime? updatedAt;
}
