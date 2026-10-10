/// One readable error type for every API problem.
class ArtworkException implements Exception {
  ArtworkException(this.message);

  final String message;

  /// Turns any error into a sentence the user can read.
  static String messageFor(Object? error) {
    if (error is ArtworkException) return error.message;
    return 'Something went wrong. Please try again.';
  }

  @override
  String toString() => message;
}
