# ArtVault — Defense Guide

Answer these in your own words.

1. **Why this API?** Free, JSON, no key or card, not an excluded API, and it has real records plus pagination.
2. **What is a REST API?** An app sends an HTTP GET request and receives JSON.
3. **What does `FutureBuilder` do?** It shows one asynchronous result: loading, error, or data. `CollectionPage` uses it.
4. **Why is the Future created in `initState`, not `build`?** `build` can run many times; a Future created there would repeat the request. It is recreated only when the user taps Try again.
5. **What does `StreamBuilder` do?** It rebuilds each time a new event arrives. `LivePage` uses it for the 5-second artwork updates.
6. **How does the stream survive a failed request?** `watchLiveFeed` catches the exception and puts the message inside `LiveFeedState.error`. The timer is not cancelled, so it keeps ticking. The last artwork stays, and the next good request clears the error.
7. **Why check the status code?** A server can answer with an error. Only 200 is accepted.
8. **Why use a timeout?** So a slow or missing network becomes an error instead of waiting forever (12 seconds).
9. **What does `fromJson` do?** It turns a JSON map into a typed `Artwork`, with fallbacks for missing fields.
10. **How does it handle airplane mode?** Network errors become `ArtworkException`. The UI shows an error and Try again, or a warning card on the live page. Nothing crashes.
11. **How is it modular (Atomic Design)?** Atoms are tiny widgets (`SubText`), molecules combine atoms (`ErrorMessage`), organisms are sections (`ArtworkCard`), templates only lay out pages (`ScreenLayout`), and pages hold the state and call the service.
12. **Why does `HomePage` create the service?** Both pages share one HTTP client, and it is closed when the app closes.

## Demo order
1. Collection: loading, cards, tap a card for details.
2. Live: wait for at least three updates.
3. Airplane mode on: error or warning, no crash.
4. Airplane mode off: recovery.
