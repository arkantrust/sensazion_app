import 'dart:async';

import 'package:core/core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:authentication_repository/authentication_repository.dart';

/// {@template authentication_repository}
/// Repository which manages user authentication through Supabase.
/// This repository uses the [SupabaseClient] to manage authentication.
/// This repository is a wrapper around the [SupabaseClient] to provide a simple interface for authentication.
/// {@endtemplate}
final class SupabaseAuthenticationRepository extends AuthenticationRepository {
  final SupabaseClient _supabase;

  final _controller = StreamController<AuthenticationStatus>();

  SupabaseAuthenticationRepository({required SupabaseClient supabase}) : _supabase = supabase;

  @override
  Future<Result> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {'first_name': firstName, 'last_name': lastName},
      );
      _controller.add(AuthenticationStatus.authenticated);
      return const Success.empty();
    } on AuthWeakPasswordException {
      return Failure(const WeakPassword());
    } on AuthApiException catch (e) {
      if (e.code == 'user_already_exists') {
        return Failure(const EmailAlreadyExists());
      }
      rethrow;
    } on AuthRetryableFetchException {
      final connected = await hasInternetAccess();
      if (!connected) {
        return Failure(const NoInternetConnection());
      } else {
        return Failure(const ServerUnreachable());
      }
    } catch (e, s) {
      return Failure.unknown(e, s);
    }
  }

  @override
  Future<Result> signIn({required String email, required String password}) async {
    try {
      var res = await _supabase.auth.signInWithPassword(email: email, password: password);
      if (res.session == null) return Failure(const NoSessionFound());
      _controller.add(AuthenticationStatus.authenticated);
      return const Success.empty();
    } on AuthApiException catch (e) {
      if (e.code == 'invalid_credentials') {
        // if exists, WrongPassword
        // else, EmailNotFound
        List<Map<String, dynamic>> data = await _supabase
            .from('profiles')
            .select('id')
            .eq('email', email);
        return Failure(data.isEmpty ? const EmailNotFound() : const WrongPassword());
      }
      rethrow;
    } on AuthRetryableFetchException {
      final connected = await hasInternetAccess();
      if (!connected) {
        return Failure(const NoInternetConnection());
      } else {
        return Failure(const ServerUnreachable());
      }
    } catch (e, s) {
      return Failure.unknown(e, s);
    }
  }

  @override
  Future<Result> signOut() async {
    try {
      await _supabase.auth.signOut();
      _controller.add(AuthenticationStatus.unauthenticated);
      return const Success.empty();
    } on AuthRetryableFetchException {
      final connected = await hasInternetAccess();
      if (!connected) {
        return Failure(const NoInternetConnection());
      } else {
        return Failure(const ServerUnreachable());
      }
    } catch (e, s) {
      return Failure.unknown(e, s);
    }
  }

  @override
  Stream<AuthenticationStatus> get status async* {
    yield AuthenticationStatus.unauthenticated;
    _supabase.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      if (event == AuthChangeEvent.signedIn || event == AuthChangeEvent.tokenRefreshed) {
        _controller.add(AuthenticationStatus.authenticated);
      } else if (event == AuthChangeEvent.signedOut) {
        _controller.add(AuthenticationStatus.unauthenticated);
      }
    });
    yield* _controller.stream;
  }

  @override
  Future<void> dispose() async {
    await _controller.close();
  }
}
