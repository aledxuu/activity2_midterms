# API Proposal: ArtVault

**API:** Art Institute of Chicago API — https://api.artic.edu/docs/

## Why it fits
- Public REST API that returns JSON.
- No API key and no credit card.
- Not JSONPlaceholder or Open-Meteo.
- Real artwork records: title, artist, date, medium, place of origin, public-domain flag.
- Pagination lets the live page fetch a different artwork each time.

## Screens
- **Collection (`FutureBuilder`)**: one request in `initState` for 12 public-domain artworks. Handles loading, error + Try again, empty, and data (cards).
- **Live (`StreamBuilder`)**: one stream created in `initState`. Every 5 seconds it requests the next page with `limit=1`, so each update is a different real record. A failed request keeps the last artwork on screen with a warning and the stream continues.

## Data model
`Artwork.fromJson` reads `id`, `title`, `artist_display`, `date_display`, `medium_display`, `place_of_origin`, `is_public_domain`.

## Request safety
12-second timeout, status-code check (must be 200), and safe JSON parsing. All failures become a readable `ArtworkException`.

## Design
Simple: a light background and white cards. No remote images.
