/// One artwork record from the Art Institute of Chicago API.
/// ArtVault shows the text data only (no remote images).
class Artwork {
  const Artwork({
    required this.id,
    required this.title,
    required this.artist,
    required this.date,
    required this.medium,
    required this.origin,
    required this.isPublicDomain,
  });

  final int id;
  final String title;
  final String artist;
  final String date;
  final String medium;
  final String origin;
  final bool isPublicDomain;

  /// Turns one JSON object from the API into a typed [Artwork].
  factory Artwork.fromJson(Map<String, dynamic> json) {
    return Artwork(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: _text(json['title'], 'Untitled artwork'),
      artist: _text(json['artist_display'], 'Artist unknown'),
      date: _text(json['date_display'], 'Date unknown'),
      medium: _text(json['medium_display'], 'Medium not listed'),
      origin: _text(json['place_of_origin'], 'Origin not listed'),
      isPublicDomain: json['is_public_domain'] == true,
    );
  }

  /// Missing or empty text becomes a readable fallback.
  static String _text(Object? value, String fallback) {
    if (value is String && value.trim().isNotEmpty) return value.trim();
    return fallback;
  }
}
