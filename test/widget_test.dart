import 'dart:convert';

import 'package:artvault/main.dart';
import 'package:artvault/services/artwork_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

http.Response _okResponse() => http.Response(
      jsonEncode({
        'data': [
          {
            'id': 101,
            'title': 'Museum Record',
            'artist_display': 'A. Artist',
            'date_display': '1890',
            'medium_display': 'Print',
            'place_of_origin': 'Italy',
            'is_public_domain': true,
          },
        ],
      }),
      200,
      headers: {'content-type': 'application/json'},
    );

void main() {
  testWidgets('shows the Collection page with a card from the API', (tester) async {
    final service = ArtworkService(client: MockClient((_) async => _okResponse()));

    await tester.pumpWidget(ArtVaultApp(service: service));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    expect(find.text('ArtVault Collection'), findsOneWidget);
    expect(find.text('Museum Record'), findsOneWidget);
    expect(find.text('Collection'), findsOneWidget); // bottom tab
    expect(find.text('Live'), findsOneWidget); // bottom tab

    // Remove the app so the live feed's timer is stopped.
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('shows an error and Try again when the API fails', (tester) async {
    final service = ArtworkService(
      client: MockClient((_) async => http.Response('Server error', 500)),
    );

    await tester.pumpWidget(ArtVaultApp(service: service));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    expect(find.text('Could not load artworks'), findsOneWidget);
    expect(find.text('Try again'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
  });
}
