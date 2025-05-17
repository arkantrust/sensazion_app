import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show SupabaseClient;
import 'package:core/core.dart';
import 'user_repository.dart';

final class SupabaseUserRepository extends UserRepository {
  SupabaseUserRepository({required SupabaseClient supabase}) : _supabase = supabase;

  final SupabaseClient _supabase;

  User? _user;

  @override
  Future<Result<User?>> getUser() async {
    if (_user != null) return Success(_user);

    var userId = _supabase.auth.currentUser?.id;
    if (userId == null) return Success(null);

    List<Map<String, dynamic>> data = [];
    try {
      data = await _supabase
          .from('profiles')
          .select('id, first_name, last_name, email, avatar_url')
          .eq('id', userId);
    } catch (e) {
      debugPrint('Error: ${e.toString()}');
    }
    if (data.isEmpty) return Success(null);
    _user = User.fromJson(data[0]);
    return Success(_user);
  }

  @override
  Future<void> dispose() async {
    _user = null;
  }
}
