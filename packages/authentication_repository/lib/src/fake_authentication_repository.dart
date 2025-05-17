import 'dart:async';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:core/core.dart';

final class FakeAuthenticationRepository extends AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  @override
  Future<Result> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.authenticated),
    );
    return const Success.empty();
  }

  @override
  Future<Result> signIn({required String email, required String password}) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.authenticated),
    );
    return const Success.empty();
  }

  @override
  Future<Result> signOut() async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.unauthenticated),
    );
    return const Success.empty();
  }

  @override
  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  @override
  void dispose() => _controller.close();
}
