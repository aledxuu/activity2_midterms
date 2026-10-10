import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/artwork.dart';
import '../models/live_feed_state.dart';
import 'artwork_exception.dart';

// Re-exported so other files only need to import this one.
export 'artwork_exception.dart';

/// Talks to the Art Institute of Chicago API (free, JSON, no key needed).
/// Docs: https://api.artic.edu/docs/
class ArtworkService {
  ArtworkService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  static const Duration timeout = Duration(seconds: 12);
  static const Duration liveInterval = Duration(seconds: 5);
  static const int _lastLivePage = 50;

  static const List<String> _fields = [
    'id',
    'title',
    'artist_display',
    'date_display',
    'medium_display',
    'place_of_origin',
    'is_public_domain',
  ];

  // ------------------------------------------------------------------
  // Screen 1 (Future): one page of public-domain artworks
  // ------------------------------------------------------------------
  Future<List<Artwork>> fetchArtworks({int page = 1, int limit = 12}) async {
    final uri = Uri.https('api.artic.edu', '/api/v1/artworks/search', {
      'query[term][is_public_domain]': 'true',
      'page': '$page',
      'limit': '$limit',
      'fields': _fields.join(','),
    });

    final json = await _getJson(uri);

    final data = json['data'];
    if (data is! List) {
      throw ArtworkException('The museum sent an unexpected answer.');
    }
    return data
        .whereType<Map<String, dynamic>>()
        .map(Artwork.fromJson)
        .toList();
  }

  // ------------------------------------------------------------------
  // Screen 2 (Stream): a new artwork every 5 seconds
  // ------------------------------------------------------------------
  /// Each tick asks for ONE artwork on the next page, so every update is
  /// a different real record. A failed request becomes an error message
  /// inside [LiveFeedState]; the timer keeps running, so the next
  /// successful request recovers by itself. Cancelling the listener
  /// (leaving the page) stops the timer.
  Stream<LiveFeedState> watchLiveFeed() {
    late final StreamController<LiveFeedState> controller;
    Timer? timer;
    var stopped = false;
    var busy = false;

    Artwork? latest;
    String? error;
    DateTime? updatedAt;
    var updates = 0;
    var page = 1;

    Future<void> tick() async {
      if (busy || stopped) return;
      busy = true;

      try {
        final batch = await fetchArtworks(page: page, limit: 1);

        if (batch.isNotEmpty) {
          latest = batch.first;
          updates++;
          updatedAt = DateTime.now();
          error = null;
          page = page >= _lastLivePage ? 1 : page + 1;
        } else if (page == 1) {
          throw ArtworkException('The museum returned no artworks.');
        } else {
          page = 1; // ran past the last page, start over
        }
      } on ArtworkException catch (e) {
        error = e.message;
      } catch (_) {
        error = 'Something went wrong. Please try again.';
      }

      busy = false;
      if (!stopped) {
        controller.add(LiveFeedState(
          artwork: latest,
          error: error,
          updates: updates,
          updatedAt: updatedAt,
        ));
      }
    }

    controller = StreamController<LiveFeedState>(
      onListen: () {
        tick();
        timer = Timer.periodic(liveInterval, (_) => tick());
      },
      onCancel: () {
        stopped = true;
        timer?.cancel();
      },
    );

    return controller.stream;
  }

  // ------------------------------------------------------------------
  // Shared request rules: timeout + status-code check + safe JSON parsing
  // ------------------------------------------------------------------
  Future<Map<String, dynamic>> _getJson(Uri uri) async {
    final http.Response response;

    try {
      response = await _client
          .get(uri, headers: const {'Accept': 'application/json'})
          .timeout(timeout);
    } on TimeoutException {
      throw ArtworkException('The museum took too long to answer.');
    } catch (_) {
      // Airplane mode, no Wi-Fi and DNS failures all end up here.
      throw ArtworkException('No internet connection.');
    }

    if (response.statusCode != 200) {
      throw ArtworkException(
        'The museum returned an error (HTTP ${response.statusCode}).',
      );
    }

    try {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) return decoded;
      throw const FormatException('Expected a JSON object');
    } on FormatException {
      throw ArtworkException('The museum sent unreadable data.');
    }
  }

  void close() => _client.close();
}
