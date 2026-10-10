import 'package:flutter/material.dart';

import '../../services/artwork_service.dart';
import '../organisms/bottom_tabs.dart';
import '../templates/shell_layout.dart';
import 'collection_page.dart';
import 'live_page.dart';

/// Owns the single [ArtworkService] and the selected tab.
class HomePage extends StatefulWidget {
  const HomePage({super.key, this.service});

  /// Optional. Tests pass a fake service; the real app leaves it null.
  final ArtworkService? service;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ArtworkService _service;
  late final bool _ownsService;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _ownsService = widget.service == null;
    _service = widget.service ?? ArtworkService();
  }

  @override
  void dispose() {
    if (_ownsService) _service.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShellLayout(
      // IndexedStack keeps both pages alive, so switching tabs does not
      // reload the Collection or restart the Live feed.
      body: IndexedStack(
        index: _index,
        children: [
          CollectionPage(service: _service),
          LivePage(service: _service),
        ],
      ),
      bottomBar: BottomTabs(
        selectedIndex: _index,
        onSelected: (i) => setState(() => _index = i),
      ),
    );
  }
}
