import 'dart:async';

import 'package:core/core.dart';

/// Possible authentication status of the user.
/// - [unknown]: The authentication status is unknown.
/// - [authenticated]: The user is authenticated.
/// - [unauthenticated]: The user is not authenticated.
enum AuthenticationStatus { unknown, authenticated, unauthenticated }

/// {@template authentication_repository}
/// Repository to manage user authentication.
/// {@endtemplate}
abstract base class AuthenticationRepository {
  /// Creates a new user with the provided [firstName], [lastName], [email] and [password].
  Future<Result<void>> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  });

  /// Signs in with the provided [email] and [password].
  Future<Result<void>> signIn({required String email, required String password});

  /// Signs out the current user
  Future<Result<void>> signOut();

  /// Stream of [AuthenticationStatus] which will emit the current status when the authentication state changes.
  Stream<AuthenticationStatus> get status;

  void dispose();
}
