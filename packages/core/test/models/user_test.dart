import 'package:core/src/models/user.dart';
import 'package:test/test.dart';

void main() {
  group('User serialization', () {
    final userId = 'cd152bc7-d1eb-4c48-bea5-91f3642cc511';
    final userFirstName = 'David';
    final userLastName = 'Dulce';
    final userEmail = 'david_dulce@ieee.org';
    final userAvatarUrl = 'https://avatars.githubusercontent.com/u/114516037?v=4';

    test('User to json has correct field names', () {
      final u = User(
        id: userId,
        firstName: userFirstName,
        lastName: userLastName,
        email: userEmail,
        avatarUrl: userAvatarUrl,
      );
      final json = u.toJson();

      expect(json['id'], u.id);
      expect(json['first_name'], u.firstName);
      expect(json['last_name'], u.lastName);
      expect(json['email'], u.email);
      expect(json['avatar_url'], u.avatarUrl);
    });

    test('User from json has correct field names', () {
      final json = {
        'id': userId,
        'first_name': userFirstName,
        'last_name': userLastName,
        'email': userEmail,
        'avatar_url': userAvatarUrl,
      };
      final user = User.fromJson(json);

      expect(user.id, json['id']);
      expect(user.firstName, json['first_name']);
      expect(user.lastName, json['last_name']);
      expect(user.email, json['email']);
      expect(user.avatarUrl, json['avatar_url']);
    });
  });
}
