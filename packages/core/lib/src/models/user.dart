import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// {@template user}
/// User model
///
/// [User.empty] represents an unauthenticated user.
/// {@endtemplate}
// dart run build_runner build -d
@freezed
abstract class User with _$User {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory User({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    @Default(User.defaultAvatarUrl) String avatarUrl,
  }) = _User;

  static const String defaultAvatarUrl = 'https://avatars.sensazionapp.ddulce.app/unknown.avif';

  /// Empty user represents an unauthenticated user.
  static const empty = User(id: '', firstName: '', lastName: '', email: '');

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
