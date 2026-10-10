import 'package:artvault/models/artwork.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Artwork.fromJson reads every field', () {
    final artwork = Artwork.fromJson({
      'id': 7,
      'title': ' Water Lilies ',
      'artist_display': 'Claude Monet',
      'date_display': '1906',
      'medium_display': 'Oil on canvas',
      'place_of_origin': 'France',
      'is_public_domain': true,
    });

    expect(artwork.id, 7);
    expect(artwork.title, 'Water Lilies');
    expect(artwork.origin, 'France');
    expect(artwork.isPublicDomain, isTrue);
  });

  test('Artwork.fromJson uses readable fallbacks for missing data', () {
    final artwork = Artwork.fromJson({'id': 1, 'title': '   '});

    expect(artwork.title, 'Untitled artwork');
    expect(artwork.artist, 'Artist unknown');
    expect(artwork.origin, 'Origin not listed');
    expect(artwork.isPublicDomain, isFalse);
  });
}
