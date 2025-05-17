import 'dart:async';
import 'package:core/core.dart';

abstract base class UserRepository {
  Future<Result<User?>> getUser();

  void dispose();
}
