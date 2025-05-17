class AuthenticationFailure implements Exception {
  final String message;

  const AuthenticationFailure._(this.message);

  factory AuthenticationFailure.wrongPassword() =>
      const AuthenticationFailure._('Wrong password provided.');

  factory AuthenticationFailure.unknownEmail() =>
      const AuthenticationFailure._('Unknown email address.');

  factory AuthenticationFailure.noInternetConnection() =>
      const AuthenticationFailure._('No internet connection.');

  factory AuthenticationFailure.unknown([String? details]) =>
      AuthenticationFailure._('Unknown authentication error.${details != null ? ' $details' : ''}');

  @override
  String toString() => 'AuthenticationFailure: $message';
}
