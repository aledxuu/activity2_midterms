import 'package:flutter/material.dart';

import 'core/app_theme.dart';
import 'services/artwork_service.dart';
import 'ui/pages/home_page.dart';

void main() => runApp(const ArtVaultApp());

class ArtVaultApp extends StatelessWidget {
  const ArtVaultApp({super.key, this.service});

  /// Optional. Tests pass a fake service; the real app leaves it null.
  final ArtworkService? service;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ArtVault',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: HomePage(service: service),
    );
  }
}
