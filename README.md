# ArtVault — A Simple Museum Catalogue

ArtVault is a Flutter project for CC 105: Applications Development and Emerging Technologies. It uses the Art Institute of Chicago's public REST API and shows real public-domain artwork records as simple cards. It shows text data only (no remote images).

**API:** https://api.artic.edu/docs/ (free, JSON, no API key, no credit card; not JSONPlaceholder or Open-Meteo)

## 1. Why this API

_Write 3–4 sentences in your own words: why you chose museum data and what you learned._

| Item | Answer |
| --- | --- |
| API | Art Institute of Chicago, `https://api.artic.edu/api/v1/artworks/search` |
| Cost / auth | Free, JSON, no key, no credit card |
| Page 1 (Future) | One page of 12 public-domain artworks, loaded once |
| Page 2 (Stream) | One new artwork every 5 seconds (each tick asks for the next page with `limit=1`) |
| Rate limit | _Check the API docs and write the current limit here. One request every 5 s is gentle._ |

## 2. Pages and states

**Collection page (`FutureBuilder`)**
- The Future is created once in `initState`, never in `build`.
- Loading spinner, error message + **Try again** button, empty message, and the artwork cards.
- Tap a card to see all details.

**Live page (`StreamBuilder`)**
- The stream is created once in `initState`. A new artwork arrives every 5 seconds.
- Loading state before the first artwork, and an error state with Try again if the first request fails.
- If a later request fails, the last artwork stays visible with a warning card. The stream keeps running and recovers by itself.
- A status card shows how many updates arrived and when. **Restart** starts a new stream.

## 3. Request safety

- Every request goes through one method that applies a 12-second timeout and checks that the status code is 200.
- Network errors, timeouts, bad status codes and unreadable JSON all become one readable `ArtworkException`.
- `Artwork.fromJson` turns JSON into a typed object, with fallbacks for missing fields.

## 4. Project structure (Atomic Design)

```text
lib/
  main.dart
  core/app_theme.dart
  models/
    artwork.dart                  # Artwork.fromJson
    live_feed_state.dart          # what the stream sends
  services/
    artwork_service.dart          # Future + Stream + timeout + status check
    artwork_exception.dart
  ui/
    atoms/                        # PageTitle, HeadingText, SubText, TagLabel,
                                  #   RetryButton, BusySpinner
    molecules/                    # TitleBlock, TagRow, LoadingMessage, ErrorMessage,
                                  #   EmptyMessage, WarningNote, DetailLine
    organisms/                    # ArtworkCard, ArtworkListView, ArtworkDetailsDialog,
                                  #   FeedStatusCard, BottomTabs
    templates/                    # ScreenLayout, ShellLayout (layout only)
    pages/                        # CollectionPage, LivePage, HomePage
test/
  artwork_test.dart
  artwork_service_test.dart
  widget_test.dart
```

Only the pages hold the `FutureBuilder` / `StreamBuilder` and use the service. Atoms, molecules, organisms and templates receive plain values and callbacks.

## 5. Run it

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

The `android/` folder is included (application id `com.example.artvault`). The INTERNET permission is already in `android/app/src/main/AndroidManifest.xml`.

## 6. Airplane-mode test

1. Run the app with internet and wait for both pages to show artworks.
2. Turn airplane mode on. Collection: tap **Try again** to see the error. Live: the last artwork stays with a warning.
3. Turn airplane mode off. Live recovers by itself on the next tick; Collection recovers with **Try again**.

## 7. Checklist (tick only what you really did)

- [ ] `flutter analyze` and `flutter test` pass on my computer
- [ ] Airplane-mode test done on a device or emulator
- [ ] README placeholders filled in (why this API, rate limit)
- [ ] Public GitHub repo, link submitted on Google Classroom

## Data credit

Metadata: Art Institute of Chicago API (https://api.artic.edu/docs/, https://www.artic.edu/terms).
