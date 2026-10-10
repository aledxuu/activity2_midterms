import 'dart:convert';

import 'package:artvault/services/artwork_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

http.Response _json(Object body, [int status = 200]) => http.Response(
      jsonEncode(body),
      status,
      headers: {'content-type': 'application/json'},
    );

const _oneArtwork = {
  'id': 5,
  'title': 'Sample',
  'artist_display': 'Someone',
  'date_display': '1800',
  'medium_display': 'Ink',
  'place_of_origin': 'Japan',
  'is_public_domain': true,
};

void main() {
  test('fetchArtworks turns JSON into Artwork objects', () async {
    final service = ArtworkService(
      client: MockClient((_) async => _json({'data': [_oneArtwork]})),
    );

    final artworks = await service.fetchArtworks();

    expect(artworks, hasLength(1));
    expect(artworks.first.title, 'Sample');
  });

  test('a non-200 status becomes an ArtworkException', () async {
    final service = ArtworkService(
      client: MockClient((_) async => http.Response('nope', 503)),
    );

    expect(service.fetchArtworks(), throwsA(isA<ArtworkException>()));
  });

  test('unreadable JSON becomes an ArtworkException', () async {
    final service = ArtworkService(
      client: MockClient((_) async => http.Response('not json', 200)),
    );

    expect(service.fetchArtworks(), throwsA(isA<ArtworkException>()));
  });

  test('a network failure becomes an ArtworkException', () async {
    final service = ArtworkService(
      client: MockClient((_) async => throw http.ClientException('offline')),
    );

    expect(service.fetchArtworks(), throwsA(isA<ArtworkException>()));
  });

  test('the live feed emits an artwork first', () async {
    final service = ArtworkService(
      client: MockClient((_) async => _json({'data': [_oneArtwork]})),
    );

    final first = await service.watchLiveFeed().first;

    expect(first.artwork?.title, 'Sample');
    expect(first.updates, 1);
    expect(first.error, isNull);
  });

  test('the live feed reports an error but keeps running', () async {
    final service = ArtworkService(
      client: MockClient((_) async => http.Response('down', 500)),
    );

    final first = await service.watchLiveFeed().first;

    expect(first.artwork, isNull);
    expect(first.error, isNotNull);
  });
}
