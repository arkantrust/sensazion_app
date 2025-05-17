import 'dart:async';
import 'dart:developer';

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
        data: {
          'first_name': firstName,
          'last_name': lastName,
        }
      );
      _controller.add(AuthenticationStatus.authenticated);
      return const Success.empty();
    } on AuthApiException catch (e) {
      return Failure(Exception(e.code ?? 'Unknown error'));
    } catch (e) {
      log('Error signing in: $e', level: 2000);
      return Failure(Exception(e.toString()));
    }
  }

  @override
  Future<Result> signIn({required String email, required String password}) async {
    try {
      var res = await _supabase.auth.signInWithPassword(email: email, password: password);
      if (res.session == null) return Failure(Exception('No session found'));
      _controller.add(AuthenticationStatus.authenticated);
      return const Success.empty();
    } on AuthApiException catch (e) {
      return Failure(Exception(e.code ?? 'Unknown error'));
    } catch (e) {
      log('Error signing in: $e', level: 2000);
      return Failure(Exception(e.toString()));
    }
  }

  @override
  Future<Result> signOut() async {
    try {
      await _supabase.auth.signOut();
      _controller.add(AuthenticationStatus.unauthenticated);
      return const Success.empty();
    } on AuthApiException catch (e) {
      return Failure(Exception(e.code ?? 'unknown'));
    } catch (e) {
      log('Error signing in: $e', level: 2000);
      return Failure(Exception(e.toString()));
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
