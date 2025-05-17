import 'dart:async';

import 'package:core/core.dart';
import 'user_repository.dart';

final class FakeUserRepository extends UserRepository {
  User? _user;

  @override
  Future<Result<User?>> getUser() async {
    if (_user != null) return Success(_user);
    return Future.delayed(const Duration(milliseconds: 300), () {
      const u = User(
        id: 'cd152bc7-d1eb-4c48-bea5-91f3642cc511',
        firstName: 'David',
        lastName: 'Dulce',
        email: 'david_dulce@ieee.org',
      );
      _user = u;
      return const Success(u);
    });
  }

  // Removed _getUser method and inlined as an anonymous function in getUser
  @override
  Future<void> dispose() async {
    _user = null;
  }
}
